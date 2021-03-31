//
//  LoadingView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/18/21.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(UIColor.systemBlue)
              
            VStack{
                
                Image("largeLogo")
                    .resizable()
                    .frame(width: 150, height: 150)
//                Image("brokeBetsLoginLogo")
//                Image("bbLogoPDF")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 200, height: 200) // 300, 300
                    .padding(.top, 150)
                
                Spacer()
            }
            
            ProgressView()
            .scaleEffect(1.4, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: .white))

        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
