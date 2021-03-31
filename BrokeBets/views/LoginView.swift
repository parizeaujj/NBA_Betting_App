//
//  LoginView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/17/21.
//

import SwiftUI
import FirebaseAuth
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
               
                SignInWithAppleButton(
                    onRequest: { request in
                        appState.userService.startSignInWithAppleFlow(request)
                    },
                    onCompletion: { result in
                        appState.userService.finishSignInWithAppleFlow(result)
                    }
                )
                .signInWithAppleButtonStyle(.white)
                .frame(width: 280, height: 45)
                .padding(.bottom, 210)
                
                
                // not implemented yet
//                SignInWithGoogleButton()
//                    .frame(width: 280, height: 45)
//                    .padding(.top, 15)
//
//                Spacer()
                
            }
        }.edgesIgnoringSafeArea(.all)
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView<MockAppState>()
            .environmentObject(MockAppState())
    }
}

