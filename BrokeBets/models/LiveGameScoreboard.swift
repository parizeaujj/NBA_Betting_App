//
//  LiveGameScoreboard.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/3/21.
//

import Foundation
import FirebaseFirestore

struct LiveGameScoreboard: Codable, Identifiable {
    
    var id = UUID()
    var homeTeam: String
    var awayTeam: String
    var homeScore: Int = 0
    var awayScore: Int = 0
    var timeLeftStr: String
//    var timeGameStarted: Date // used for sorting
    
    init(homeTeam: String, awayTeam: String, timeLeftStr: String){

        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.timeLeftStr = timeLeftStr
    }
    
    
    
    init?(data: [String: Any]){
        
        guard let homeTeam = data["homeTeam"] as? String,
              let awayTeam = data["awayTeam"] as? String,
              let homeScore = data["homeScore"] as? Int,
              let awayScore = data["awayScore"] as? Int,
              let isOverTime = data["isOverTime"] as? Bool,
//              let timeGameStartedTS = data["timeGameStarted"] as? Timestamp,
              let minsLeftInQtr = data["minsLeftInQtr"] as? Int
//              let secsLeftInQtr = data["secsLeftInQtr"] as? Double
        else {
            return nil
        }
        
        
//        self.timeGameStarted = timeGameStartedTS.dateValue()
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.homeScore = homeScore
        self.awayScore = awayScore
        self.timeLeftStr = ""
        
        var timeLeftStr = ""
        
        //
        let secsLeftInQtr: Double
        
        if let secsDbl = data["secsLeftInQtr"] as? Double {
            secsLeftInQtr = secsDbl
        }
        else{
            
            guard let secsInt = data["secsLeftInQtr"] as? Int else {
                return nil
            }
            
            secsLeftInQtr = Double(secsInt)
            
        }
        
        
        if(isOverTime){
            
            // if there isnt a value for the numOverTime at this point then we have a big problem
            guard let numOverTime = data["numOverTime"] as? Int else {
                return nil
            }
            
            timeLeftStr += "\(numOverTime)OT"
        }
        else{
            
            guard let currentQuarter = data["currentQuarter"] as? Int else {
                return nil
            }
            
            switch(currentQuarter){
                case 1: timeLeftStr += "1st"
                case 2: timeLeftStr += "2nd"
                case 3: timeLeftStr += "3rd"
                case 4: timeLeftStr += "4th"
                default: return nil // if it isnt overtime and the current quarter is not in 1, 2, 3, or 4, then we have a big problem
            }
        }
        
        
        guard let timeStr = getFormattedTimeLeft(mins: minsLeftInQtr, secs: secsLeftInQtr) else {
            print("Error somewhere, you cannot have negative minutes")
            return nil
        }
        
        timeLeftStr += " " + timeStr
    
        self.timeLeftStr = timeLeftStr
        
    }
    
    func getFormattedTimeLeft(mins: Int, secs: Double) -> String? {
        
        if mins == 0 {
            
            return String(format: "%.1f", secs)
        }
        else if mins > 0 {
            
            if(secs < 10){
                return "\(mins):0\(Int(secs))"
            }
            
            return "\(mins):\(Int(secs))"
            
        }
        else{
            return nil
        }
    }
}
