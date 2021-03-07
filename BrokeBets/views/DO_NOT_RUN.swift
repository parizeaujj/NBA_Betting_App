//
//  DO_NOT_RUN.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/7/21.
//

import SwiftUI
import FirebaseFirestore





struct TestView: View {
    
    var body: some View {
        
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            Text("UPLOAD DATA TO FIREBASE")
        })
    }
    
    
    
    func SEND_DATA_TO_FIREBASE(){
        
//        let db = Firestore.firestore()
        
//        let contestsRef = db.collection("contests")
        
//        contestsRef.addDocument(data: )
        
        
        
    }
}

/*
let contestsData = [String: Any] =
    
    
    [
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
        "numBets": 8,
        "numBetsCompleted": 4,
        "numBetsRemaining": 4,
        
        "inProgressGameIds": ["game1id", "game2id", "game3id"],
        "upcoming_games": [
            
            // upcoming game 1
            ["awayTeam": "HOU Rockets",
             "homeTeam": "MIA Heat",
             "gameStartDateTime": Timestamp(date: Date()),
             "overUnderBet": [
                "player1": "OVER 225.5",
                "player2": "UNDER 225.5"
             ],
             "spreadBet": [
                "player1": "MIA -7",
                "player2": "HOU +7"
             ]
            ],
            
            // upcoming game 2
            ["awayTeam": "GS Warriors",
             "homeTeam": "NY Knicks",
             "gameStartDateTime": Timestamp(date: Date()),
             "spreadBet": [
                "player1": "GS -3.5",
                "player2": "NY +3.5"
             ]
            ]
            
        ],
        
        
        // completedGames
        "completed_games": [
            
            // completed game 1
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
            
            // completed game 2
            
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
            
            // completed game 3
            
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
            ]
        ],
        
        "inProgress_games": [
            
            // in-progress game 1
            [
                "gameId": "game1id",
                "awayTeam": "HOU Rockets",
                "homeTeam": "MIA Heat",
                "timeGameStarted": Timestamp(date: Date()),
                "overUnderBet": [
                    "player1": "OVER 225.5",
                    "player2": "UNDER 225.5"
                ],
                "spreadBet": [
                    "player1": "MIA -7",
                    "player2": "HOU +7"
                ]
            ],
            
            // in-progress game 2
            
            [
                "gameId": "game2id",
                "awayTeam": "GS Warriors",
                "homeTeam": "NY Knicks",
                "timeGameStarted": Timestamp(date: Date()),
                "spreadBet": [
                    "player1": "GS -3.5",
                    "player2": "NY +3.5"
                ],
            ],
            
            // in-progress game 3
            
            [
                "gameId": "game3id",
                "awayTeam": "LA Clippers",
                "homeTeam": "UT Jazz",
                "timeGameStarted": Timestamp(date: Date()),
                "overUnderBet": [
                    "player1": "OVER 220",
                    "player2": "UNDER 220"
                ],
            ]
        ]
]

*/

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
