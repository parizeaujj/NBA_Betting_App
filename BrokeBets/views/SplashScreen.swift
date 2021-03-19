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


            Image("Logo")
               // 545 × 477
                .resizable()
                .frame(width: 181, height: 159)
//                .transition(AnyTransition.move(edge: .top))
            
//                    .animation(Animation.easeOut.speed(0.25))
//                    .animation(Animation.easeOut.speed(0.25))
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 160, height: 160)
////                    .padding(.top, 100)


        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
