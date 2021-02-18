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
    
    @EnvironmentObject var userService : UserService
    
    var body: some View {
        
        ZStack{
            
            Color(UIColor.systemBlue).opacity(0.95)
            
            VStack {
                
                Image("brokeBetsLoginLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .padding(.top, 100)
                    
                Spacer()
               
                SignInWithAppleButton(
                    onRequest: { request in
                        userService.startSignInWithAppleFlow(request)
                    },
                    onCompletion: { result in
                        userService.finishSignInWithAppleFlow(result)
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
        LoginView()
            .environmentObject(UserService())
    }
}

