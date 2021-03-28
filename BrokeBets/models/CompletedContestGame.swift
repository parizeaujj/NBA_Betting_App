//
//  CompletedContestGame.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/23/21.
//

import Foundation
import FirebaseFirestore

enum GameWinner: String, Codable{
    case HOME = "HOME"
    case AWAY = "AWAY"
    case TIE = "TIE"
}


enum BetResult: String, Codable {
    case Won = "WON"
    case Lost = "LOST"
    case Push = "PUSH"
}


struct CompletedContestGame: Codable, Identifiable {
    
    var id = UUID()
    var homeTeam: String
    var awayTeam: String
    var homeTeamScore: Int
    var awayTeamScore: Int
    var gameWinner: GameWinner
    var gameCompletionDateTimeStr: String
    var gameCompletionDateTime: Date        // used for sorting
    var overUnderBet: String?
    var overUnderBetResult: BetResult?
    var spreadBet: String?
    var spreadBetResult: BetResult?
    
    
    init(homeTeam: String, awayTeam:String, htScore: Int, atScore:Int, completedDT: Date, specialDayType: SpecialDayType = .None, ouBet: String? = nil, ouBetRes: BetResult? = nil, spreadBet: String? = nil, spreadBetRes: BetResult? = nil, gameWinner: GameWinner){

        

        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.homeTeamScore = htScore
        self.awayTeamScore = atScore
        self.gameWinner = gameWinner
        
        
        if spreadBet != nil && spreadBetRes != nil {
            self.spreadBet = spreadBet
            self.spreadBetResult = spreadBetRes
        }
        
        
        if ouBet != nil && ouBetRes != nil {
            self.overUnderBet = ouBet
            self.overUnderBetResult = ouBetRes
        }

        self.gameCompletionDateTime = completedDT
        self.gameCompletionDateTimeStr = completedDT.createDateTimeString(with: specialDayType, completionStatus: .Completed)
    }
    
    init?(game: [String: Any], playerLookupPrefix: String, todaysSimpleDate: SimpleDate){
        
        guard let homeTeam = game["homeTeam"] as? String,
              let awayTeam = game["awayTeam"] as? String,
              let homeTeamScore = game["homeTeamScore"] as? Int,
              let awayTeamScore = game["awayTeamScore"] as? Int,
              let gameWinner = game["gameWinner"] as? String,
              let ts = game["gameCompletionDateTime"] as? Timestamp
        else {
            print("here99999")
            return nil
        }
        
       
        
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.homeTeamScore = homeTeamScore
        self.awayTeamScore = awayTeamScore
        guard let gameWinnerCasted = GameWinner(rawValue: gameWinner.uppercased()) else {
            print("issue getting game winner")
            return nil
        }
        self.gameWinner = gameWinnerCasted
        
        let gameCompletionDt = ts.dateValue()
        self.gameCompletionDateTime = gameCompletionDt
       
        self.gameCompletionDateTimeStr = ""
                
        let specialDayType = gameCompletionDt.getSpecialDayType(todaysSimpleDate: todaysSimpleDate)
        self.gameCompletionDateTimeStr = gameCompletionDt.createDateTimeString(with: specialDayType, completionStatus: .Completed)
        
        
        // process the results of the over under bet for the game, if that bet exists
        if let overUnderBetResults = game["overUnderBetResults"] as? [String: [String: String]]{
           
            guard let userResults = overUnderBetResults[playerLookupPrefix] else {
                print("issue getting user's ou bet results")
                return nil
            }
            
            guard let bet = userResults["bet"] else{
                print("issue getting user's bet for overUnderBetResults")
                return nil
            }
            
            guard let betResult = userResults["result"] else{
                print("issue getting user's result for overUnderBetResults")
                return nil
            }
            
            self.overUnderBet = bet
            self.overUnderBetResult = BetResult(rawValue: betResult.uppercased())!
        }
        
        
        // process the results of the spread bet for the game, if that bet exists
        if let spreadBetResults = game["spreadBetResults"] as? [String: [String: String]]{
           
            guard let userResults = spreadBetResults[playerLookupPrefix] else {
                print("issue getting user's spread bet results")
                return nil
            }
            
            guard let bet = userResults["bet"] else{
                print("issue getting user's bet for spreadBetResults")
                return nil
            }
            
            guard let betResult = userResults["result"] else{
                print("issue getting user's result for spreadBetResults")
                return nil
            }
            
            self.spreadBet = bet
            self.spreadBetResult = BetResult(rawValue: betResult.uppercased())!
        }
    }
}
