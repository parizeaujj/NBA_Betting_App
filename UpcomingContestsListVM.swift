//
//  File.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/20/21.
//

import Combine

class UpcomingContestsListVM: ObservableObject {
    
    @Published var upcomingContests: [UpcomingContest] = []
    
    private var upcomingContestsRepo: UpcomingContestsRepositoryProtocol = MockUpcomingContestsRepository()
    

    private var cancellables: [AnyCancellable] = []
    
    init(){
    
        upcomingContestsRepo.upcomingContestsPublisher
            .assign(to: \.upcomingContests, on: self)
            .store(in: &cancellables)
        
    }
}
