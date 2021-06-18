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
    
    private var user: User
  
    let mockData: [[String: Any]] = [
        
        [
            "invitationId": "invitationId1",
            "invitor_uid": "testUID1",
            "invitor_uname": "testUname1",
            "recipient_uid": "testToddUid",
            "recipient_uname": "todd123",
            "invitationStatus": "pending",
            "expirationDateTime": Timestamp(date: Date() + 12*60*60),
            "draftRounds": 10,
            "games_pool": []
        ],
        [
            "invitationId": "invitationId2",
            "invitor_uid": "testUID2",
            "invitor_uname": "testUname2",
            "recipient_uid": "testToddUid",
            "recipient_uname": "todd123",
            "invitationStatus": "pending",
            "expirationDateTime": Timestamp(date: Date() + 2*60*60),
            "draftRounds": 5,
            "games_pool": []
        ],
        [
            "invitationId": "invitationId3",
            "invitor_uid": "testUID3",
            "invitor_uname": "testUname3",
            "recipient_uid": "testToddUid",
            "recipient_uname": "todd123",
            "invitationStatus": "pending",
            "expirationDateTime": Timestamp(date: Date() + 16*60*60),
            "draftRounds": 7,
            "games_pool": []
        ],
        
        [
            "invitationId": "invitationId5",
            "invitor_uid": "testUID5",
            "invitor_uname": "testUname5",
            "recipient_uid": "testToddUid",
            "recipient_uname": "todd123",
            "invitationStatus": "pending",
            "expirationDateTime": Timestamp(date: Date() + 2*24*60*60),
            "draftRounds": 6,
            "games_pool": []
        ],
        
//        [
//            "invitationId": "invitationId4",
//            "invitor_uid": "testUID4",
//            "invitor_uname": "testUname4",
//            "recipient_uid": "testToddUid",
//            "recipient_uname": "todd123",
//            "invitationStatus": "pending",
//            "expirationDateTime": Timestamp(date: Date() + 24*60*60),
//            "draftRounds": 2,
//            "games_pool": []
//        ]
        
    ]
    
    let mockData2: [[String: Any]] = [
        
        [
            "invitationId": "invitationId1",
            "invitor_uid": "testUID1",
            "invitor_uname": "testUname1",
            "recipient_uid": "testToddUid",
            "recipient_uname": "todd123",
            "invitationStatus": "pending",
            "expirationDateTime": Timestamp(date: Date() + 12*60*60),
            "draftRounds": 10,
            "games_pool": []
        ],
        [
            "invitationId": "invitationId2",
            "invitor_uid": "testUID2",
            "invitor_uname": "testUname2",
            "recipient_uid": "testToddUid",
            "recipient_uname": "todd123",
            "invitationStatus": "pending",
            "expirationDateTime": Timestamp(date: Date() + 2*60*60),
            "draftRounds": 5,
            "games_pool": []
        ],
        [
            "invitationId": "invitationId3",
            "invitor_uid": "testUID3",
            "invitor_uname": "testUname3",
            "recipient_uid": "testToddUid",
            "recipient_uname": "todd123",
            "invitationStatus": "pending",
            "expirationDateTime": Timestamp(date: Date() + 16*60*60),
            "draftRounds": 7,
            "games_pool": []
        ],
        [
            "invitationId": "invitationId4",
            "invitor_uid": "testUID4",
            "invitor_uname": "testUname4",
            "recipient_uid": "testToddUid",
            "recipient_uname": "todd123",
            "invitationStatus": "pending",
            "expirationDateTime": Timestamp(date: Date() + 24*60*60),
            "draftRounds": 2,
            "games_pool": []
        ],
        [
            "invitationId": "invitationId5",
            "invitor_uid": "testUID5",
            "invitor_uname": "testUname5",
            "recipient_uid": "testToddUid",
            "recipient_uname": "todd123",
            "invitationStatus": "pending",
            "expirationDateTime": Timestamp(date: Date() + 2*24*60*60),
            "draftRounds": 6,
            "games_pool": []
        ],
//
//        [
//            "invitationId": "invitationId6",
//            "invitor_uid": "testUID6",
//            "invitor_uname": "testUname6",
//            "recipient_uid": "testToddUid",
//            "recipient_uname": "todd123",
//            "invitationStatus": "pending",
//            "expirationDateTime": Timestamp(date: Date() + 3*24*60*60),
//            "draftRounds": 6,
//            "games_pool": []
//        ]
        
        
    ]
    
   
        
    
    init(user: User){
        self.user = user
        getReceivedInvitations(uid: user.uid)
        
        removeInvitationsAfterFiveSeconds()
//        addInvitationAfterFiveSeconds()
    }
    
    func getReceivedInvitations(uid: String){
        
        self.receivedInvitations = self.mockData2.map{ invitation in
            ReceivedInvitation(data: invitation)!
        }
        
    }
    
    func removeInvitationsAfterFiveSeconds(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            
            self.receivedInvitations = self.mockData.map { invitation in ReceivedInvitation(data: invitation)! }
            print("after 5 seconds...")
        }
    }
    
