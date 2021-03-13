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

    var drafts: [String: Draft] { get }
    var draftsPublisher: Published<[String: Draft]>.Publisher { get }
    var draftsPublished: Published<[String: Draft]> { get }
    
    
    func getDrafts() -> Void
    
}

final class DraftsRepository: DraftsRepositoryProtocol, ObservableObject {
    
    @Published var drafts: [String: Draft] = [:]
    var draftsPublisher: Published<[String: Draft]>.Publisher { $drafts }
    var draftsPublished: Published<[String: Draft]> { _drafts }
    
    private var db = Firestore.firestore()
    
    func getDrafts() {
        
        
        
    }
}


final class MockDraftsRepository: DraftsRepositoryProtocol, ObservableObject {
    
    @Published var drafts: [String: Draft] = [:]
    var draftsPublisher: Published<[String: Draft]>.Publisher { $drafts }
    var draftsPublished: Published<[String: Draft]> { _drafts }
    
    
    let mockData: [ String: [String: Any] ] = [
        
        
        "draftid1":
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
                                "betInfo": "u 224.5",
                                "betDisplayStr": "u 224.5 (LAC vs SA)"
                            ]
                        ],
                        "player1_forced_picks": [
                            [
                                "round": 2,
                                "gameId": "gameid3",
                                "betType": "overUnder",
                                "betInfo": "o 225",
                                "betDisplayStr": "o 225 (PHI vs GS)"
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
                                "betInfo": "u 225",
                                "betDisplayStr": "u 225 (PHI vs GS)"
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
                                "betInfo": "o 224.5",
                                "betDisplayStr": "o 224.5 (LAC vs SA)"
                            ]
                        
                        ],
                        "games_pool": [
                        
                            [
                                "gameId": "gameid1",
                                "homeTeam": "HOU Rockets",
                                "awayTeam": "CLE Cavaliers",
                                "gameStartDateTime": Timestamp(date: Date()),
                                "isSpreadBetStillAvailable": false,
                                "isOverUnderBetStillAvailable": true,
                                "isHomeTeamFavorite": true,
                                "spreadFavoriteBetStr": "HOU -4",
                                "spreadUnderdogBetStr": "CLE +4",
                                "overBetStr": "o 218.5",
                                "underBetStr": "u 218.5"
                            ],
                            
                            [
                                "gameId": "gameid2",
                                "homeTeam": "LA Clippers",
                                "awayTeam": "SA Spurs",
                                "gameStartDateTime": Timestamp(date: Date()),
                                "isSpreadBetStillAvailable": true,
                                "isOverUnderBetStillAvailable": false,
                                "isHomeTeamFavorite": false,
                                "spreadFavoriteBetStr": "SA -3",
                                "spreadUnderdogBetStr": "LA +3",
                                "overBetStr": "o 224.5",
                                "underBetStr": "u 224.5"
                            ],
                            [
                                "gameId": "gameid3",
                                "homeTeam": "PHI 76ers",
                                "awayTeam": "GS Warriors",
                                "gameStartDateTime": Timestamp(date: Date()),
                                "isSpreadBetStillAvailable": true,
                                "isOverUnderBetStillAvailable": false,
                                "isHomeTeamFavorite": true,
                                "spreadFavoriteBetStr": "PHI -5",
                                "spreadUnderdogBetStr": "GS +5",
                                "overBetStr": "o 225",
                                "underBetStr": "u 225"
                            ],
                            [
                                "gameId": "gameid4",
                                "homeTeam": "CHI Bulls",
                                "awayTeam": "POR Trail Blazers",
                                "gameStartDateTime": Timestamp(date: Date()),
                                "isSpreadBetStillAvailable": false,
                                "isOverUnderBetStillAvailable": true,
                                "isHomeTeamFavorite": false,
                                "spreadFavoriteBetStr": "POR -3.5",
                                "spreadUnderdogBetStr": "CHI +3.5",
                                "overBetStr": "o 221",
                                "underBetStr": "u 221"
                            ],
                        ]
                ]
    ]
    
    
    
    init(){
        getDrafts()
    }
    
    func getDrafts() {
        
        
        var drafts: [String: Draft] = [:]
        
        
        for (draftId, draftData) in self.mockData {
            
            drafts[draftId] = Draft(data: draftData, playerUid: "testToddUid")!
           
        }
       
        self.drafts = drafts
    }
}

