//
//  UserService.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/18/21.
//

import FirebaseAuth
import AuthenticationServices

class UserService: ObservableObject {
    
    @Published var isLoggedIn: Bool = false
    
    private var currentNonce : String?
    
    init(){
        
        Auth.auth().addStateDidChangeListener { auth, user in
            
            if user != nil {
                self.isLoggedIn = true
            }
            else {
                self.isLoggedIn = false
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
}
