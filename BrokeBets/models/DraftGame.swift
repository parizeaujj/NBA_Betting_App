//
//  DraftGame.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/10/21.
//

import Foundation


struct DraftGame: Identifiable {
    
    var id = UUID()
    var gameId: String
    var homeTeam: String
    var awayTeam: String
    var isSpreadBetStillAvailable: Bool
    var isOverUnderBetStillAvailable: Bool
   
    var spreadBet: (favoriteBetStr: String, underdogBetStr: String)
    var ouBet: (overBetStr: String, underBetStr: String)
    
    
    init?(data: [String: Any]){
        
        guard let gameId = data["gameId"] as? String,
              let homeTeam = data["homeTeam"] as? String,
              let awayTeam = data["awayTeam"] as? String,
              let isSpreadBetStillAvailable = data["isSpreadBetStillAvailable"] as? Bool,
              let isOverUnderBetStillAvailable = data["isOverUnderBetStillAvailable"] as? Bool,
              let spreadFavoriteBetStr = data["spreadFavoriteBetStr"] as? String,
              let spreadUnderdogBetStr = data["spreadUnderdogBetStr"] as? String,
              let overBetStr = data["overBetStr"] as? String,
              let underBetStr = data["underBetStr"] as? String
        else {
            print("here5")
            return nil
        }
        
        self.gameId = gameId
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.isSpreadBetStillAvailable = isSpreadBetStillAvailable
        self.isOverUnderBetStillAvailable = isOverUnderBetStillAvailable
        
        self.spreadBet = (favoriteBetStr: spreadFavoriteBetStr, underdogBetStr: spreadUnderdogBetStr)
        self.ouBet = (overBetStr: overBetStr, underBetStr: underBetStr)
              
    }
}
