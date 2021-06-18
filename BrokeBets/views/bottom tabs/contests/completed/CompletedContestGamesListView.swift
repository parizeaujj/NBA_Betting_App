//
//  CompletedContestGamesListView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/28/21.
//

import SwiftUI


struct CompletedContestGamesListView: View {
    
    
//    @EnvironmentObject var userScreenInfo: UserScreenInfo
    
    var contest: CompletedContest
    
    var body: some View {
        
        VStack(spacing: 0){
            
            VStack(alignment: .leading){
                
                HStack{
                    Text("Opponent:")
                        .font(UserScreenInfoV2.current.gamesListViewFonts.oppTitleFont) // was title 3
                    Text(contest.opponent)
                        .font(UserScreenInfoV2.current.gamesListViewFonts.oppNameFont)
                        .foregroundColor(.blue)
                        .fontWeight(.bold)
                }
                
                HStack{
                    Text("Total bets:")
                        .font(UserScreenInfoV2.current.gamesListViewFonts.numBetsTitleFont)
                    Text("\(contest.numBets)")
                        .font(UserScreenInfoV2.current.gamesListViewFonts.numBetsValueFont)
                        .fontWeight(.bold)
                }.padding(.top, 4)
                
             }
            .padding(.vertical)
            .padding(.leading, 20) // was 30
            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
           
            Divider()
                .background(Color.black)
                

            ScrollView {
                LazyVStack {

                    ForEach(contest.games.sorted { $0.gameCompletionDateTime < $1.gameCompletionDateTime}) { game in

                        
                       CompletedContestGameView(game: game)
                        
                    }.padding(.vertical, 4)
                    .padding(.horizontal, 10)
                    
                }
            }
            .padding(.top, 15)

        }
    }
}

struct CompletedContestGamesListView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedContestGamesListView(contest: CompletedContest(data: MockCompletedContestsRepository(uid: "testToddUid").mockData[0], playerUid: "testToddUid")!
        )
//        .environmentObject(UserScreenInfo(.xsmall))
    }
}
 
 
