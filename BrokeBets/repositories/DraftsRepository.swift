//
//  DraftsRepository.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/10/21.
//

import Foundation

import Foundation
import FirebaseFirestore
import Combine

protocol DraftsRepositoryProtocol{

    var drafts: [Draft] { get }
    var draftsPublisher: Published<[Draft]>.Publisher { get }
    var draftsPublished: Published<[Draft]> { get }
    
    
    func getDrafts() -> Void
    
}

final class DraftsRepository: DraftsRepositoryProtocol, ObservableObject {
    
    @Published var drafts: [Draft] = []
    var draftsPublisher: Published<[Draft]>.Publisher { $drafts }
    var draftsPublished: Published<[Draft]> { _drafts }
    
    private var db = Firestore.firestore()
    
    func getDrafts() {
        
        
        
    }
    
}


final class MockDraftsRepository: DraftsRepositoryProtocol, ObservableObject {
    
    @Published var drafts: [Draft] = []
    var draftsPublisher: Published<[Draft]>.Publisher { $drafts }
    var draftsPublished: Published<[Draft]> { _drafts }
    
    
    let mockData: [  [String: Any]  ] = [
        [
            "draftId": "draftid1",
            "player1_uid": "testToddUid",
            "player1_uname": "todd123",
            "player2_uid": "testOppUid",
            "player2_uname": "testopp",
            "currentPlayerTurn": "player1",
            "currentRound": 3,
            "totalRounds": 5,
            "draftExpirationDateTime": Timestamp(date: Date()),
            "player1_drafted_picks": [
                [
                    "round": 2,
                    "gameId": "gameid1",
                    "betType": "spread",
                    "betInfo": "HOU -4",
                    "betDisplayStr": "HOU -4 (vs CLE)"
                ],
                [
                    "round": 1,
                    "gameId": "gameid2",
                    "betType": "overUnder",
                    "betInfo": "UNDER 224.5",
                    "betDisplayStr": "UNDER 224.5 (LAC vs SA)"
                ]
            ],
            "player1_forced_picks": [
                [
                    "round": 2,
                    "gameId": "gameid3",
                    "betType": "overUnder",
                    "betInfo": "OVER 225",
                    "betDisplayStr": "OVER 225 (PHI vs GS)"
                ],
                [
                    "round": 1,
                    "gameId": "gameid4",
                    "betType": "spread",
                    "betInfo": "CHI +3.5",
                    "betDisplayStr": "CHI +3.5 (vs POR)"
                ]
            ],
            "player2_drafted_picks": [
                [
                    "round": 2,
                    "gameId": "gameid3",
                    "betType": "overUnder",
                    "betInfo": "UNDER 225",
                    "betDisplayStr": "UNDER 225 (PHI vs GS)"
                ],
                [
                    "round": 1,
                    "gameId": "gameid4",
                    "betType": "spread",
                    "betInfo": "POR -3.5",
                    "betDisplayStr": "POR -3.5 (vs CHI)"
                ]
            ],
            "player2_forced_picks": [
            
                [
                    "round": 2,
                    "gameId": "gameid1",
                    "betType": "spread",
                    "betInfo": "CLE +4",
                    "betDisplayStr": "CLE +4 (vs HOU)"
                ],
                [
                    "round": 1,
                    "gameId": "gameid2",
                    "betType": "overUnder",
                    "betInfo": "OVER 224.5",
                    "betDisplayStr": "OVER 224.5 (LAC vs SA)"
                ]
            
            ],
            "games_pool": [
            
                [
                    "gameId": "gameid1",
                    "homeTeam": "HOU Rockets",
                    "awayTeam": "CLE Cavaliers",
                    "isSpreadBetStillAvailable": false,
                    "isOverUnderBetStillAvailable": true,
                    "spreadFavoriteBetStr": "HOU -4",
                    "spreadUnderdogBetStr": "CLE +4",
                    "overBetStr": "OVER 218.5",
                    "underBetStr": "UNDER 218.5"
                ],
                
                [
                    "gameId": "gameid2",
                    "homeTeam": "LA Clippers",
                    "awayTeam": "SA Spurs",
                    "isSpreadBetStillAvailable": true,
                    "isOverUnderBetStillAvailable": false,
                    "spreadFavoriteBetStr": "SA -3",
                    "spreadUnderdogBetStr": "LA +3",
                    "overBetStr": "OVER 224.5",
                    "underBetStr": "UNDER 224.5"
                ],
                [
                    "gameId": "gameid3",
                    "homeTeam": "PHI 76ers",
                    "awayTeam": "GS Warriors",
                    "isSpreadBetStillAvailable": true,
                    "isOverUnderBetStillAvailable": false,
                    "spreadFavoriteBetStr": "PHI -5",
                    "spreadUnderdogBetStr": "GS +5",
                    "overBetStr": "OVER 225",
                    "underBetStr": "UNDER 225"
                ],
                [
                    "gameId": "gameid4",
                    "homeTeam": "CHI Bulls",
                    "awayTeam": "POR Trail Blazers",
                    "isSpreadBetStillAvailable": false,
                    "isOverUnderBetStillAvailable": true,
                    "spreadFavoriteBetStr": "POR -3.5",
                    "spreadUnderdogBetStr": "CHI +3.5",
                    "overBetStr": "OVER 221",
                    "underBetStr": "UNDER 221"
                ],
            ]
        ]
    ]
    
    
    
    init(){
        getDrafts()
    }
    
    func getDrafts() {
        
        self.drafts = self.mockData.map { draft in
            
            Draft(data: draft, playerUid: "testToddUid")!
        }
        
    }
}

