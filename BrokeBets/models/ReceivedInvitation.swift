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
    var invitor_uname: String
    var invitor_uid: String
    var draftRounds: Int
    var expirationDateTime: Date
    var expirationDateTimeStr: String
    
    init?(data: [String: Any]){
        
        guard let invitationId = data["invitationId"] as? String,
              let invitor_uname = data["invitor_uname"] as? String,
              let invitor_uid = data["invitor_uid"] as? String,
              let draftRounds = data["draftRounds"] as? Int,
              let ts = data["expirationDateTime"] as? Timestamp
        else {
            return nil
        }
        
    
        self.invitationId = invitationId
        self.invitor_uid = invitor_uid
        self.invitor_uname = invitor_uname
        self.draftRounds = draftRounds
        
        
        let dateTime = ts.dateValue()
        self.expirationDateTime = dateTime
        
        self.expirationDateTimeStr = ""
        
        let todaysSimpleDate = SimpleDate(date: Date())
        let specialDayType = dateTime.getSpecialDayType(todaysSimpleDate: todaysSimpleDate)
        self.expirationDateTimeStr = dateTime.createDateTimeString(with: specialDayType, completionStatus: .Upcoming)
        
        
    }
}
