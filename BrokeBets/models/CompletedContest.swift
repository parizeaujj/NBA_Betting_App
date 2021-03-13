//
//  CompletedContest.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/23/21.
//

import FirebaseFirestoreSwift
import FirebaseFirestore

enum ContestResult: String, Codable {
    case Won = "WON"
    case Lost = "LOST"
    case Push = "PUSH"
}

struct CompletedContest : Codable, Identifiable {
//    @DocumentID var id: String?
    var id = UUID()
    var opponent: String
    var result: ContestResult
    var userTotalWins: Int
    var opponentTotalWins: Int
    var userDraftedWins: Int
    var opponentDraftedWins: Int
    var userForcedWins: Int
    var opponentForcedWins: Int
    var contestCompletionDateStr: String
    var numBets: Int
    var games : [CompletedContestGame]
    
    
    init(opponent: String, numBets: Int, result: ContestResult, userScores: (total: Int, drafted: Int, forced: Int), oppScores: (total: Int, drafted: Int, forced: Int), completionDT: Date, games: [CompletedContestGame]){
        
        self.opponent = opponent
        self.numBets = numBets
        self.games = games
        self.result = result
        
        self.userTotalWins = userScores.total
        self.userDraftedWins = userScores.drafted
        self.userForcedWins = userScores.forced
        
        self.opponentTotalWins = oppScores.total
        self.opponentDraftedWins = oppScores.drafted
        self.opponentForcedWins = oppScores.forced
        
        let todaysSimpleDate = SimpleDate(date: Date())
        let specialDayType = completionDT.getSpecialDayType(todaysSimpleDate: todaysSimpleDate)
        self.contestCompletionDateStr = completionDT.createDateTimeString(with: specialDayType, completionStatus: .Completed)
    }
    
    

    init?(data: [String:Any], playerUid: String){
        
        guard let player1_uid = data["player1_uid"] as? String,
              let player2_uid = data["player2_uid"] as? String,
              let player1_uname = data["player1_uname"] as? String,
              let player2_uname = data["player2_uname"] as? String,
              let player1_total = data["player1_total"] as? Int,
              let player2_total = data["player2_total"] as? Int,
              let player1_forced = data["player1_forced"] as? Int,
              let player2_forced = data["player2_forced"] as? Int,
              let player1_drafted = data["player1_drafted"] as? Int,
              let player2_drafted = data["player2_drafted"] as? Int,
              let playerResults = data["contestResults"] as? [String: String],
              let contestCompletionDateTime = data["completionDateTime"] as? Timestamp,
              let numBets = data["numBets"] as? Int,
              let games = data["games"] as? [[String: Any]]
        else {
            return nil
        }
        
        
        let dateTime = contestCompletionDateTime.dateValue()
        
        self.numBets = numBets
        self.games = []
        
        let playerLookupType: PlayerLookupType
        
        
        // find out if user is player1 or player2
        if(playerUid == player1_uid){
            playerLookupType = .PlayerOne
            self.opponent = player2_uname
            
            self.userTotalWins = player1_total
            self.userForcedWins = player1_forced
            self.userDraftedWins = player1_drafted
            
            self.opponentTotalWins = player2_total
            self.opponentForcedWins = player2_forced
            self.opponentDraftedWins = player2_drafted
        }
        else if(playerUid == player2_uid){
            playerLookupType = .PlayerTwo
            self.opponent = player1_uname
            
            self.userTotalWins = player2_total
            self.userForcedWins = player2_forced
            self.userDraftedWins = player2_drafted
            
            self.opponentTotalWins = player1_total
            self.opponentForcedWins = player1_forced
            self.opponentDraftedWins = player1_drafted
        }
        else{
            return nil
        }
        
        guard let result = ContestResult(rawValue: playerResults[playerLookupType.rawValue]?.uppercased() ?? "") else {
            return nil
        }
        
        self.result = result
        
        let todaysSimpleDate = SimpleDate(date: Date())
        let specialDayType = dateTime.getSpecialDayType(todaysSimpleDate: todaysSimpleDate)
        
        self.contestCompletionDateStr = ""
        
        self.contestCompletionDateStr = dateTime.createDateTimeString(with: specialDayType, completionStatus: .Completed)
        
        
        // gets all the games for the contest
        var completedGames: [CompletedContestGame] = []

        for game in games {

            guard let g = CompletedContestGame(game: game, playerLookupPrefix: playerLookupType.rawValue, todaysSimpleDate: todaysSimpleDate) else {

                return nil
            }
            completedGames.append(g)
        }

        self.games = completedGames
    }
}