//    func addInvitationAfterFiveSeconds(){
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//
//            self.receivedInvitations = self.mockData.map { invitation in ReceivedInvitation(data: invitation)! }
//            print("after 5 seconds...")
//        }
//    }
    
    func acceptInvitation(invitation: ReceivedInvitation, completion: @escaping (Result<Void, Error>) -> Void){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            completion(.failure(NSError()))
        }
        
        
    }
    
    func rejectInvitation(invitation: ReceivedInvitation, completion: @escaping (Result<Void, Error>) -> Void){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            completion(.success(()))
        }
    }
}


class ReceivedInvitationsRepository: ReceivedInvitationsRepositoryProtocol, ObservableObject {
    
    @Published var receivedInvitations: [ReceivedInvitation] = []
    var receivedInvitationsPublished: Published<[ReceivedInvitation]> { _receivedInvitations }
    var receivedInvitationsPublisher: Published<[ReceivedInvitation]>.Publisher { $receivedInvitations }
    
    private var db = Firestore.firestore()
    private var receivedInvitationsListenerHandle: ListenerRegistration? = nil
    
    private var user: User
    
    init(user: User){
        
        self.user = user
        
        getReceivedInvitations(uid: user.uid)
    }
    
    func getReceivedInvitations(uid: String){
        
        self.receivedInvitationsListenerHandle = db.collection("invitations")
            .whereField("invitationStatus", isEqualTo: "pending")
            .whereField("recipient_uid", isEqualTo: uid)
            .addSnapshotListener { (querySnapshot, error) in
                
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            var receivedInvitations: [ReceivedInvitation] = []
            
            // Loops through each recieved invitation from firebase
            for document in documents{
                guard let invitation = ReceivedInvitation(data: document.data()) else {
                    print("Issue getting received invitation")
                    return
                }
                
                receivedInvitations.append(invitation)
            }
            
            // Updates the publisher to the new values
            self.receivedInvitations = receivedInvitations
        }
    }
    
    deinit {
        self.receivedInvitationsListenerHandle?.remove()
        print("listener for received invitations has been removed")
    }
       
        
    
