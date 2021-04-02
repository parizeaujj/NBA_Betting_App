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
              let isEndOfFirst = data["isEndOfFirst"] as? Bool,
              let isEndOfThird = data["isEndOfThird"] as? Bool,
              let isEndOfFourth = data["isEndOfFourth"] as? Bool,
              let isHalftime = data["isHalftime"] as? Bool,
              let isEndOfOverTime = data["isEndOfOverTime"] as? Bool,
              let minsLeftInQtr = data["minsLeftInQtr"] as? Int
        else {
            print("error right here")
            return nil
        }
        
        
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
                print("error right here 2")
                return nil
            }
            
            secsLeftInQtr = Double(secsInt)
            
        }
        
        
        if(isHalftime){
            timeLeftStr = "Halftime"
        }
        else if(isEndOfFirst){
            timeLeftStr = "End of 1st"
        }
        else if(isEndOfThird){
            timeLeftStr = "End of 3rd"
        }
        else if(isEndOfFourth){
            timeLeftStr = "End of 4th"
        }
        else if(isEndOfOverTime){
            timeLeftStr = "End of OT"
        }
        else{
            
            if(isOverTime){
               
               // if there isnt a value for the numOverTime at this point then we have a big problem
               guard let numOverTime = data["numOverTime"] as? Int else {
                   print("error right here 3")
                   return nil
               }
               
               timeLeftStr += "\(numOverTime)OT"
           }
           else{
               
               guard let currentQuarter = data["currentQuarter"] as? Int else {
                   print("error right here 4")
                   return nil
               }
               
               switch(currentQuarter){
                   case 1: timeLeftStr += "1st"
                   case 2: timeLeftStr += "2nd"
                   case 3: timeLeftStr += "3rd"
                   case 4: timeLeftStr += "4th"
                   default:
                       print("error right here 5")
                       return nil // if it isnt overtime and the current quarter is not in 1, 2, 3, or 4, then we have a big problem
               }
           }
           
           
           guard let timeStr = getFormattedTimeLeft(mins: minsLeftInQtr, secs: secsLeftInQtr) else {
               print("Error somewhere, you cannot have negative minutes")
               return nil
           }
           
           timeLeftStr += " " + timeStr
            
        }
        
    
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
