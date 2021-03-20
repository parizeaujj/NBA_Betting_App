//
//  InProgressContestGamesListVM.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/6/21.
//

import Combine

class InProgressContestGamesListVM: ObservableObject {
    
    let contestId: String
    let inProgressContestsRepo: InProgressContestsRepositoryProtocol
    private var cancellables: [AnyCancellable] = []
    
    @Published var inProgressContest: InProgressContest? = nil
    
    var contestJustCompletedPublisher = PassthroughSubject<Void, Never>()
        
    init(contestId: String, inProgressContestRepo: InProgressContestsRepositoryProtocol){
        
        self.contestId = contestId
        self.inProgressContestsRepo = inProgressContestRepo
        
        // subscribe
        self.inProgressContestsRepo.inProgressContestsPublisher
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
