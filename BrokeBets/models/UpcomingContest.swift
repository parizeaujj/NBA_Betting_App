//
//  File.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/20/21.
//

import FirebaseFirestoreSwift

struct UpcomingContest : Codable, Identifiable {
    
    @DocumentID var id: String?
    var opponent: String
    var firstGameStartDateTime: String
    var numBets: Int
    var games : [UpcomingContestGame]
}


