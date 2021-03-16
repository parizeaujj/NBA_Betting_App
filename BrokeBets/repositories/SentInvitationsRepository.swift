//
//  SentInvitationsRepository.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/16/21.
//

import Foundation

import FirebaseFirestore

protocol SentInvitationsRepositoryProtocol {

    var sentInvitations: [SentInvitation] { get }
    var sentInvitationsPublisher: Published<[SentInvitation]>.Publisher { get }
    var sentInvitationsPublished: Published<[SentInvitation]> { get }
    
    func getSentInvitations(uid: String) -> Void
}

class MockSentInvitationsRepository: SentInvitationsRepositoryProtocol, ObservableObject {
    
    @Published var sentInvitations: [SentInvitation] = []
    var sentInvitationsPublished: Published<[SentInvitation]> { _sentInvitations }
    var sentInvitationsPublisher: Published<[SentInvitation]>.Publisher { $sentInvitations }
    
  
    let mockData: [[String: Any]] = [
        
        [
            "invitationId": "invitationId1",
            "invitee_uid": "testToddUid",
            "invitee_uname":  "todd123",
            "recipient_uid": "testUID1",
            "recipient_uname": "codyshowstoppa",
            "invitationStatus": "pending",
            "expirationDateTime": Timestamp(date: Date() + 6*60*60),
            "draftRounds": 2
        ],
        [
            "invitationId": "invitationId2",
            
            "invitee_uid": "testToddUid",
            "invitee_uname":  "todd123",
            "recipient_uid": "testUID2",
            "recipient_uname": "greg444",
            
            "invitationStatus": "rejected",
            "rejectedDateTime": Timestamp(date: Date() - 24*60*60),
            "draftRounds": 3
        ],
        [
            "invitationId": "invitationId3",
            "invitee_uid": "testToddUid",
            "invitee_uname":  "todd123",
            "recipient_uid": "testUID3",
            "recipient_uname": "matt_smith2",
            "invitationStatus": "pending",
            "expirationDateTime": Timestamp(date: Date() + 20*60*60),
            "draftRounds": 6
        ],
    ]
    
    init(uid: String){
        getSentInvitations(uid: uid)
    }
    
    func getSentInvitations(uid: String){
        
        self.sentInvitations = self.mockData.map{ invitation in
            SentInvitation(data: invitation)!
        }
        
    }
}
