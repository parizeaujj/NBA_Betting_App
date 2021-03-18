//
//  DraftGame.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/10/21.
//


import FirebaseFirestore

struct DraftGame: Identifiable {
    
    var id = UUID()
    var gameId: String
    var gameStartDateTime: Date
    var gameStartDateTimeStr: String
    var homeTeam: String
    var awayTeam: String
    var isSpreadBetStillAvailable: Bool
    var isOverUnderBetStillAvailable: Bool
    var homeSpreadBetStr: String
    var awaySpreadBetStr: String
    var overBetStr: String
    var underBetStr: String
    
    var dictionary: [String: Any]
    
    init?(data: [String: Any]){
        
        guard let gameId = data["gameId"] as? String,
              let homeTeam = data["homeTeam"] as? String,
              let awayTeam = data["awayTeam"] as? String,
              let isSpreadBetStillAvailable = data["isSpreadBetStillAvailable"] as? Bool,
              let isOverUnderBetStillAvailable = data["isOverUnderBetStillAvailable"] as? Bool,
              let isHomeTeamFavorite = data["isHomeTeamFavorite"] as? Bool,
              let spreadFavoriteBetStr = data["spreadFavoriteBetStr"] as? String,
              let spreadUnderdogBetStr = data["spreadUnderdogBetStr"] as? String,
              let overBetStr = data["overBetStr"] as? String,
              let underBetStr = data["underBetStr"] as? String,
              let ts = data["gameStartDateTime"] as? Timestamp
        else {
            print("here5")
            return nil
        }
        
        self.gameId = gameId
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.isSpreadBetStillAvailable = isSpreadBetStillAvailable
        self.isOverUnderBetStillAvailable = isOverUnderBetStillAvailable
        
        
        if(isHomeTeamFavorite){
            self.homeSpreadBetStr = spreadFavoriteBetStr
            self.awaySpreadBetStr = spreadUnderdogBetStr
        }
        else{
            self.homeSpreadBetStr = spreadUnderdogBetStr
            self.awaySpreadBetStr = spreadFavoriteBetStr
        }
        
        self.overBetStr = overBetStr
        self.underBetStr = underBetStr
            
        let dateTime = ts.dateValue()
        self.gameStartDateTime = dateTime
        self.gameStartDateTimeStr = ""
        
        let todaysSimpleDate = SimpleDate(date: Date())
        let specialDayType = dateTime.getSpecialDayType(todaysSimpleDate: todaysSimpleDate)
        self.gameStartDateTimeStr = dateTime.createDateTimeString(with: specialDayType, completionStatus: .Upcoming)
        
        
        self.dictionary = data
            
    }
}
