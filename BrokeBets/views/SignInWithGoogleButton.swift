//
//  SignInWithGoogleButton.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/17/21.
//

import SwiftUI
import GoogleSignIn

struct SignInWithGoogleButton: UIViewRepresentable {

  func makeUIView(context: Context) -> GIDSignInButton {
    
    let button = GIDSignInButton()
    button.style = .wide
    button.colorScheme = .light
    return button
  }

  func updateUIView(_ uiView: UIViewType, context: Context) {
  }
}

struct SignInWithGoogleButton_Previews: PreviewProvider {
  static var previews: some View {
    SignInWithGoogleButton()
  }
}
