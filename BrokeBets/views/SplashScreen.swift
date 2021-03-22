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

            Image("splashLogo")

        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
