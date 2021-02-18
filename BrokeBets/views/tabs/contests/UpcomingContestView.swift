//
//  UpcomingContestView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/17/21.
//

import SwiftUI

struct UpcomingContestView: View {
    
    private var opponent: String = "Cody1234"
    
    var body: some View {
        
            HStack {
                VStack {
                    HStack {
                        Text("Opponent:")
                   
                        Text("\(self.opponent)")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        
                        Spacer()
                        
                        Text("Number of bets:")
                            .font(.subheadline)
                        
                        Text("10")
                            .font(.subheadline)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(.trailing, 15)
                        
                    }
                    .padding(.bottom, 15)
                    
                    
                    HStack {
                        Text("First game start: ")
                            .font(.subheadline)
                        Text("Today at 4pm EST")
                            .fontWeight(.bold)
                            .font(.subheadline)
                        Spacer()
                    }
                }
                
                
                Image(systemName: "chevron.right")
                    .font(.system(.footnote))
                    
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.black.opacity(0.65), lineWidth: 1.2)
            )
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
    }
}


struct UpcomingContestView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingContestView()
    }
}
