//
//  SentInvitationsListVM.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/16/21.
//

import Foundation
import Combine

class SentInvitationsListVM: ObservableObject {
    
    @Published var sentInvitations: [SentInvitation] = []
    
    private var sentInvitationsRepo: SentInvitationsRepositoryProtocol
    
    private var cancellables: [AnyCancellable] = []
    
    init(sentInvitationsRepo: SentInvitationsRepositoryProtocol){
        
        print("sent invitations vm initialized")
        
        self.sentInvitationsRepo = sentInvitationsRepo
        
        // setups up subscriber that listens for changes to the upcoming contests that are stored in 'sentInvitationsRepo'
        sentInvitationsRepo.sentInvitationsPublisher
            .sink(receiveValue: { [weak self] sentInvitations in
                
                self?.sentInvitations = sentInvitations.sorted {
                    
                    let timeDiff1: Int
                    let timeDiff2: Int
                    
                    if $0.invitationStatus == .pending {
                       timeDiff1 = Int(abs($0.expirationDateTime!.timeIntervalSinceNow))
                    }
                    else{
                        timeDiff1 = Int(abs($0.rejectedDateTime!.timeIntervalSinceNow))
                    }
                    
                    if $1.invitationStatus == .pending {
                       timeDiff2 = Int(abs($1.expirationDateTime!.timeIntervalSinceNow))
                    }
                    else{
                        timeDiff2 = Int(abs($1.rejectedDateTime!.timeIntervalSinceNow))
                    }
                    
                    
                    if(timeDiff1 == timeDiff2){
                        
                        if($0.invitationStatus == $1.invitationStatus){
                            return $0.invitationId < $1.invitationId
                        }
                       
                        if($0.invitationStatus == .pending && $1.invitationStatus == .rejected){
                            return true
                        }
                        
                        return false
                        
                    }
                    
                    return timeDiff1 < timeDiff2
                
                }
            })
            .store(in: &cancellables)
        
    }
    
    deinit {
        print("sent invitations vm deinitialized")
    }
}

