//
//  SplashScreen.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/18/21.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        
        ZStack{

            Color(UIColor.systemBlue)

//            Image("splashLogo")
            
//            Image("bbLogo")

            Image("bbLogoPDF")
//                .resizable()
////                .scaledToFit()
//                .frame(width: 150, height: 150)
//                .overlay(Rectangle().stroke().frame(width: 80, height: 100
//                ).offset(x: 2, y: -8))
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