    func acceptInvitation(invitation: ReceivedInvitation, completion: @escaping (Result<Void, Error>) -> Void){
        
        let player1_uid = invitation.invitor_uid
        let player1_uname = invitation.invitor_uname
        
        let player2_uid = user.uid
        let player2_uname = user.username!
        
        let draftExpirationDateTime = Calendar.current.date(byAdding: .minute, value: 30, to: invitation.expirationDateTime)!
        let draftExpirationDocId = draftExpirationDateTime.customUTCDateString()
        let draftExpirationSubDocRef = db.collection("draft_expiration_subscriptions").document(draftExpirationDocId)
        
        let invitationExpirationDocId = invitation.expirationDateTime.customUTCDateString()
        let invitationExpirationSubDocRef = db.collection("invitation_expiration_subscriptions").document(invitationExpirationDocId)
        
        let newDraftDocRef = db.collection("drafts").document()
        
        let invitationDocRef = db.collection("invitations").document(invitation.invitationId)
        
        // batched write
        
        let batch = db.batch();
        
        // create the draft document
        batch.setData([
            "draftId": newDraftDocRef.documentID,
            "draftStatus": "active",
            "currentRound": 1,
            "currentPlayerTurn": "player1",
            "player1_uid": player1_uid,
            "player1_uname": player1_uname,
            "player2_uid": player2_uid,
            "player2_uname": player2_uname,
            "players": [player1_uid, player2_uid],
            "totalRounds": invitation.draftRounds,
            "draftExpirationDateTime": Timestamp(date: draftExpirationDateTime),
            "games_pool": invitation.gamesPool.map { $0.dictionary },
            "player1_drafted_picks": [],
            "player1_forced_picks": [],
            "player2_drafted_picks": [],
            "player2_forced_picks": []
        ], forDocument: newDraftDocRef)
        
        
        // update the invitation status for the invitation document
        batch.updateData([
            "invitationStatus": "accepted",
        ], forDocument: invitationDocRef)
        
        
        // add the newly created draft's draft id to the array of ids for the corresponding expiration time so that it will be watched for expiration
        batch.updateData([
            "draftIds": FieldValue.arrayUnion([newDraftDocRef.documentID])
        ], forDocument: draftExpirationSubDocRef)
        
        
        // remove the invitation id from the array of ids for its corresponding expiration time so that it is not marked as expired when that time comes
        batch.updateData([
            "invitationIds": FieldValue.arrayRemove([invitation.invitationId])
        ], forDocument: invitationExpirationSubDocRef)
        
        
        
        let userRecNotifTrackerDocRef = db.collection("user_notifications_tracker").document(user.uid)
        
        // decrements the counter for pending recieved invitations for the recipient of the user so that it is accurate since they just accepted one
        batch.setData([
            "numPendingRecInvitations": FieldValue.increment(-1.0)
        ], forDocument: userRecNotifTrackerDocRef, merge: true)
        
        
        
        let oppRecNotifTrackerDocRef = db.collection("user_notifications_tracker").document(invitation.invitor_uid)
        
        // increments the counter for counter of active drafts for the invitor because the recipient just accepted their invitation, and the invitor always goes first
        batch.setData([
            "numActiveUserTurnDrafts": FieldValue.increment(1.0)
        ], forDocument: oppRecNotifTrackerDocRef, merge: true)
        
        
        
        batch.commit { error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            
            completion(.success(()))
            
        }
    }
    
    func rejectInvitation(invitation: ReceivedInvitation, completion: @escaping (Result<Void, Error>) -> Void){
        
        let id = invitation.expirationDateTime.customUTCDateString()
        
        let invitationExpirationSubDocRef = db.collection("invitation_expiration_subscriptions").document(id)
        
        let invitationDocRef = db.collection("invitations").document(invitation.invitationId)
        
        let batch = db.batch();
        
        // remove the invitation id from the array of ids for its corresponding expiration time so that it is not marked as expired when that time comes
        batch.updateData([
            "invitationIds": FieldValue.arrayRemove([invitation.invitationId])
        ], forDocument: invitationExpirationSubDocRef)
        
        
        // update the invitation status for the invitation document
        batch.updateData([
            "invitationStatus": "rejected",
            "rejectedDateTime": Timestamp(date: Date())
        ], forDocument: invitationDocRef)
        
        
        
        let userRecNotifTrackerDocRef = db.collection("user_notifications_tracker").document(user.uid)
        
        // decrements the counter for pending received invitations for the recipient of the user so that it is accurate since they just rejected one
        batch.setData([
            "numPendingRecInvitations": FieldValue.increment(-1.0)
        ], forDocument: userRecNotifTrackerDocRef, merge: true)
        
        
        
        batch.commit { err in
            if let err = err {
                completion(.failure(err))
            } else {
                completion(.success(())) // ewwww why so many parenthesis, swift?
            }
        }
    }
}


extension Date {
    
    func customUTCDateString() -> String {
        
        let utcDateFormatter = DateFormatter()
        utcDateFormatter.timeZone = TimeZone(identifier: "UTC")
        utcDateFormatter.dateFormat = "yyyy-MM-dd-HH:mm"
        
        return utcDateFormatter.string(from: self)
    }
}
