//
//  AcceptButtonView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/16/21.
//

import SwiftUI

struct AcceptButtonView: View {
    
    var action: () -> Void
    
    var body: some View {
       
        Button(action: action, label: {
            HStack(spacing: 0){
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
                    .font(Font.subheadline.weight(.medium))
                    .padding(.trailing, 2)
                Text("Accept")
                    .foregroundColor(.white)
                    .fontWeight(.regular)
                    .font(.subheadline)
                    .padding(.trailing, 1)
            }
        })
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color(UIColor(red: 29/255, green: 161/255, blue: 252/255, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 0))
        
    }
}

struct AcceptButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AcceptButtonView {}
    }
}
