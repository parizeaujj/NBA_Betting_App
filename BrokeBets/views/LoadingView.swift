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
                Image("brokeBetsLoginLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .padding(.top, 100)
                
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
