//
//  ReceivedInvitation.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/16/21.
//

import FirebaseFirestore
import SwiftUI

struct ReceivedInvitation: Identifiable {
    
    typealias AvailableGame = DraftGame
    
    var id = UUID()
    var invitationId: String
    var invitor_uname: String
    var invitor_uid: String
    var draftRounds: Int
    var expirationDateTime: Date
    var expirationDateTimeStr: String
    var gamesPool: [AvailableGame]
    
    init?(data: [String: Any]){
        
        guard let invitationId = data["invitationId"] as? String,
              let invitor_uname = data["invitor_uname"] as? String,
              let invitor_uid = data["invitor_uid"] as? String,
              let draftRounds = data["draftRounds"] as? Int,
              let ts = data["expirationDateTime"] as? Timestamp,
              let gamesPoolData = data["games_pool"] as? [[String: Any]]
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
        
        
        var gamesPool: [AvailableGame] = []
        
        for gameData in gamesPoolData {
            
            guard let draftGame = AvailableGame(data: gameData) else {
                print("issue creating available game from games pool for invitation")
                return nil
            }
            gamesPool.append(draftGame)
        }
        
        self.gamesPool = gamesPool
    }
}

struct ReceivedInvitation_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
