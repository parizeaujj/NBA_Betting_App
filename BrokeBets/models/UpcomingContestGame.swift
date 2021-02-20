//
//  UpcomingContestGame.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/20/21.
//

import Foundation


struct SimpleDate: Codable {
    var day: Int
    var month: Int
    var year: Int
}

enum SpecialUpcomingDayType: String {
    case Today
    case Tomorrow
    case None
}



struct UpcomingContestGame: Codable, Identifiable {
    
    var id = UUID()
    var homeTeam: String
    var awayTeam: String
    var gameStartDateTimeStr: String
    var gameStartDateTime: Date        // used for sorting
    var overUnderBet: String?
    var spreadBet: String?
    
    init(homeTeam: String, awayTeam:String, gameStartDateTime: Date, specialDayType: SpecialUpcomingDayType = .None, overUnderBet: String? = nil, spreadBet: String? = nil){
                
        let df = DateFormatter()
        
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.gameStartDateTime = gameStartDateTime
        self.overUnderBet = overUnderBet
        self.spreadBet = spreadBet
        
        
        if(specialDayType != .None){
            df.dateFormat = "h:mm a"
            self.gameStartDateTimeStr = specialDayType.rawValue + ", " + df.string(from: gameStartDateTime)
        }
        else{
            df.dateFormat = "E, MMM d, h:mm a"
            self.gameStartDateTimeStr = df.string(from: gameStartDateTime)
        }
    }
}

