//
//  InProgressContestsRepository.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/3/21.
//
import Foundation
import FirebaseFirestore


protocol InProgressContestsRepositoryProtocol {

    var inProgressContests: [String : InProgressContest] { get }
    var inProgressContestsPublisher: Published<[String : InProgressContest]>.Publisher { get }
    var inProgressContestsPublished: Published<[String : InProgressContest]> { get }
    
    
    var liveGameScoreboards: [String : LiveGameScoreboard] { get }
    var liveGameScoreboardsPublisher: Published<[String : LiveGameScoreboard]>.Publisher { get }
    var liveGameScoreboardsPublished: Published<[String : LiveGameScoreboard]> { get }
    
    func getInProgressContests() -> Void
    
}

class InProgressContestsRepository: InProgressContestsRepositoryProtocol, ObservableObject {
    
    @Published var inProgressContests: [String : InProgressContest] = [:]
    var inProgressContestsPublisher: Published<[String : InProgressContest]>.Publisher { $inProgressContests }
    var inProgressContestsPublished: Published<[String : InProgressContest]> { _inProgressContests }
        
    
    @Published var liveGameScoreboards: [String : LiveGameScoreboard] = [:]
    var liveGameScoreboardsPublisher: Published<[String : LiveGameScoreboard]>.Publisher { $liveGameScoreboards }
    var liveGameScoreboardsPublished: Published<[String : LiveGameScoreboard]> { _liveGameScoreboards  }
    
    
    private var db = Firestore.firestore()
    
    private var gameIds: Set<String> = []
    private var gameScoreListenerHandle: ListenerRegistration? = nil
    
    init() {
        getInProgressContests()
    }
    
    func getInProgressContests() {
        
        //TODO: Replace "testUID" with variable for user's UID
        db.collection("contests")
            .whereField("contestStatus", isEqualTo: "completed")
            .whereField("players", arrayContains: "testUID")
            .addSnapshotListener { (querySnapshot, error) in
                
            guard let documents = querySnapshot?.documents else {
                print("No documents for in progress contests")
                return
            }
            
            var contests: [String: InProgressContest] = [:]
            
            var tempGameIds: Set<String> = []
                
            // Loops through each upcoming contest from firebase
            //TODO: Replace "testUID" with variable for user's UID
            for document in documents{
                
                let data = document.data()
                
                guard let contestGameIds = data["gameIds"] as? [String] else {
                    print("Issue getting game ids for in progress contest")
                    return
                }
                
                // avoids unnessary reallocations when adding new items to Set
                tempGameIds.reserveCapacity(tempGameIds.capacity + contestGameIds.count)
                
                // add all of the gameIds for that contest to the temporary Set
                for gameId in contestGameIds {
                    tempGameIds.insert(gameId)
                }
                
                
                guard let contestData = InProgressContest(data: document.data(), playerUid: "testUID") else {
                    print("Issue creating contest")
                    return
                }
                
                
                // adds the contest to the dictionary using the document id as the key
                contests[document.documentID] = contestData
            }
                
            // checks if we need to update the gameIds Set
            if self.gameIds.count == 0 || self.gameIds != tempGameIds {
                self.gameIds = tempGameIds
                
                // reset listener that listens for game score/timeleft information
                
            }
            
            // Updates the publisher to the new values
            self.inProgressContests = contests
        }
    }
    
    func getGameScoresData(){
        
        if self.gameScoreListenerHandle != nil {
            self.gameScoreListenerHandle!.remove()
        }
        
        self.gameScoreListenerHandle = db.collection("games").whereField("gameId", in: Array(self.gameIds)).addSnapshotListener { querySnapshot, error in
            
            guard let documents = querySnapshot?.documents else {
                print("No documents for games query")
                return
            }
            
            var gameScoreboards: [String: LiveGameScoreboard] = [:]
            
            
            for document in documents {
        
                guard let sb = LiveGameScoreboard(data: document.data()) else {
                    print("issue creating live game scoreboard")
                    return
                }
                
                gameScoreboards[document.documentID] = sb
            }
            
            self.liveGameScoreboards = gameScoreboards
        }
        
    }
    
    
    
}

// MOCK
class MockInProgressContestsRepository: InProgressContestsRepositoryProtocol, ObservableObject {
    
    @Published var inProgressContests: [String : InProgressContest] = [:]
    var inProgressContestsPublished: Published<[String : InProgressContest]> { _inProgressContests }
    var inProgressContestsPublisher: Published<[String : InProgressContest]>.Publisher { $inProgressContests }
    
    
    @Published var liveGameScoreboards: [String : LiveGameScoreboard] = [:]
    var liveGameScoreboardsPublisher: Published<[String : LiveGameScoreboard]>.Publisher { $liveGameScoreboards }
    var liveGameScoreboardsPublished: Published<[String : LiveGameScoreboard]> { _liveGameScoreboards  }
    
    // [ [String: [String: Any] ] ]
    // let mockData: [String: [String: Any]] = [
    let mockData: [ String: [String: Any] ] = [
        
        "contest1": [
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
            
            
                "upcomingGames": [
               
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
            
            
                 "completedGames": [
                    
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
            
                "inProgressGames": [
               
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
    ]
    
    
    init() {
        getInProgressContests()
    }
    
    func getInProgressContests(){
        
        
        var contests: [String: InProgressContest] = [:]
        
        for (contestId, contestData) in self.mockData {

            contests[contestId] = InProgressContest(data: contestData, playerUid: "testToddUid")!
        }
        
        self.inProgressContests = contests
    }
}






