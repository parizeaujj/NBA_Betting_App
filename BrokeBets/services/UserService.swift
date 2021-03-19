//
//  UserService.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/18/21.
//

import FirebaseAuth
import FirebaseFirestore
import AuthenticationServices


struct User: Identifiable {
    var id = UUID()
    var uid: String
    var username: String?
}


enum UsernameCreationResult: Any {
    case UsernameTaken
    case UserHasUsernameAlready
    case Success
    case Failure
}


protocol UserServiceProtocol {
    
    var user: User? { get set }
    var userPublisher: Published<User?>.Publisher { get }
    var userPublished: Published<User?> { get }
    
    var stillCheckingForUsername: Bool { get set }
    var stillCheckingForUsernamePublisher: Published<Bool>.Publisher { get }
    var stillCheckingForUsernamePublished: Published<Bool>{ get }
    
    var justLoggedIn: Bool { get set }
    var justLoggedInPublisher: Published<Bool>.Publisher { get }
    var justLoggedInPublished: Published<Bool> { get }
    
    
    func currentUserUid() -> String?
    func startSignInWithAppleFlow(_ request: ASAuthorizationAppleIDRequest)
    func finishSignInWithAppleFlow(_ result: Result<ASAuthorization, Error>)
    func setUsernameIfNotTaken(username: String, completion: @escaping (UsernameCreationResult) -> Void)
    func getUsers(startingWith partialStr: String, completion: @escaping ([User]?) -> Void)
    func logout()
}


class MockUserService: ObservableObject, UserServiceProtocol {
    
    @Published var user: User? = nil
    var userPublisher: Published<User?>.Publisher { $user }
    var userPublished: Published<User?>{ _user }
    
    @Published var stillCheckingForUsername: Bool = false
    var stillCheckingForUsernamePublisher: Published<Bool>.Publisher { $stillCheckingForUsername}
    var stillCheckingForUsernamePublished: Published<Bool>{ _stillCheckingForUsername }
    
    @Published var justLoggedIn: Bool = false
    var justLoggedInPublisher: Published<Bool>.Publisher { $justLoggedIn}
    var justLoggedInPublished: Published<Bool>{ _justLoggedIn}
    
    func currentUserUid() -> String? {
        return user?.uid
    }
    
    let mockUsers: [User] = [
    
        User(uid: "userid1", username: "greg_23"),
        User(uid: "userid2", username: "gary45"),
        User(uid: "userid3", username: "sally68_h"),
        User(uid: "userid4", username: "samm_r"),
        User(uid: "userid5", username: "rickyw11")
    
    ]
    
    func startSignInWithAppleFlow(_ request: ASAuthorizationAppleIDRequest){}
    func finishSignInWithAppleFlow(_ result: Result<ASAuthorization, Error>){}
    func setUsernameIfNotTaken(username: String, completion: @escaping (UsernameCreationResult) -> Void){}
    
    
    func getUsers(startingWith partialStr: String, completion: @escaping ([User]?) -> Void){
        
        let foundUsers = self.mockUsers.filter { $0.username!.hasPrefix(partialStr)}
        
        completion(foundUsers)
    }
    
    func logout(){
        print("logout button pressed")
    }
}


class UserService: ObservableObject, UserServiceProtocol {
    
    
    @Published var user: User? = nil
    var userPublisher: Published<User?>.Publisher { $user }
    var userPublished: Published<User?>{ _user }
    
    @Published var stillCheckingForUsername: Bool = false
    var stillCheckingForUsernamePublisher: Published<Bool>.Publisher { $stillCheckingForUsername}
    var stillCheckingForUsernamePublished: Published<Bool>{ _stillCheckingForUsername }
    
    @Published var justLoggedIn: Bool = false
    var justLoggedInPublisher: Published<Bool>.Publisher { $justLoggedIn}
    var justLoggedInPublished: Published<Bool>{ _justLoggedIn}
    
    
    var handle: AuthStateDidChangeListenerHandle?
    
    // database connection
    private let db = Firestore.firestore()
    
    private var currentNonce: String?
    
    
    init(shouldByPassLogin: Bool = false){
        
        print("init.......")
        
        if(!shouldByPassLogin){
            listenForAuthChanges()
        }
    }
    
    func listenForAuthChanges(){
        
        self.handle = Auth.auth().addStateDidChangeListener { auth, user in
            
            if user != nil {
                
                print("user is logged in")
                
                self.user = User(uid: user!.uid, username: nil)
                self.stillCheckingForUsername = true
                
                self.getUsername(){ username in
                    
                    self.user = User(uid: user!.uid, username: username)
                    self.stillCheckingForUsername = false
                }
            }
            else {
                
                print("user is not logged in...")
                self.user = nil
            }
        }
    }
    
    func currentUserUid() -> String? {
        return Auth.auth().currentUser?.uid
    }
    

    func logout(){
        try? Auth.auth().signOut()
    }
    
