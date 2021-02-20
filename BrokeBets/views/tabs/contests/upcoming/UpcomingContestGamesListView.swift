//
//  UpcomingContestBetslip.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/19/21.
//

import SwiftUI


struct UpcomingContestGamesListView : View {
    

    var games: [UpcomingContestGame]
    
    var body: some View {
        
        VStack(spacing: 0){
            
            VStack(alignment: .leading){
                
                HStack{
                    Text("Opponent:")
                        .font(.title3)
                    Text("Cody123")
                        .font(.title3)
                        .foregroundColor(.blue)
                        .fontWeight(.bold)
                }
                
                HStack{
                    Text("Number of bets:")
                        .font(.title3)
                    Text("10")
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

                    ForEach(games) { game in

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
        UpcomingContestGamesListView(games: [UpcomingContestGame(homeTeam: "HOU Rockets", awayTeam: "CLE Cavaliers", gameStartDateTime: Date(), specialDayType: .Today, overUnderBet: "OVER 225", spreadBet: "HOU -7")
        ]
        )
    }
}

