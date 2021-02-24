//
//  UserService.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/18/21.
//

import FirebaseAuth
import FirebaseFirestore
import AuthenticationServices


enum UsernameCreationResult: Any {
    case UsernameTaken
    case UserHasUsernameAlready
    case Success
    case Failure
}


class UserService: ObservableObject {
    
    @Published var isLoggedIn: Bool = false
    @Published var doesHaveUsername: Bool = false
    private var username: String?
    
    // database connection
    private let db = Firestore.firestore()
    
    private var currentNonce : String?
    
    init(){
        
        Auth.auth().addStateDidChangeListener { auth, user in
            
            if user != nil {
                
                print("user is logged in")
                                
                self.getUsername(){ username in
                    
                    if username != nil {
                        self.username = username
                        self.doesHaveUsername = true
                    }
                    self.isLoggedIn = true
                }
            }
            else {
                self.isLoggedIn = false
                self.username = nil
                self.doesHaveUsername = false
            }
        }
    }
    
    
    func logout(){
        try? Auth.auth().signOut()
    }
    
    func startSignInWithAppleFlow(_ request: ASAuthorizationAppleIDRequest){
        let nonce = String.randomNonceString()
        self.currentNonce = nonce
        request.requestedScopes = [.fullName, .email]
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
                let credential = OAuthProvider.credential(withProviderID: "apple.com",idToken: idTokenString,rawNonce: nonce)
                
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
    
    
    func setUsernameIfNotTaken(username: String, completion: @escaping (UsernameCreationResult) -> Void) -> Void {
        
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
}
