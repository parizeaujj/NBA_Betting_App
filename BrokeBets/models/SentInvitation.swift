//
//  SentInvitation.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/16/21.
//

import FirebaseFirestore


enum InvitationStatus: String {
    case rejected = "rejected"
    case pending = "pending"
}

struct SentInvitation: Identifiable {
    
    var id = UUID()
    var invitationId: String
    var recipient_uname: String
    var recipient_uid: String
    var draftRounds: Int
    var invitationStatus: InvitationStatus
    var expirationDateTime: Date?
    var expirationDateTimeStr: String?
    var rejectedDateTime: Date?
    var rejectedDateTimeStr: String?
    
    init?(data: [String: Any]){
        
        guard let invitationId = data["invitationId"] as? String,
              let recipient_uname = data["recipient_uname"] as? String,
              let recipient_uid = data["recipient_uid"] as? String,
              let draftRounds = data["draftRounds"] as? Int,
              let invitationStatusStr = data["invitationStatus"] as? String
        else {
            return nil
        }
        
    
        self.invitationId = invitationId
        self.recipient_uid = recipient_uid
        self.recipient_uname = recipient_uname
        self.draftRounds = draftRounds
        
        guard let invitationStatus = InvitationStatus(rawValue: invitationStatusStr) else {
            print("Error somewhere: Invitations status is not \"rejected\" or \"pending\"")
            return nil
        }
        
        self.invitationStatus = invitationStatus
        
        
        
        if invitationStatus == .pending {
            
            guard let ts = data["expirationDateTime"] as? Timestamp else{
                print("error: problem with casting expirationDateTime as Timestamp")
                return nil
            }
            
            let dateTime = ts.dateValue()
            self.expirationDateTime = dateTime
                        
            let todaysSimpleDate = SimpleDate(date: Date())
            let specialDayType = dateTime.getSpecialDayType(todaysSimpleDate: todaysSimpleDate)
            self.expirationDateTimeStr = dateTime.createDateTimeString(with: specialDayType, completionStatus: .Upcoming)
            
                
        }
        else{
            
            guard let ts = data["rejectedDateTime"] as? Timestamp else{
                print("error: problem with casting rejectedDateTime as Timestamp")
                return nil
            }
            
            let dateTime = ts.dateValue()
            self.rejectedDateTime = dateTime
                        
            let todaysSimpleDate = SimpleDate(date: Date())
            let specialDayType = dateTime.getSpecialDayType(todaysSimpleDate: todaysSimpleDate)
            self.rejectedDateTimeStr = dateTime.createDateTimeString(with: specialDayType, completionStatus: .Completed)
            
        }
    }
}
