//
//  ChosenOpponentChip.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/5/21.
//

import SwiftUI

struct ChosenOpponentChip: View {
    
    
    private var username: String
    
    init(username: String){
        self.username = username
    }
    
    var body: some View {
        
        HStack{
            Text("\(username)")
                .fontWeight(.semibold)
                .foregroundColor(.white)
            Image(systemName: "pencil")
                .font(Font.body.weight(.semibold))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.blue)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 0))
    }
}

struct ChosenOpponentChip_Previews: PreviewProvider {
    static var previews: some View {
        ChosenOpponentChip(username: "CodyShowstoppa")
    }
}
