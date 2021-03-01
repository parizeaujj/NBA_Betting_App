//
//  CompletedContestsRepository.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/23/21.
//

import Foundation
import FirebaseFirestore


protocol CompletedContestsRepositoryProtocol {

    var completedContests: [CompletedContest] { get }
    var completedContestsPublisher: Published<[CompletedContest]>.Publisher { get }
    var completedContestsPublished: Published<[CompletedContest]> { get }
    
    func getCompletedContests() -> Void
    
}


// MOCK
class MockCompletedContestsRepository: CompletedContestsRepositoryProtocol, ObservableObject {
    
    @Published var completedContests: [CompletedContest] = []
    var completedContestsPublished: Published<[CompletedContest]> { _completedContests }
    var completedContestsPublisher: Published<[CompletedContest]>.Publisher { $completedContests }
    
    let mockData: [[String: Any]] = [
        ["completionDateTime": Timestamp(date: Date()),
         "player1_uid": "testToddUid",
         "player1_uname": "todd123",
         "player2_uid": "testOppUid",
         "player2_uname": "testOpp",
         "player1_total": 3,
         "player2_total": 1,
         "player1_forced": 1,
         "player2_forced": 0,
         "player1_drafted": 2,
         "player2_drafted": 1,
         "contestResults": [
            "player1": "WON",
            "player2": "LOST"
         ],
         "numBets": 3,
         "games": [
            
            // game 1
            ["awayTeam": "HOU Rockets",
             "homeTeam": "MIA Heat",
             "awayTeamScore": 97,
             "homeTeamScore": 110,
             "gameWinner" : "HOME", // can be 'HOME', 'AWAY', or 'TIE'
             "gameCompletionDateTime": Timestamp(date: Date()),
             "overUnderBetResults": [
                "player1": [
                    "bet": "UNDER 225.5",
                    "result": "LOST"
                ],
                "player2": [
                    "bet": "OVER 225.5",
                    "result": "WON"
                ]
             ],
             "spreadBetResults": [
                "player1": [
                    "bet": "MIA -7",
                    "result": "WON"
                ],
                "player2": [
                    "bet": "HOU +7",
                    "result": "LOST"
                ]
             ]
            ],
            
            // game 2
            
            ["awayTeam": "GS Warriors",
             "homeTeam": "NY Knicks",
             "awayTeamScore": 115,
             "homeTeamScore": 108,
             "gameWinner" : "HOME", // can be 'HOME', 'AWAY', or 'TIE'
             "gameCompletionDateTime": Timestamp(date: Date()),
             "spreadBetResults": [
                "player1": [
                    "bet": "GS -3.5",
                    "result": "WON"
                ],
                "player2": [
                    "bet": "NY +3.5",
                    "result": "LOST"
                ]
             ]
            ],
            
            // game 3
            
            ["awayTeam": "LA Clippers",
             "homeTeam": "UT Jazz",
             "awayTeamScore": 110,
             "homeTeamScore": 116,
             "gameWinner" : "HOME", // can be 'HOME', 'AWAY', or 'TIE'
             "gameCompletionDateTime": Timestamp(date: Date()),
             "overUnderBetResults": [
                "player1": [
                    "bet": "OVER 220",
                    "result": "WON"
                ],
                "player2": [
                    "bet": "UNDER 220",
                    "result": "LOST"
                ]
             ]
            ],
            
            
         ]
        ]
    ]
    
    
    init() {
        getCompletedContests()
    }
    
    func getCompletedContests(){
        
        self.completedContests = self.mockData.map { contest -> CompletedContest in
            
            CompletedContest(data: contest, playerUid: "testToddUid")!
            
        }
    }
}






