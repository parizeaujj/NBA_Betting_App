//
//  Draft.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/10/21.
//

import Foundation
import FirebaseFirestore

struct Draft: Identifiable {
    
    var id = UUID()
    var draftId: String
    var opponent: String
    var opponent_uid: String
    var isUserTurn: Bool
    var totalRounds: Int
    var currentRound: Int
    var draftExpirationDateTime: Date // used for sorting
    var draftExpirationDateTimeStr: String
    var userPlayerType: PlayerLookupType
    var oppPlayerType: PlayerLookupType

    var userDraftRoundsResults: [DraftRound]?
    var gamesPool: [DraftGame]

    
    init?(data: [String: Any], playerUid: String){
        
        guard let draftId = data["draftId"] as? String,
              let player1_uid = data["player1_uid"] as? String,
              let player2_uid = data["player2_uid"] as? String,
              let player1_uname = data["player1_uname"] as? String,
              let player2_uname = data["player2_uname"] as? String,
              let currentPlayerTurn = data["currentPlayerTurn"] as? String,
              let currentPlayerTurnType = PlayerLookupType(rawValue: currentPlayerTurn),
              let totalRounds = data["totalRounds"] as? Int,
              let currentRound = data["currentRound"] as? Int,
              let gamesPoolData = data["games_pool"] as? [[String: Any]],
              let ts = data["draftExpirationDateTime"] as? Timestamp
        else{
            print("here1")
            return nil
        }
        
        
        self.draftId = draftId
        self.currentRound = currentRound
        self.totalRounds = totalRounds
        self.gamesPool = []
  
        // find the username of the user's opponent
        if(playerUid == player1_uid){
            userPlayerType = .PlayerOne
            oppPlayerType = .PlayerTwo
            self.opponent = player2_uname
            self.opponent_uid = player2_uid
        }
        else if(playerUid == player2_uid){
            userPlayerType = .PlayerTwo
            oppPlayerType = .PlayerOne
            self.opponent = player1_uname
            self.opponent_uid = player1_uid
        }
        else{
            print("here2")
            return nil
        }
        
        
        self.isUserTurn = currentPlayerTurnType == userPlayerType
        
       
        let dateTime = ts.dateValue()
        let todaysSimpleDate = SimpleDate(date: Date())
        let specialDayType = dateTime.getSpecialDayType(todaysSimpleDate: todaysSimpleDate)
        self.draftExpirationDateTimeStr = dateTime.createDateTimeString(with: specialDayType, completionStatus: .Upcoming)
        self.draftExpirationDateTime = dateTime
        
        let userDraftedPicks = data["\(userPlayerType.rawValue)_drafted_picks"] as? [[String: Any]]
        let userForcedPicks = data["\(userPlayerType.rawValue)_forced_picks"] as? [[String: Any]]
        
        let numDrafted = userDraftedPicks?.count ?? 0
        let numForced = userForcedPicks?.count ?? 0
        
        // the number of picks that the user has drafted or forced can only ever be off by 1, if the difference is 1 then that means the user picked first in the current draft round and the other user has not made their pick for that round yet, or the user's opponenet picked first in the current draft round and the user has not made their pick for that round yet, if it is more than 1, we have a BIG ISSUE with our draft turn-mechanics
        if abs(numDrafted - numForced) > 1 {
            print("here3")
            return nil
        }
        
        if numDrafted + numForced == 0 {
            return
        }
        
        //
        var orderedDraftedPicks = [[String:Any]](repeating: [:], count: numDrafted)
        var orderedForcedPicks = [[String:Any]](repeating: [:], count: numForced)
        
        // order the drafted picks from the data by their round, offset by 1 since round starts at one but first index in array is zero
        if userDraftedPicks != nil {
            
            for draftedPick in userDraftedPicks! {
                
                guard let round = draftedPick["round"] as? Int, round <= numDrafted else {
                    print("issue creating ordered array of drafted picks")
                    return nil
                }
                
                
                orderedDraftedPicks[round-1] = draftedPick
            }
        }
        
        // order the forced picks from the data by their round, offset by 1 since round starts at one but first index in array is zero
        if userForcedPicks != nil {
            
            for forcedPick in userForcedPicks! {
                
                guard let round = forcedPick["round"] as? Int, round <= numForced else {
                    print("issue creating ordered array of forced picks")
                    return nil
                }
                
                
                orderedForcedPicks[round-1] = forcedPick
            }
        }
        
      
        var roundPicks: [DraftRound] = []
       
        if numDrafted >= numForced {
            
            for i in 0..<numForced {
                
                guard let pick = DraftRound(round: i+1, draftedPick: orderedDraftedPicks[i], forcedPick: orderedForcedPicks[i]) else {
                    print("issue creating draft round")
                    return nil
                }
                
                
                roundPicks.append(pick)
            }
            
            
            if(numDrafted != numForced){
                
                guard let pick = DraftRound(round: numDrafted, draftedPick: orderedDraftedPicks[numDrafted-1], forcedPick: nil) else {
                    print("issue creating draft round")
                    return nil
                }
                
                roundPicks.append(pick)
                
            }
        }
        else {
            
            for i in 0..<numDrafted {
                
                guard let pick = DraftRound(round: i+1, draftedPick: orderedDraftedPicks[i], forcedPick: orderedForcedPicks[i]) else {
                    print("issue creating draft round")
                    return nil
                }
                
                roundPicks.append(pick)
            }
            
            guard let pick = DraftRound(round: numForced, draftedPick: nil, forcedPick: userForcedPicks![numForced-1]) else {
                print("issue creating draft round")
                return nil
            }
            
            roundPicks.append(pick)
            
        }
      
        self.userDraftRoundsResults = roundPicks.sorted{ $0.round > $1.round}
        
        
        var gamesPool: [DraftGame] = []
        
        for gameData in gamesPoolData {
            
            guard let draftGame = DraftGame(data: gameData) else {
                print("issue creating draft game from games pool")
                return nil
            }
            gamesPool.append(draftGame)
        }
        
        self.gamesPool = gamesPool.filter({$0.isSpreadBetStillAvailable || $0.isOverUnderBetStillAvailable}).sorted {
            
            if($0.gameStartDateTime != $1.gameStartDateTime){
               return $0.gameStartDateTime < $1.gameStartDateTime
            }
            
            return $0.gameId < $1.gameId
        }
    }
}