    func startSignInWithAppleFlow(_ request: ASAuthorizationAppleIDRequest){
        let nonce = String.randomNonceString()
        self.currentNonce = nonce
        request.requestedScopes = [.email]
        request.nonce = nonce.sha256
        
        print("\"start sign in with apple flow\" finished")
    }
    
    
    func finishSignInWithAppleFlow(_ result: Result<ASAuthorization, Error>){
        
        // code snippet via https://medium.com/better-programming/sign-in-with-apple-firebase-auth-swiftui2-0-5e007f1e5a53
        switch result {
        case .success(let authResults):
            switch authResults.credential {
            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                
                guard let nonce = self.currentNonce else {
                    fatalError("Invalid state: A login callback was received, but no login request was sent.")
                }
                guard let appleIDToken = appleIDCredential.identityToken else {
                    fatalError("Invalid state: A login callback was received, but no login request was sent.")
                }
                guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                    print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                    return
                }
                
                //Creating a request for firebase
                let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString,rawNonce: nonce)
                
                self.authenticateWithFirebase(with: credential)
                                
            default:
                break
            }
        default:
            break
        }
        
        print("\"finish sign in with apple flow\" finished")
    }

    func authenticateWithFirebase(with credential: AuthCredential){
        
        //Sending Request to Firebase
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if (error != nil) {
                print(error?.localizedDescription as Any)
                return
            }
           
            self.justLoggedIn = true
            
             print("sign in successful")
             print(Auth.auth().currentUser?.uid ?? "none")
        }
    }
    
    
    
    func getUsername( completion: @escaping (String?) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(nil)
            return
        }
        
        let usernameQuery = db.collection("users").document(uid)
        
        usernameQuery.getDocument(){ (document, error) in
            
            if let error = error {
                fatalError("Error getting username " + error.localizedDescription)
            }
            else {
                
                // if the document is nil then that means the user hasnt created a username yet
                guard let doc = document else {
                    print("user does not have a username yet")
                    completion(nil)
                    return
                }
                
                
                // if the username is not nil then that means the user already has a  username
                if let username = doc.get("username") as? String {
                    print("username found")
                    completion(username)
                }
                else{
                    print("The user does not have a username yet")
                    completion(nil)
                }
            }
        }
    }
    
    
    func setUsernameIfNotTaken(username: String, completion: @escaping (UsernameCreationResult) -> Void){
        
        guard let uid = Auth.auth().currentUser?.uid else {
            fatalError("user has access to 'create username' screen but is not logged in yet")
        }
        
        let uidDocRef = db.collection("users").document(uid)
        let unameDocRef = db.collection("usernames").document(username)
        
        db.runTransaction { (transaction, errorPointer) -> Any? in
            
            let uidDocument: DocumentSnapshot
                do {
                    try uidDocument = transaction.getDocument(uidDocRef)
                } catch let fetchError as NSError {
                    errorPointer?.pointee = fetchError
                    return nil
                }
            
            // if the user already has a username for their account, then we need to not allow them to create a new one, and instead notify them that they
            // already have a username and then take them to the contests screen
            if uidDocument.exists && uidDocument.get("username") != nil {
                return UsernameCreationResult.UserHasUsernameAlready
            }

            let unameDocument: DocumentSnapshot
                do {
                    try unameDocument = transaction.getDocument(unameDocRef)
                } catch let fetchError as NSError {
                    errorPointer?.pointee = fetchError
                    return nil
                }
   
            
            // if the username already has a document in the database and the uid for that document is not nil, then the username is already taken and
            // we should display that error to the user so they can try again with a different username
            if unameDocument.exists && unameDocument.get("uid") != nil {
                return UsernameCreationResult.UsernameTaken
            }
            
            
            // if at this point in the transaction, then that means the username has not been taken and the user does not already have a username
            transaction.setData(["username": username], forDocument: uidDocRef)
            transaction.setData(["uid": uid], forDocument: unameDocRef)
            
            return UsernameCreationResult.Success
            
        } completion: { (res, error) in
            
            var resultType: UsernameCreationResult = .Failure
            
            if error != nil {
                resultType = .Failure
            }
            else if res is UsernameCreationResult {
                resultType = res as! UsernameCreationResult
                
            }
            else{
                resultType = .Failure
            }
            
            completion(resultType)
        }
    }
    
    
    
    func getUsers(startingWith partialStr: String, completion: @escaping ([User]?) -> Void) {
        
        
        let endStr = partialStr + "\u{f8ff}"
        
        let usernameQuery = db.collection("users")
                              .whereField("username", isGreaterThanOrEqualTo: partialStr).whereField("username", isLessThanOrEqualTo: endStr)
                              .whereField("username", isNotEqualTo: self.user!.username!)
        
        usernameQuery.getDocuments(){ (querySnapshot, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No users found")
                completion([])
                return
            }
            
            var users: [User] = []
            
            for document in documents {
                
                let data = document.data()
                
                guard let username = data["username"] as? String else {
                    print("error parsing document from users collection for username field")
                    completion(nil)
                    return
                }
                
                users.append(User(uid: document.documentID, username: username))
            
            }
            print("Num users found: \(users.count)")
            completion(users)
        }
    }
}



extension String {
    
    func getNextLetterInAlphabet() -> String? {
        
        guard let uc = UnicodeScalar(self) else {
            return nil
        }
        switch uc {
            case "A" ..< "Z", "a" ..< "z":
                return String(UnicodeScalar(uc.value + 1)!)
            default:
                return nil
        }
    }
}

