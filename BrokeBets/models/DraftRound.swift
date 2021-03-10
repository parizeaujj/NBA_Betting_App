//
//  DraftRound.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/10/21.
//

import Foundation

struct DraftRound: Identifiable {
    
    var id = UUID()
    var round: Int
    var draftedBetStr: String?
    var forcedBetStr: String?
    
    init?(round: Int, draftedPick: [String: Any]?, forcedPick: [String: Any]?){
        
        
        if draftedPick == nil && forcedPick == nil {
            print("error: the drafted pick and the forced pick cannot both be nil")
            return nil
        }
        
        let roundFromDraftedPick: Int
        let roundFromForcedPick: Int
        
        if let draftedPick = draftedPick {
            
            guard let tempRound = draftedPick["round"] as? Int,
                  let draftedBetStr = draftedPick["betDisplayStr"] as? String
            else {
                print("issue getting round data from drafted pick")
                return nil
            }
            
            roundFromDraftedPick = tempRound
            self.draftedBetStr = draftedBetStr
        }
        else{
            roundFromDraftedPick = round
        }
        
        if let forcedPick = forcedPick {
            
            guard let tempRound = forcedPick["round"] as? Int,
                  let forcedBetStr = forcedPick["betDisplayStr"] as? String
            else {
                print("issue getting round data from forced pick")
                return nil
            }
            
            roundFromForcedPick = tempRound
            self.forcedBetStr = forcedBetStr
        }
        else{
            roundFromForcedPick = round
        }
        
        
        
        if roundFromDraftedPick != roundFromForcedPick || roundFromDraftedPick != round {
            print("Error: rounds via the initilizer, the drafted pick(if applicable), and the forced pick (if applicable), are NOT all equal")
            return nil
        }
        
        self.round = round

    }
}
