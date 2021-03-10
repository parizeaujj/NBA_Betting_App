//
//  DraftBetCapsule.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/10/21.
//

import SwiftUI

struct DraftBetCapsule: View{

    var label: String
    var strokeColor: Color
    var fillColor: Color
    var textColor: Color
    
    init(label: String, isDisabled: Bool) {
        
        self.label = label
        
        if(isDisabled){
            self.strokeColor = Color.clear
            self.fillColor = Color.black.opacity(0.08)
            self.textColor = Color.white.opacity(0.8)
        }
        else{
            self.strokeColor = Color.blue
            self.fillColor = Color.white
            self.textColor = Color.black
        }
    }

    var body: some View {

        Text("\(self.label)")
            .font(.subheadline)
            .foregroundColor(self.textColor)
            .frame(minWidth: 73)
            .padding(.vertical, 4)
            .padding(.horizontal, 10)
            .background(self.fillColor)
            .clipShape(Capsule())
            .overlay(Capsule().strokeBorder(self.strokeColor, lineWidth: 1.0))
            .padding(.horizontal, 11)
    }
}

struct DraftBetCapsule_Previews: PreviewProvider {
    static var previews: some View {
        DraftBetCapsule(label: "HOU -4", isDisabled: false)
    }
}
