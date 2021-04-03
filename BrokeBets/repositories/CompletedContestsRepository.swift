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
    
    func getCompletedContests(uid: String) -> Void
    
}

class CompletedContestsRepository: CompletedContestsRepositoryProtocol, ObservableObject {
    
    @Published var completedContests: [CompletedContest] = []
    var completedContestsPublisher: Published<[CompletedContest]>.Publisher { $completedContests }
    var completedContestsPublished: Published<[CompletedContest]> { _completedContests }
        
    private var db = Firestore.firestore()
    private var completedContestsListenerHandle: ListenerRegistration? = nil
    
    init(uid: String) {
        getCompletedContests(uid: uid)
    }
    
    func getCompletedContests(uid: String) {
        
        db.collection("contests")
            .whereField("contestStatus", isEqualTo: "completed")
            .whereField("players", arrayContains: uid)
            .addSnapshotListener { (querySnapshot, error) in
                
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            var contests: [CompletedContest] = []
            
            // Loops through each upcoming contest from firebase
            for document in documents{
                guard let contest = CompletedContest(data: document.data(), playerUid: uid) else {
                    print("Issue getting completed contest")
                    return
                }
                
                contests.append(contest)
            }
            
            // Updates the publisher to the new values
            self.completedContests = contests
        }
    }
    
    deinit {
        self.completedContestsListenerHandle?.remove()
        print("listener for upcoming contests has been removed")
    }
}

// MOCK
class MockCompletedContestsRepository: CompletedContestsRepositoryProtocol, ObservableObject {
    
    @Published var completedContests: [CompletedContest] = []
    var completedContestsPublished: Published<[CompletedContest]> { _completedContests }
    var completedContestsPublisher: Published<[CompletedContest]>.Publisher { $completedContests }
    
    let mockData: [[String: Any]] = [
        [
         "contestId": "contestId2",
         "completionDateTime": Timestamp(date: Date()),
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
         "completed_games": [
            
            // game 1
            ["awayTeam": "HOU Rockets",
             "homeTeam": "MIA Heat",
             "awayTeamScore": 97,
             "homeTeamScore": 110,
             "gameWinner" : "HOME", // can be 'HOME', 'AWAY', or 'TIE'
             "gameCompletionDateTime": Timestamp(date: Date()),
             "overUnderBetResults": [
                "player1": [
                    "bet": "u 225.5",
                    "result": "LOST"
                ],
                "player2": [
                    "bet": "o 225.5",
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
             "homeTeam": "MIN Timberwolves",
             "awayTeamScore": 115,
             "homeTeamScore": 108,
             "gameWinner" : "HOME", // can be 'HOME', 'AWAY', or 'TIE'
             "gameCompletionDateTime": Timestamp(date: Date()),
             "spreadBetResults": [
                "player1": [
                    "bet": "MIN -13.5",
                    "result": "LOST"
                ],
                "player2": [
                    "bet": "GS +13.5",
                    "result": "WON"
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
                    "bet": "o 220",
                    "result": "WON"
                ],
                "player2": [
                    "bet": "u 220",
                    "result": "LOST"
                ]
             ]
            ],
            
            
         ]
        ]
    ]
    
    
    init(uid: String) {
        getCompletedContests(uid: uid)
    }
    
    func getCompletedContests(uid: String){
        
        self.completedContests = self.mockData.map { contest -> CompletedContest in
            
            CompletedContest(data: contest, playerUid: uid)!
            
        }
    }
}






