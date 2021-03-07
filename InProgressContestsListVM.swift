//
//  InProgressContestsListVM.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/6/21.
//

import Combine

class InProgressContestsListVM: ObservableObject {
    
    @Published var inProgressContests: [InProgressContest] = []
    
    private let inProgressContestsRepo: InProgressContestsRepositoryProtocol
    
    private var cancellables: [AnyCancellable] = []
    
    init(inProgressContestsRepo: InProgressContestsRepositoryProtocol = InProgressContestsRepository()){
        
        self.inProgressContestsRepo = inProgressContestsRepo
        
        // setups up subscriber that listens for changes to the upcoming contests that are stored in 'inProgressContestsRepo'
        inProgressContestsRepo.inProgressContestsPublisher
            .sink { contestsDict in
                self.inProgressContests = Array(contestsDict.values)
            }
            .store(in: &cancellables)
        
    }
}
