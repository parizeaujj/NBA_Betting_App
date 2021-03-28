//
//  ReceivedInvitationsListVM.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/16/21.
//

import Combine
import SwiftUI

class ReceivedInvitationsListVM: ObservableObject {
    
    @Published var receivedInvitations: [ReceivedInvitation] = []
    
    @Published var isLoading: Bool = false
    
    private var receivedInvitationsRepo: ReceivedInvitationsRepositoryProtocol
    
    private var cancellables: [AnyCancellable] = []
    
    var didHaveError = PassthroughSubject<String, Never>()
    
    
    
    init(receivedInvitationsRepo: ReceivedInvitationsRepositoryProtocol){
        
        print("recieved invitations repo initialized")
        
        self.receivedInvitationsRepo = receivedInvitationsRepo
        
        // setups up subscriber that listens for changes to the upcoming contests that are stored in 'receivedInvitationsRepo'
        receivedInvitationsRepo.receivedInvitationsPublisher
            .sink(receiveValue: { [weak self] receivedInvitations in
                                    
                self?.receivedInvitations = receivedInvitations.sorted {
                        
                        if($0.expirationDateTime == $1.expirationDateTime){
                            return $0.invitationId < $1.invitationId
                        }
                        
                        return $0.expirationDateTime < $1.expirationDateTime
                    }
            })
            .store(in: &cancellables)
    }
    
    func acceptInvitation(invitation: ReceivedInvitation){
        
        self.isLoading = true
        
        self.receivedInvitationsRepo.acceptInvitation(invitation: invitation){ result in
            
            self.isLoading = false
            
            switch(result){
                case .success():
                print("successfully accepted invitation and created corresponding draft")
            case .failure(_):
                print("failed to accept invitation and create draft")
                self.didHaveError.send("Error accepting invitation, please try again.")
            }
        }
    }
    
    func rejectInvitation(invitation: ReceivedInvitation){
        
        self.isLoading = true
        
        self.receivedInvitationsRepo.rejectInvitation(invitation: invitation){ result in
            
            self.isLoading = false
            
            switch(result){
                case .success():
                print("successfully rejected invitation")
            case .failure(_):
                print("failed to reject invitation")
                self.didHaveError.send("Error declining invitation, please try again.")
            }
        }
    }
}
