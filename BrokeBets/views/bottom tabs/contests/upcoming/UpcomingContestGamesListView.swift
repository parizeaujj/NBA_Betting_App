//
//  UpcomingContestBetslip.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/19/21.
//

import SwiftUI


struct UpcomingContestGamesListView : View {

    var contest: UpcomingContest
    
    @EnvironmentObject var userScreenInfo: UserScreenInfo
    
    var body: some View {
        
        VStack(spacing: 0){
            
            VStack(alignment: .leading){
                
                HStack{
                    Text("Opponent:")
                        .font(userScreenInfo.gamesListViewFonts.oppTitleFont)
                    Text(contest.opponent)
                        .font(userScreenInfo.gamesListViewFonts.oppNameFont)
                        .foregroundColor(.blue)
                        .fontWeight(.bold)
                }
                
                HStack{
                    Text("Total bets:")
                        .font(userScreenInfo.gamesListViewFonts.numBetsTitleFont)
                    Text("\(contest.numBets)")
                        .font(userScreenInfo.gamesListViewFonts.numBetsValueFont)
                        .fontWeight(.bold)
                }.padding(.top, 4)
                
             }
            .padding(.vertical)
            .padding(.leading, 20)
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
            contest: UpcomingContest(data: MockUpcomingContestsRepository(uid: "testToddUid").mockData[0], playerUid: "testToddUid")!
        )
        .environmentObject(UserScreenInfo(.regular))
    }
}


