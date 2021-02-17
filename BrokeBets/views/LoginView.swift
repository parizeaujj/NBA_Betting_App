//
//  LoginView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/17/21.
//

import SwiftUI
import FirebaseAuth
import AuthenticationServices

struct LoginView: View {
    
    @State var currentNonce: String?
    
    var body: some View {
        
        ZStack{
            
            Color(UIColor.systemBlue)
            
            VStack {
                
                Image("brokeBetsLoginLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .padding(.top, 100)
                
                
                SignInWithAppleButton(
                    onRequest: { request in
                        
                        let nonce = String.randomNonceString()
                        currentNonce = nonce
                        request.requestedScopes = [.fullName, .email]
                        request.nonce = nonce.sha256
                    },
                    onCompletion: { result in
                        
                        // code snippet via https://medium.com/better-programming/sign-in-with-apple-firebase-auth-swiftui2-0-5e007f1e5a53
                        switch result {
                        case .success(let authResults):
                            switch authResults.credential {
                            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                                
                                guard let nonce = currentNonce else {
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
                                
                                //Sending Request to Firebase
                                Auth.auth().signIn(with: credential) { (authResult, error) in
                                    if (error != nil) {
                                        // Error. If error.code == .MissingOrInvalidNonce, make sure
                                        // you're sending the SHA256-hashed nonce as a hex string with
                                        // your request to Apple.
                                        print(error?.localizedDescription as Any)
                                        return
                                    }
                                    // User is signed in to Firebase with Apple.
                                    print("you're in")
                                }
                                
                                //Prints the current userID for firebase
                                print("\(String(describing: Auth.auth().currentUser?.uid))")
                            default:
                                break
                                
                            }
                        default:
                            break
                        }
                    }
                )
                .frame(width: 280, height: 45)
                .padding(.top, 80)
                
                
                SignInWithGoogleButton()
                    .frame(width: 280, height: 45)
                    .padding(.top, 15)
                Spacer()
            }
        }.edgesIgnoringSafeArea(.all)
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

