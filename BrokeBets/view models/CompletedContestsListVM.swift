//
//  CompletedContestsListVM.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/27/21.
//

import Combine

class CompletedContestsListVM: ObservableObject {
    
    @Published var completedContests: [CompletedContest] = []
    
    private let completedContestsRepo: CompletedContestsRepositoryProtocol
    
    private var cancellables: [AnyCancellable] = []
    
    
    init(completedContestsRepo: CompletedContestsRepositoryProtocol){
        
        self.completedContestsRepo = completedContestsRepo
        
        // setups up subscriber that listens for changes to the upcoming contests that are stored in 'completedContestsRepo'
        completedContestsRepo.completedContestsPublisher
            .assign(to: \.completedContests, on: self)
            .store(in: &cancellables)
        
    }
}

