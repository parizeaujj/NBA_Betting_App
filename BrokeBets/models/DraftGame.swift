//
//  DraftGame.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/10/21.
//


import FirebaseFirestore

struct DraftGame: Identifiable {
    
    var id = UUID()
    private(set) var gameId: String
    private(set) var gameStartDateTime: Date
    private(set) var gameStartDateTimeStr: String
    private(set) var homeTeam: String
    private(set) var awayTeam: String
    private(set) var isSpreadBetStillAvailable: Bool
    private(set) var isOverUnderBetStillAvailable: Bool
    private(set) var homeSpreadBetStr: String
    private(set) var awaySpreadBetStr: String
    private(set) var overBetStr: String
    private(set) var underBetStr: String
    
    private(set) var player1_ouBetStr: String?
    private(set) var player2_ouBetStr: String?
    private(set) var player1_spreadBetStr: String?
    private(set) var player2_spreadBetStr: String?

    private(set) var dictionary: [String: Any]
    
    
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
        
        
        //
        
        
        if !isSpreadBetStillAvailable {
            
            guard let player1_spreadBetStr = data["player1_spreadBetStr"] as? String else {
                print("error getting player1_spreadBet")
                return nil
            }
            
            
            guard let player2_spreadBetStr = data["player2_spreadBetStr"] as? String else {
                print("error getting player2_spreadBet")
                return nil
            }
            
            self.player1_spreadBetStr = player1_spreadBetStr
            self.player2_spreadBetStr = player2_spreadBetStr
        }
        
        if !isOverUnderBetStillAvailable {
            
            guard let player1_ouBetStr = data["player1_ouBetStr"] as? String else {
                print("error getting player1_ouBetStrt")
                return nil
            }
            
            
            guard let player2_ouBetStr = data["player2_ouBetStr"] as? String else {
                print("error getting player2_ouBetStr")
                return nil
            }
            
            self.player1_ouBetStr = player1_ouBetStr
            self.player2_ouBetStr = player2_ouBetStr
        }
        
        
        
        
        //
        
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
    
    mutating func updatePlayerSpreadBetStrings(userLookupType: PlayerLookupType, userBetStr: String, oppBetStr: String){
        
        switch(userLookupType){
        
            case .PlayerOne:
                
                self.player1_spreadBetStr = userBetStr
                self.player2_spreadBetStr = oppBetStr
                self.dictionary["player1_spreadBetStr"] = userBetStr
                self.dictionary["player2_spreadBetStr"] = oppBetStr
                
            case .PlayerTwo:
                
                self.player1_spreadBetStr = oppBetStr
                self.player2_spreadBetStr = userBetStr
                self.dictionary["player1_spreadBetStr"] = oppBetStr
                self.dictionary["player2_spreadBetStr"] = userBetStr
        }
    }
    
    mutating func updatePlayerOverUnderBetStrings(userLookupType: PlayerLookupType, userBetStr: String, oppBetStr: String){
        switch(userLookupType){
        
            case .PlayerOne:
                
                self.player1_ouBetStr = userBetStr
                self.player2_ouBetStr = oppBetStr
                self.dictionary["player1_ouBetStr"]  = userBetStr
                self.dictionary["player2_ouBetStr"] = oppBetStr
                
            case .PlayerTwo:
                
                self.player1_ouBetStr = oppBetStr
                self.player2_ouBetStr = userBetStr
                self.dictionary["player1_ouBetStr"] = oppBetStr
                self.dictionary["player2_ouBetStr"] = userBetStr
        }
    }
    
    mutating func updateSpreadBetAvailablity(to newValue: Bool){
        
        self.isSpreadBetStillAvailable = newValue
        self.dictionary["isSpreadBetStillAvailable"] = newValue
    }
    
    mutating func updateOverUnderBetAvailablity(to newValue: Bool){
        
        self.isOverUnderBetStillAvailable = newValue
        self.dictionary["isSpreadBetStillAvailable"] = newValue
    }
    
    
}
