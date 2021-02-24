//
//  CompletedContest.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/23/21.
//

import FirebaseFirestoreSwift

struct CompletedContest : Codable, Identifiable {
    @DocumentID var id: String?
    var opponent: String
    var userTotalWins: Int
    var opponentTotalWins: Int
    var userDraftedWins: Int
    var opponentDraftedWins: Int
    var userForcedWins: Int
    var opponentForcedWins: Int
    var contestCompletionDateStr: String
    var numBets: Int
    var games : [CompletedContestGame]
    
    
    
    
    
}

