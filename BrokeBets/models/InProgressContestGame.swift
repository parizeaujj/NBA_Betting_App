//
//  InProgressContestGame.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/3/21.
//

import Foundation
import FirebaseFirestore

struct InProgressContestGame: Codable, Identifiable {
    
    var id = UUID()
    var gameId: String
    var homeTeam: String
    var awayTeam: String
    var overUnderBet: String?
    var spreadBet: String?
    var timeGameStarted: Date // used for sorting

    init?(game: [String: Any], playerLookupPrefix: String){
        
        guard let homeTeam = game["homeTeam"] as? String,
              let awayTeam = game["awayTeam"] as? String,
              let gameId = game["gameId"] as? String,
              let timeGameStartedTS = game["timeGameStarted"] as? Timestamp
        else {
            return nil
        }
        
        self.timeGameStarted = timeGameStartedTS.dateValue()
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.gameId = gameId
        
        if let overUnderBet = game["overUnderBet"] as? [String: String] {
            self.overUnderBet = overUnderBet[playerLookupPrefix]
        }
        else{
            self.overUnderBet = nil
        }
        
        if let spreadBet = game["spreadBet"] as? [String: String] {
            self.spreadBet = spreadBet[playerLookupPrefix]
        }
        else{
            self.spreadBet = nil
        }
    }
}
