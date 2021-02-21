//
//  UpcomingContestBetslip.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/19/21.
//

import SwiftUI


struct UpcomingContestGamesListView : View {
    

    var contest: UpcomingContest
    
    var body: some View {
        
        VStack(spacing: 0){
            
            VStack(alignment: .leading){
                
                HStack{
                    Text("Opponent:")
                        .font(.title3)
                    Text(contest.opponent)
                        .font(.title3)
                        .foregroundColor(.blue)
                        .fontWeight(.bold)
                }
                
                HStack{
                    Text("Total bets:")
                        .font(.title3)
                    Text("\(contest.numBets)")
                        .font(.title3)
                        .fontWeight(.bold)
                }.padding(.top, 4)
                
             }
            .padding(.vertical)
            .padding(.leading, 30)
            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
           
             
            
            
            Divider()
                .background(Color.black)
                

            ScrollView {
                LazyVStack {

                    ForEach(contest.games) { game in

                        UpcomingContestGameView(game: game)
                        
                    }.padding(.vertical, 4)
                    .padding(.horizontal, 10)
                    
                }
            }
            .padding(.top, 15)
        
       
        }
        
    }
}

struct UpcomingContestGamesListView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingContestGamesListView(
            contest: UpcomingContest(id: "dodkokok", opponent: "MattSmith22", firstGameStartDateTime: "Today at 8:45pm EST", numBets: 10, games: [
                
                    UpcomingContestGame(homeTeam: "HOU Rockets", awayTeam: "CLE Cavaliers", gameStartDateTime: Date(), specialDayType: .Today, overUnderBet: "OVER 225", spreadBet: "HOU -7")
            ]
            
            )
        )
    }
}
