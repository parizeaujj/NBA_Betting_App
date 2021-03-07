//
//  InProgressContest.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/3/21.
//

import Foundation

struct InProgressContest: Codable, Identifiable {

    var id = UUID()
    var contestId: String // used for referencing the particular contest in the inProgressContests dictionary in InProgressContestsRepository
    var opponent: String
    
    var numBets: Int
    var numBetsRemaining: Int
    var numBetsCompleted: Int
    
    var userTotalWins: Int = 0
    var userForcedWins: Int = 0
    var userDraftedWins: Int = 0
    
    var opponentTotalWins: Int = 0
    var opponentForcedWins: Int = 0
    var opponentDraftedWins: Int = 0
    
    var completedGames : [CompletedContestGame]?
    var upcomingGames : [UpcomingContestGame]?
    var inProgressGames: [InProgressContestGame]?
    

    init?(data: [String:Any], playerUid: String, contestId: String){
        
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
              let numBets = data["numBets"] as? Int,
              let numBetsRemaining = data["numBetsRemaining"] as? Int,
              let numBetsCompleted = data["numBetsCompleted"] as? Int
             
        else {
            return nil
        }
        
        
        self.contestId = contestId
        self.numBets = numBets
        self.numBetsRemaining = numBetsRemaining
        self.numBetsCompleted = numBetsCompleted
        
        
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
        
        
        let todaysSimpleDate = SimpleDate(date: Date())
        

        //change these names back after testing with Firebase
        if let upcomingGames = data["upcoming_games"] as? [[String: Any]] {
            // gets all the upcoming games for the contest
            var upGames: [UpcomingContestGame] = []

            for game in upcomingGames {

                guard let g = UpcomingContestGame(game: game, playerLookupPrefix: playerLookupType.rawValue, todaysSimpleDate: todaysSimpleDate) else {

                    return nil
                }
                upGames.append(g)
            }
            
            self.upcomingGames = upGames
        }
        
        
        if let completedGames = data["completed_games"] as? [[String: Any]]{
            // gets all the completed games for the contest
            var compGames: [CompletedContestGame] = []

            for game in completedGames {

                guard let g = CompletedContestGame(game: game, playerLookupPrefix: playerLookupType.rawValue, todaysSimpleDate: todaysSimpleDate) else {

                    return nil
                }
                compGames.append(g)
            }

            self.completedGames = compGames
        }
        
        if let inProgressGames = data["inProgress_games"] as? [[String: Any]] {
            
            // gets all the in progress games for the contest
            var ipGames: [InProgressContestGame] = []
            
            for game in inProgressGames {

                guard let g = InProgressContestGame(game: game, playerLookupPrefix: playerLookupType.rawValue) else {

                    return nil
                }
                ipGames.append(g)
            }

            self.inProgressGames = ipGames
            
        }
    }
}

