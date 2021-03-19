//
//  CreateContestVM.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/7/21.
//

import Foundation
import Combine

import SwiftUI



class CreateContestVM: ObservableObject {
    
    @Published var selectedOpponent: User? = nil
    @Published var isSearchScreenActive = false
    @Published var numRoundsOptions: [Int] = [1]
    @Published var selectedNumRounds: Int = 1
    
    @Published var isLoading: Bool = false
    
    var invitationCreationAttemptFinished = CurrentValueSubject<ContestCreationResult?, Never>(nil)
    var showSuccessNotice = PassthroughSubject<Void, Never>()
    var showErrorPopup = PassthroughSubject<ContestCreationResult, Never>()
    
    private var curMaxRounds = 1
    
    private var cancellables: [AnyCancellable] = []
    
    let createContestInvitationService: CreateContestInvitationServiceProtocol
    let userService: UserServiceProtocol
    
    init(createContestInvitationService: CreateContestInvitationServiceProtocol, userService: UserServiceProtocol){
        
        self.createContestInvitationService = createContestInvitationService
        self.userService = userService
        
        
        self.createContestInvitationService
            .availableGamesPublisher
            .sink { games in
                
                let numAvailableGames = games.count
                
                
                if numAvailableGames != self.curMaxRounds {
                    self.numRoundsOptions = [Int](1...numAvailableGames)
                    self.curMaxRounds = numAvailableGames
                }
            }
            .store(in: &cancellables)
        
    }
    
    func setSelectedUser(user: User?){
        
        self.selectedOpponent = user
        
        self.isSearchScreenActive = false
        
    }
    
    func resetDraftRounds(){
        
        let numAvailableGames = self.createContestInvitationService.availableGames.count
        
        self.selectedNumRounds = 1
        self.numRoundsOptions = [Int](1...numAvailableGames)
        self.curMaxRounds = numAvailableGames
    }
    
    // To be implemented...
    func sendContestInvitation(){
        
        self.isLoading = true
        print("send contest invitation button pressed")
        
        self.createContestInvitationService.createContestInvitation(selectedOpponent: self.selectedOpponent!, numDraftRounds: self.selectedNumRounds){ result in

            self.isLoading = false
            self.invitationCreationAttemptFinished.send(result)
        }
        
        
    }
}
