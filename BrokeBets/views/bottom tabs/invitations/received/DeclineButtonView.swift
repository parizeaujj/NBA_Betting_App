//
//  DeclineButtonView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/16/21.
//

import SwiftUI

struct DeclineButtonView: View {
    var action: () -> Void
    
    var body: some View {
       
        Button(action: action, label: {
            HStack(spacing: 0){
                Image(systemName: "xmark")
                    .foregroundColor(.black)
                    .font(Font.subheadline.weight(.medium))
                    .padding(.trailing, 2)
                Text("Decline")
                    .foregroundColor(.black)
                    .fontWeight(.regular)
                    .font(.subheadline)
                    .padding(.trailing, 1)
            }
        })
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color(UIColor(red: 29/255, green: 161/255, blue: 252/255, alpha: 0.08)))
//        .background(Color.gray.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 1.0))
        
    }
}

struct DeclineButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DeclineButtonView(action: {})
    }
}
