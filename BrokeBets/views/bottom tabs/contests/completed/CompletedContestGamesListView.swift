//
//  CompletedContestGamesListView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/28/21.
//

import SwiftUI


struct CompletedContestGamesListView: View {
    
    var contest: CompletedContest
    
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
        CompletedContestGamesListView(contest: CompletedContest(data: MockCompletedContestsRepository().mockData[0], playerUid: "testToddUid")!
        ).environmentObject(UserScreenInfo(.regular))
    }
}
 
 
