//
//  InProgressGamesListView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/5/21.
//

import SwiftUI

struct InProgressContestGamesListView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var inProgressGamesListVM: InProgressContestGamesListVM
        
    
    var body: some View {
        
    
            VStack(spacing: 0){
                                
                VStack(alignment: .leading){
                    
                    HStack{
                        Text("Opponent:")
                            .font(.title3)
                        Text(inProgressGamesListVM.inProgressContest!.opponent)
                            .font(.title3)
                            .foregroundColor(.blue)
                            .fontWeight(.bold)
                    }
                    
                    HStack{
                        Text("Total bets:")
                            .font(.title3)
                        Text("\(inProgressGamesListVM.inProgressContest!.numBets)")
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
                        
                        if let inProgressGames = inProgressGamesListVM.inProgressContest?.inProgressGames {
                            
                            Text("In Progress")
                                .font(.caption)
                                .fontWeight(.bold)
                                .padding(.leading, 15)
                                .padding(.top, 15)
                                .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                                
                            
                            ForEach(inProgressGames) { game in
                                
                                InProgressContestGameView(viewModel: InProgressContestGameVM(game: game, inProgressContestsRepo: self.inProgressGamesListVM.inProgressContestsRepo))
                                    
                                    .padding(.top, 5)
                            }
                            .padding(.horizontal, 10)
                        }
                        
                        if let upcomingGames = inProgressGamesListVM.inProgressContest?.upcomingGames {
                            
                            Text("Upcoming")
                                .font(.caption)
                                .fontWeight(.bold)
                                .padding(.leading, 15)
                                .padding(.top, 15)
                                .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                            
                            ForEach(upcomingGames) { game in
                                
                                UpcomingContestGameView(game: game)
                                    .padding(.top, 5)
                            }
                            .padding(.horizontal, 10)
                        }
                        
                        
                        if let completedGames = inProgressGamesListVM.inProgressContest?.completedGames {
                            
                            Text("Completed")
                                .font(.caption)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .padding(.leading, 15)
                                .padding(.top, 15)
                                .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                            
                            ForEach(completedGames) { game in
                                
                                CompletedContestGameView(game: game)
                                
                            }.padding(.vertical, 4) // 4
                            .padding(.horizontal, 10)
                        }
                    }
                }
            }
            .onReceive(inProgressGamesListVM.contestJustCompletedPublisher, perform: { _ in
                presentationMode.wrappedValue.dismiss() })
        
    }
}

struct InProgressContestGamesListView_Previews: PreviewProvider {
    static var previews: some View {
        
        InProgressContestGamesListView(inProgressGamesListVM: InProgressContestGamesListVM(contestId: "contest1", inProgressContestRepo: MockInProgressContestsRepository()))
                        .environmentObject(UserScreenInfo(.small))
    }
}



