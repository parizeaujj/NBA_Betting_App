//
//  UpcomingContestGame.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/20/21.
//

import Foundation
import FirebaseFirestore


struct SimpleDate: Codable {
    var day: Int
    var month: Int
    var year: Int
    
    init(date: Date){
        let dateComponents = Calendar.current.dateComponents([.month, .day, .year], from: date)
        
        self.day = dateComponents.day!
        self.month = dateComponents.month!
        self.year = dateComponents.year!
        
    }
}

enum SpecialDayType: String {
    case Today
    case Tomorrow
    case Yesterday
    case None
}


struct UpcomingContestGame: Codable, Identifiable {
    
    var id: String
    var gameId: String
    var homeTeam: String
    var awayTeam: String
    var gameStartDateTimeStr: String
    var gameStartDateTime: Date        // used for sorting
    var overUnderBet: String?
    var spreadBet: String?
    
    
    init(gameId: String, homeTeam: String, awayTeam: String, gameStartDateTime: Date, specialDayType: SpecialDayType, overUnderBet: String, spreadBet: String){
        
        self.id = gameId
        self.gameId = gameId
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.gameStartDateTime = gameStartDateTime
        self.overUnderBet = overUnderBet
        self.spreadBet = spreadBet
        self.gameStartDateTimeStr = ""
        self.gameStartDateTimeStr = gameStartDateTime.createDateTimeString(with: specialDayType, completionStatus: .Upcoming)
        
    }
    
    
    init?(game: [String: Any], playerLookupPrefix: String, todaysSimpleDate: SimpleDate){
        
        guard let homeTeam = game["homeTeam"] as? String,
              let awayTeam = game["awayTeam"] as? String,
              let gameId = game["gameId"] as? String,
              let ts = game["gameStartDateTime"] as? Timestamp
        else {
            return nil
        }
        
        self.id = gameId
        self.gameId = gameId
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        
        let gameStartDt = ts.dateValue()
        self.gameStartDateTime = gameStartDt
       
        self.gameStartDateTimeStr = ""
                
        let specialDayType = gameStartDt.getSpecialDayType(todaysSimpleDate: todaysSimpleDate)
        self.gameStartDateTimeStr = gameStartDt.createDateTimeString(with: specialDayType, completionStatus: .Upcoming)
        
        
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
