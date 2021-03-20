//
//  DraftPickSelection.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/20/21.
//

import Foundation

enum BetType: String {
    
    case spread = "spread"
    case overUnder = "overUnder"
}



struct DraftPickSelection {
    
    var draftedPick: [String: Any] = [:]
    var inversePick: [String: Any] = [:]
    

    init(gameId: String, round: Int, pick: String, inversePick: String, homeTeam: String, awayTeam: String, betType: BetType){
        
        
        self.draftedPick = ["gameId": gameId, "round": round, "betInfo": pick, "betType": betType.rawValue]
        self.inversePick = ["gameId": gameId, "round": round, "betInfo": inversePick, "betType": betType.rawValue]


        if(betType == .overUnder){
            
            let matchupStr = "(" + homeTeam.split(separator: " ")[0] + " vs " + awayTeam.split(separator: " ")[0] + ")"
            
            let draftedDisplayStr = pick + " " + matchupStr
            let inverseDisplayStr = inversePick + " " + matchupStr
            
            self.draftedPick["betDisplayStr"] = draftedDisplayStr
            self.inversePick["betDisplayStr"] = inverseDisplayStr
        }
        else if(betType == .spread){
            
            let draftedDisplayStr = pick + " (vs " + inversePick.split(separator: " ")[0] + ")"
            let inverseDisplayStr = inversePick + " (vs " + pick.split(separator: " ")[0] + ")"
            
            self.draftedPick["betDisplayStr"] = draftedDisplayStr
            self.inversePick["betDisplayStr"] = inverseDisplayStr
        }
    }
}
