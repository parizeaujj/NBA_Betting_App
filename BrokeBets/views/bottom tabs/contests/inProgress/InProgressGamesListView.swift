//
//  InProgressGamesListView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/5/21.
//

import SwiftUI
import Combine

class InProgressContestGamesListVM: ObservableObject {
    
    private var inProgressContestRepo: InProgressContestsRepositoryProtocol
    private var cancellables: [AnyCancellable] = []
    
    @Published var inProgressContest: InProgressContest? = nil
    
    var contestJustCompletedPublisher = PassthroughSubject<Void, Never>()
    //    @Published var contestJustCompleted: Bool = false
    
    init(contestId: String, inProgressContestRepo: InProgressContestsRepositoryProtocol){
        
        self.inProgressContestRepo = inProgressContestRepo
        
        // subscribe
        self.inProgressContestRepo.inProgressContestsPublisher
            .sink { val in
                
                if let v = val[contestId] {
                    
                    // if the in progress contest we are currently storing is nil and or the bets remaining and completed are not the exact same as the new value for the in progress contest, then update it, else ignore the message that said it changed
                    if let ipc = self.inProgressContest {
                        
                        if(ipc.numBetsCompleted != v.numBetsCompleted || ipc.numBetsRemaining != v.numBetsRemaining){
                            self.inProgressContest = v
                        }
                    }
                    else{
                        self.inProgressContest = v
                    }
                }
                else{
                    print("contest was removed from in progress list")
                    self.contestJustCompletedPublisher.send()
                }
            }
            .store(in: &cancellables)
        
    }
}



struct InProgressContestGamesListView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var inProgressGamesListVM: InProgressContestGamesListVM
    @State private var isError: Bool = false
        
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
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .padding(.leading, 15)
                                .padding(.top, 15)
                                .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                                
                            
                            ForEach(inProgressGames) { game in
                                
                                InProgressContestGameView(game: game)
                                    .padding(.top, 5)
                            }
//                            .padding(.top, 5)
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
//                            .padding(.vertical, 4)
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
//                .padding(.top, 15)
                

            }
            .onReceive(inProgressGamesListVM.contestJustCompletedPublisher, perform: { _ in
                presentationMode.wrappedValue.dismiss() })
        
    }
}

struct InProgressContestGamesListView_Previews: PreviewProvider {
    static var previews: some View {
        
        InProgressContestGamesListView(inProgressGamesListVM: InProgressContestGamesListVM(contestId: "contest1", inProgressContestRepo: MockInProgressContestsRepository())
                                       //                                       , contest: InProgressContest(data: MockInProgressContestsRepository().mockData["contest1"]!, playerUid: "testToddUid")!
        )
        .environmentObject(UserScreenInfo(.small))
    }
}



