//
//  ReceivedInvitation.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/16/21.
//

import FirebaseFirestore

struct ReceivedInvitation: Identifiable {
    
    var id = UUID()
    var invitationId: String
    var invitee_uname: String
    var invitee_uid: String
    var draftRounds: Int
    var expirationDateTime: Date
    var expirationDateTimeStr: String
    
    init?(data: [String: Any]){
        
        guard let invitationId = data["invitationId"] as? String,
              let invitee_uname = data["invitee_uname"] as? String,
              let invitee_uid = data["invitee_uid"] as? String,
              let draftRounds = data["draftRounds"] as? Int,
              let ts = data["expirationDateTime"] as? Timestamp
        else {
            return nil
        }
        
    
        self.invitationId = invitationId
        self.invitee_uid = invitee_uid
        self.invitee_uname = invitee_uname
        self.draftRounds = draftRounds
        
        
        let dateTime = ts.dateValue()
        self.expirationDateTime = dateTime
        
        self.expirationDateTimeStr = ""
        
        let todaysSimpleDate = SimpleDate(date: Date())
        let specialDayType = dateTime.getSpecialDayType(todaysSimpleDate: todaysSimpleDate)
        self.expirationDateTimeStr = dateTime.createDateTimeString(with: specialDayType, completionStatus: .Upcoming)
        
        
    }
}
