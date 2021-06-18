//
//  File.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/20/21.
//

import FirebaseFirestore


enum PlayerLookupType: String {
    case PlayerOne = "player1"
    case PlayerTwo = "player2"
}

enum CompletionStatus {
    case Upcoming
    case InProgress
    case Completed
}

struct UpcomingContest : Codable, Identifiable {
    
    var id: String //
    var opponent: String
    var firstGameStartDateTimeStr: String
    var firstGameStartDateTime: Date
    var numBets: Int
    var games : [UpcomingContestGame]
    
    init(contestId: String, opponent: String, firstGameStartDateTime: Date, numBets: Int, games: [UpcomingContestGame]){
        self.id = contestId
        self.opponent = opponent
        self.numBets = numBets
        self.games = games
        self.firstGameStartDateTimeStr = ""
        
        let todaysSimpleDate = SimpleDate(date: Date())
        let specialDayType = firstGameStartDateTime.getSpecialDayType(todaysSimpleDate: todaysSimpleDate)
        self.firstGameStartDateTimeStr = firstGameStartDateTime.createDateTimeString(with: specialDayType, completionStatus: .Upcoming)
        self.firstGameStartDateTime = firstGameStartDateTime
    }
    
    init?(data: [String: Any], playerUid: String){
        
        guard let contestId = data["contestId"] as? String,
              let player1_uid = data["player1_uid"] as? String,
              let player2_uid = data["player2_uid"] as? String,
              let player1_uname = data["player1_uname"] as? String,
              let player2_uname = data["player2_uname"] as? String,
              let numBets = data["numBets"] as? Int,
              let ts = data["firstGameStartDateTime"] as? Timestamp,
              let games = data["upcoming_games"] as? [[String: Any]]
            
        else {
            print("herekdjkfk")
            return nil
        }
        
        
        self.id = contestId
        self.numBets = numBets
        self.firstGameStartDateTimeStr = ""
        self.games = []
        
        let playerLookupType: PlayerLookupType
        
        
        // find the username of the user's opponent
        if(playerUid == player1_uid){
            playerLookupType = .PlayerOne
            self.opponent = player2_uname
        }
        else if(playerUid == player2_uid){
            playerLookupType = .PlayerTwo
            self.opponent = player1_uname
        }
        else{
            print("issue with playerlookup type in upcoming contest")
            return nil
        }
        
        
        // get date time string of the earliest game that is in the contest
        let dateTime = ts.dateValue()
        self.firstGameStartDateTime = dateTime
        let todaysSimpleDate = SimpleDate(date: Date())
        let specialDayType = dateTime.getSpecialDayType(todaysSimpleDate: todaysSimpleDate)
        self.firstGameStartDateTimeStr = dateTime.createDateTimeString(with: specialDayType, completionStatus: .Upcoming)
       
        
        // gets all the games for the contest
        var upcomingGames: [UpcomingContestGame] = []
        
        for game in games {

            guard let g = UpcomingContestGame(game: game, playerLookupPrefix: playerLookupType.rawValue, todaysSimpleDate: todaysSimpleDate) else {
                
                print("Error creating upcoming contest game")
                return nil
            }
            upcomingGames.append(g)
        }
        
        
        self.games = upcomingGames.sorted {
            
            if $0.gameStartDateTime == $1.gameStartDateTime {
                return $0.gameId < $1.gameId
            }
            return $0.gameStartDateTime < $1.gameStartDateTime
        }
    }
}





extension Date {
    
    func getSpecialDayType(todaysSimpleDate: SimpleDate) -> SpecialDayType {
        
        let dateComponents = Calendar.current.dateComponents([.month, .day, .year], from: self)
    
        let dayDiff = dateComponents.day! - todaysSimpleDate.day
                
        let monthDiff = dateComponents.month! - todaysSimpleDate.month
        
        let yearDiff = dateComponents.year! - todaysSimpleDate.year
        
        
        if(monthDiff != 0 || yearDiff != 0){
            return .None
        }
        else{
            
            switch(dayDiff){
                case 0: return .Today
                case 1: return .Tomorrow
                case -1: return .Yesterday
                default: return .None
            }
        }
    }
    
    
    func createDateTimeString(with specialDayType: SpecialDayType, completionStatus: CompletionStatus) -> String {
        
        let df = DateFormatter()
        
        if(specialDayType != .None){
            
            if(completionStatus == .Upcoming){
                df.dateFormat = "h:mm a"
                return specialDayType.rawValue + ", " + df.string(from: self)
            }
            
            return specialDayType.rawValue
            
        }
        else{
            
            if(completionStatus == .Upcoming){
                df.dateFormat = "E, MMM d, h:mm a"
                return  df.string(from: self)
            }
            
            df.dateFormat = "MMM d, yyyy"
            return  df.string(from: self)
        }
    }
}




