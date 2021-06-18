//
//  LoginView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/17/21.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn
import AuthenticationServices


struct LoginView<T: AppStateProtocol >: View {
    
    @EnvironmentObject var appState: T
    
    var body: some View {
        
        ZStack{
            
            Color(UIColor.systemBlue)
//                .opacity(0.95)
            
            VStack {
                
                Image("largeLogo")
                    .resizable()
                    .frame(width: 150, height: 150)
//                    .resizable()
//                    .scaleEffect(0.3)
////                    .resizable()
//                    .scaleEffect(2.0)
//                Image("bbLogoPDF")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 200, height: 200) // 300, 300
                    .padding(.top, 150)
                    
                Spacer()
               
                SignInWithAppleButton(.continue,
                    onRequest: { request in
                        appState.userService!.startSignInWithAppleFlow(request)
                    },
                    onCompletion: { result in
                        appState.userService!.finishSignInWithAppleFlow(result)
                    }
                )
                .signInWithAppleButtonStyle(.white)
                .frame(width: UserScreenInfoV2.current.continueWithButtonWidth, height: 45)
                
               
                
//                .padding(.bottom, 210)
//                    .padding(.top, 65)
                
                
                // not implemented yet
                SignInWithGoogleButton()
                    .padding(.top, 15)
                    .padding(.bottom, UIScreen.main.bounds.height / 6.0)
//
//                Spacer()
                
            }
            .onAppear(perform: {
    
                print("width: \(UserScreenInfoV2.current.continueWithButtonWidth!)")
                print("type: \(UserScreenInfoV2.current.screenSizeType)")
                print("device: \(UIDevice.current.name.trimmingCharacters(in: .whitespacesAndNewlines))")
            })
        }.edgesIgnoringSafeArea(.all)
    }
}

struct SignInWithGoogleButton: View {
    
    var body: some View {
        
        Button(action: {
            
            GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
            GIDSignIn.sharedInstance().signIn()
            
            
        }, label: {
            
            HStack{
                Image("googleLogo")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 25, height: 25)
                
                
                Text("Continue with Google")
                    .fontWeight(.medium)
                    .foregroundColor(.black)
            }
            .frame(width: UserScreenInfoV2.current.continueWithButtonWidth, height: 45)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 5.0))
            
        })
        
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView<MockAppState>()
            .environmentObject(MockAppState())
    }
}

