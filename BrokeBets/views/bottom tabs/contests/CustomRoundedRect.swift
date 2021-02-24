//
//  CustomRoundedRect.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/23/21.
//

import SwiftUI

struct CustomRoundedRect: View {
    
    private let tabColor: Color
    
    init(tabColor: Color){
        self.tabColor = tabColor
    }
    
    var body: some View {
        
        ZStack(alignment: .leading){
            
            Rectangle()
                .fill(tabColor)
                .frame(width: 10, height: .infinity, alignment: .leading)
               
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.black.opacity(0.65), lineWidth: 1.2)
                .frame(width: .infinity, height: .infinity, alignment: .center)
        }
        .clipShape(
            RoundedRectangle(cornerRadius: 5)
        )
    }
}

struct CustomRoundedRect_Previews: PreviewProvider {
    static var previews: some View {
        CustomRoundedRect(tabColor: .red)
    }
}
