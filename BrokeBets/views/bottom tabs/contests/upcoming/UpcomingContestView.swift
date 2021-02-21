//
//  UpcomingContestView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/17/21.
//

import SwiftUI

struct UpcomingContestView: View {
    
    var opponent: String = "Cody1234"
    var upcomingContest: UpcomingContest
    
    init(upcomingContest: UpcomingContest){
        self.upcomingContest = upcomingContest
    }
    
    var body: some View {
        
        
        NavigationLink(destination: UpcomingContestGamesListView(contest: upcomingContest)
                        .navigationBarTitle("Contest Betslip", displayMode: .inline))
        {
            HStack {
                VStack {
                    HStack {
                        Text("Opponent:")
                        
                        Text("\(upcomingContest.opponent)")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        
                        Spacer()
                        
                        Text("Total bets:")
                            .font(.subheadline)
                        
                        Text("\(upcomingContest.numBets)")
                            .font(.subheadline)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(.trailing, 15)
                        
                    }
                    .padding(.bottom, 15)
                    
                    
                    HStack {
                        Text("First game start: ")
                            .font(.subheadline)
                        Text("\(upcomingContest.firstGameStartDateTime)")
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
}



struct UpcomingContestView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        UpcomingContestView(upcomingContest: UpcomingContest(id: "dodkokok", opponent: "MattSmith22", firstGameStartDateTime: "Today at 8:45pm EST", numBets: 10, games: [
            
                UpcomingContestGame(homeTeam: "HOU Rockets", awayTeam: "CLE Cavaliers", gameStartDateTime: Date(), specialDayType: .Today, overUnderBet: "OVER 225", spreadBet: "HOU -7")
        ]
        
        )
        )
    }
}
