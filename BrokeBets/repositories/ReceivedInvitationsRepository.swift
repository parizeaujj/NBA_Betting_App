//
//  ReceivedInvitationsRepository.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/16/21.
//

import Foundation

import FirebaseFirestore

protocol ReceivedInvitationsRepositoryProtocol {

    var receivedInvitations: [ReceivedInvitation] { get }
    var receivedInvitationsPublisher: Published<[ReceivedInvitation]>.Publisher { get }
    var receivedInvitationsPublished: Published<[ReceivedInvitation]> { get }
    
    
    func getReceivedInvitations(uid: String) -> Void
    func acceptInvitation(invitation: ReceivedInvitation, completion: @escaping (Result<Void, Error>) -> Void)
    func rejectInvitation(invitation: ReceivedInvitation, completion: @escaping (Result<Void, Error>) -> Void)
}

class MockReceivedInvitationsRepository: ReceivedInvitationsRepositoryProtocol, ObservableObject {
    
    @Published var receivedInvitations: [ReceivedInvitation] = []
    var receivedInvitationsPublished: Published<[ReceivedInvitation]> { _receivedInvitations }
    var receivedInvitationsPublisher: Published<[ReceivedInvitation]>.Publisher { $receivedInvitations }
    
  
    let mockData: [[String: Any]] = [
        
        [
            "invitationId": "invitationId1",
            "invitee_uid": "testUID1",
            "invitee_uname": "testUname1",
            "recipient_uid": "testToddUid",
            "recipient_uname": "todd123",
            "invitationStatus": "pending",
            "expirationDateTime": Timestamp(date: Date() + 12*60*60),
            "draftRounds": 10
        ],
        [
            "invitationId": "invitationId2",
            "invitee_uid": "testUID2",
            "invitee_uname": "testUname2",
            "recipient_uid": "testToddUid",
            "recipient_uname": "todd123",
            "invitationStatus": "pending",
            "expirationDateTime": Timestamp(date: Date() + 2*60*60),
            "draftRounds": 5
        ],
        [
            "invitationId": "invitationId3",
            "invitee_uid": "testUID3",
            "invitee_uname": "testUname3",
            "recipient_uid": "testToddUid",
            "recipient_uname": "todd123",
            "invitationStatus": "pending",
            "expirationDateTime": Timestamp(date: Date() + 16*60*60),
            "draftRounds": 7
        ],
        [
            "invitationId": "invitationId4",
            "invitee_uid": "testUID4",
            "invitee_uname": "testUname4",
            "recipient_uid": "testToddUid",
            "recipient_uname": "todd123",
            "invitationStatus": "pending",
            "expirationDateTime": Timestamp(date: Date() + 24*60*60),
            "draftRounds": 2
        ]
    ]
    
    init(uid: String){
        getReceivedInvitations(uid: uid)
    }
    
    func getReceivedInvitations(uid: String){
        
        self.receivedInvitations = self.mockData.map{ invitation in
            ReceivedInvitation(data: invitation)!
        }
        
    }
    
    func acceptInvitation(invitation: ReceivedInvitation, completion: @escaping (Result<Void, Error>) -> Void){
        completion(.success(()))
    }
    
    func rejectInvitation(invitation: ReceivedInvitation, completion: @escaping (Result<Void, Error>) -> Void){
        completion(.success(()))
    }
}
