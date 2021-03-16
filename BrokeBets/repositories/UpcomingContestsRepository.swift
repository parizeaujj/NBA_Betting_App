//
//  File.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/20/21.
//
import Foundation
import FirebaseFirestore

protocol UpcomingContestsRepositoryProtocol {

    var upcomingContests: [UpcomingContest] { get }
    var upcomingContestsPublisher: Published<[UpcomingContest]>.Publisher { get }
    var upcomingContestsPublished: Published<[UpcomingContest]> { get }
    
    
    func getUpcomingContests(uid: String) -> Void
    
}


// MOCK
class MockUpcomingContestsRepository: UpcomingContestsRepositoryProtocol, ObservableObject {
    
    
    @Published var upcomingContests: [UpcomingContest] = []
    var upcomingContestsPublished: Published<[UpcomingContest]> { _upcomingContests }
    var upcomingContestsPublisher: Published<[UpcomingContest]>.Publisher { $upcomingContests }
    

    
    
    let mockData: [[String: Any]] = [
            ["firstGameStartDateTime": Timestamp(date: Date()),
             "player1_uid": "testToddUid",
             "player1_uname": "todd123",
             "player2_uid": "testOppUid",
             "player2_uname": "testOpp",
             "numBets": 3,
             "games": [
                
                        // game 1
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
                        
                        // game 2
                        ["awayTeam": "GS Warriors",
                         "homeTeam": "NY Knicks",
                         "gameStartDateTime": Timestamp(date: Date()),
                         "spreadBet": [
                                "player1": "GS -3.5",
                                "player2": "NY +3.5"
                         ]
                        ]
                
                    ]
            ]
        ]
    
    
    
    init(previewData: [UpcomingContest]) {
        self.upcomingContests = previewData
    }
    
    init(uid: String){
        getUpcomingContests(uid: uid)
    }
    
    
    func getUpcomingContests(uid: String) {
        
        self.upcomingContests = self.mockData.map { contest -> UpcomingContest in
                    
                    UpcomingContest(data: contest, playerUid: uid)!
                    
                }
    }
}




class UpcomingContestsRepository: UpcomingContestsRepositoryProtocol, ObservableObject {
    
    @Published var upcomingContests: [UpcomingContest] = []
    var upcomingContestsPublished: Published<[UpcomingContest]> { _upcomingContests }
    var upcomingContestsPublisher: Published<[UpcomingContest]>.Publisher { $upcomingContests }
        
    private var db = Firestore.firestore()
    private var upcomingContestsListenerHandle: ListenerRegistration? = nil
    
    
    init(uid: String) {
       
        getUpcomingContests(uid: uid)
    }
    
    func getUpcomingContests(uid: String) {
        
        self.upcomingContestsListenerHandle = db.collection("contests")
            .whereField("contestStatus", isEqualTo: "upcoming")
            .whereField("players", arrayContains: uid)
            .addSnapshotListener { (querySnapshot, error) in
                
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            var contests: [UpcomingContest] = []
            
            // Loops through each upcoming contest from firebase
            for document in documents{
                guard let contest = UpcomingContest(data: document.data(), playerUid: uid) else {
                    print("Issue getting contest")
                    return
                }
                
                contests.append(contest)
            }
            
            // Updates the publisher to the new values
            self.upcomingContests = contests
        }
    }
    
    deinit {
        self.upcomingContestsListenerHandle?.remove()
        print("listener for upcoming contests has been removed")
    }
}
