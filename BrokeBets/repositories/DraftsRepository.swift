//
//  DraftsRepository.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/10/21.
//

import Foundation
import FirebaseFirestore
import Combine



protocol DraftsRepositoryProtocol {

    var drafts: [String: Draft] { get }
    var draftsPublisher: Published<[String: Draft]>.Publisher { get }
    var draftsPublished: Published<[String: Draft]> { get }
    
    func makeDraftPickSelection(draftPickSelection: DraftPickSelection, draft: Draft, completion: @escaping (Result<Void, Error>) -> Void)
    func getDrafts(uid: String) -> Void
    
}

final class DraftsRepository: DraftsRepositoryProtocol, ObservableObject {
 
    @Published var drafts: [String: Draft] = [:]
    var draftsPublisher: Published<[String: Draft]>.Publisher { $drafts }
    var draftsPublished: Published<[String: Draft]> { _drafts }
    
    private var user: User
    private var db = Firestore.firestore()
    private var draftsListenerHandle: ListenerRegistration? = nil
    
    init(user: User){
        self.user = user
        getDrafts(uid: user.uid)
    }
    
    func getDrafts(uid: String) {
        
        self.draftsListenerHandle = db.collection("drafts")
            .whereField("draftStatus", isEqualTo: "active")
            .whereField("players", arrayContains: uid)
            .addSnapshotListener { (querySnapshot, error) in
                
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                var drafts: [String: Draft] = [:]
                
                for document in documents {
                    
                    guard let draft = Draft(data: document.data(), playerUid: uid) else {
                        print("Issue getting draft")
                        return
                    }
                    
                    drafts[document.documentID] = draft
                    
                }
                
                self.drafts = drafts
            }
    }
    
    
    func makeDraftPickSelection(draftPickSelection: DraftPickSelection, draft: Draft, completion: @escaping (Result<Void, Error>) -> Void){
        
        let userLookupPrefix = draft.userPlayerType.rawValue
        let oppLookupPrefix = draft.oppPlayerType.rawValue
        
        let player1_uid: String
        let player1_uname: String
        let player2_uid: String
        let player2_uname: String
        
        var isDraftCompleted: Bool = false
        var newDraftRound = draft.currentRound
        var games_pool = draft.gamesPool
        
        
        let batch = db.batch()
        
        guard let affected_gameId = draftPickSelection.draftedPick["gameId"] as? String else {
            fatalError("something is really wrong: gameId is not in the draftedPick dictionary for the draft pick selection")
        }
        
        guard let affectedGameIndex = games_pool.firstIndex(where:{$0.gameId == affected_gameId}) else {
            fatalError("something is really wrong: gameId of the selected pick is for a game that is not among the games in the games_pool")
        }
        

        guard let betTypeOfPick = BetType(rawValue: draftPickSelection.draftedPick["betType"] as! String) else {
            fatalError("something is really wrong: the betType is not in the draftedPick dictionary for the draft pick selection")
        }
        
        
        
        
        
        if draft.userPlayerType == .PlayerTwo {
            
            player1_uid = draft.opponent_uid
            player1_uname = draft.opponent
            player2_uid = self.user.uid
            player2_uname = self.user.username!
            
            if draft.currentRound == draft.totalRounds {
                isDraftCompleted = true
            }
            else{
                newDraftRound += 1
            }
        }
        else {
            
            player1_uid = self.user.uid
            player1_uname = self.user.username!
            player2_uid = draft.opponent_uid
            player2_uname = draft.opponent
        }
        
        
        
        // update the appropriate field that tracks whether a bet type for a given game is still available to be betted on for the given draft and updates the bets strings for each player for the respective game
        switch(betTypeOfPick){
        
            case .overUnder:
                
                games_pool[affectedGameIndex].updateOverUnderBetAvailablity(to: false)
                
                games_pool[affectedGameIndex].updatePlayerOverUnderBetStrings(userLookupType: draft.userPlayerType, userBetStr: draftPickSelection.draftedPick["betInfo"] as! String, oppBetStr: draftPickSelection.inversePick["betInfo"] as! String)
                
                games_pool[affectedGameIndex].updateOverUnderBetDrafter(drafterPlayerLookupType: draft.userPlayerType)
        
            case .spread:
                games_pool[affectedGameIndex].updateSpreadBetAvailablity(to: false)
                
                games_pool[affectedGameIndex].updatePlayerSpreadBetStrings(userLookupType: draft.userPlayerType, userBetStr: draftPickSelection.draftedPick["betInfo"] as! String, oppBetStr: draftPickSelection.inversePick["betInfo"] as! String)
                
                games_pool[affectedGameIndex].updateSpreadBetDrafter(drafterPlayerLookupType: draft.userPlayerType)
        }
            
        
        
        // if the draft will be completed with this pick then we will also create a new upcoming contest with the draft info
        if isDraftCompleted {
            
            
            var associatedGameIds: Set<String> = []
            var earliestGameStartDateTime: Date = Calendar.current.date(byAdding: .year, value: 1, to: Date())!
            
            let newContestDocRef = db.collection("contests").document()
            
            
            let upcomingContestGames: [[String: Any]] = games_pool.compactMap { game in
                
                if game.isSpreadBetStillAvailable && game.isOverUnderBetStillAvailable {
                    return nil
                }
                
                
                if(game.gameStartDateTime < earliestGameStartDateTime){
                    earliestGameStartDateTime = game.gameStartDateTime
                }
                
                associatedGameIds.insert(game.gameId)
                
                var upcomingContestGame: [String: Any] = [:]
                
                upcomingContestGame["gameId"] = game.gameId
                upcomingContestGame["homeTeam"] = game.homeTeam
                upcomingContestGame["awayTeam"] = game.awayTeam
                upcomingContestGame["gameStartDateTime"] = Timestamp(date: game.gameStartDateTime)
                
                if !game.isSpreadBetStillAvailable {
                    
                    upcomingContestGame["spreadBet"] = [
                        
                        "player1": game.player1_spreadBetStr!,
                        "player2": game.player2_spreadBetStr!,
                        "drafter": game.spreadBetDrafter!
                    ]
                }
                
                if !game.isOverUnderBetStillAvailable {
                    
                    upcomingContestGame["overUnderBet"] = [
                        
                        "player1": game.player1_ouBetStr!,
                        "player2": game.player2_ouBetStr!,
                        "drafter": game.ouBetDrafter!
                    ]
                }
                
                return upcomingContestGame
            }
            
            
            // creates new contest from draft
            batch.setData([
            
                "contestId": newContestDocRef.documentID,
                "contestStatus": "upcoming",
                "firstGameStartDateTime": Timestamp(date: earliestGameStartDateTime),
                "player1_uid": player1_uid,
                "player1_uname": player1_uname,
                "player2_uid": player2_uid,
                "player2_uname": player2_uname,
                "players": [player1_uid, player2_uid],
                "numBets": draft.totalRounds * 2,
                "upcoming_games": upcomingContestGames
            
            ], forDocument: newContestDocRef)
            
            
            
            // get draft_expiration_subscription doc ref
            let draftExpirationDocId = draft.draftExpirationDateTime.customUTCDateString()
            let draftExpirationSubDocRef = db.collection("draft_expiration_subscriptions").document(draftExpirationDocId)
            
            // removes the draft id from the array of ids for its corresponding expiration time so that it is not marked as expired when that time comes
            batch.updateData([
                "draftIds": FieldValue.arrayRemove([draft.draftId])
            ], forDocument: draftExpirationSubDocRef)
            
            
            // find all the gameIds for the games that are associated with the bets that were drafted
            associatedGameIds.forEach({ gameId in
                
                let associatedContestsDocRef = db.collection("associated_contests").document("\(gameId)")
                
                batch.updateData([
                    "contestIds": FieldValue.arrayUnion([newContestDocRef.documentID])
                ], forDocument: associatedContestsDocRef)
                
            })
            
        }
        
        
        let draftDocRef = db.collection("drafts").document(draft.draftId)
        
        // update the draft document
        batch.updateData([
            "\(userLookupPrefix)_drafted_picks": FieldValue.arrayUnion([draftPickSelection.draftedPick]),
            "\(oppLookupPrefix)_forced_picks": FieldValue.arrayUnion([draftPickSelection.inversePick]),
            "currentRound": newDraftRound,
            "draftStatus": isDraftCompleted ? "completed" : "active",
            "currentPlayerTurn": oppLookupPrefix,
            "games_pool": games_pool.map {$0.dictionary}
        ], forDocument: draftDocRef)
        
        
        // commits the batch
        batch.commit { err in
            if let err = err {
                
                print("error committing batch for drafts repository")
                print(err.localizedDescription)
                completion(.failure(err))
            } else {
                completion(.success(())) // ewwww why so many parenthesis, swift?
            }
        }
    }
    
    
    deinit {
        self.draftsListenerHandle?.remove()
        print("listener for drafts has been removed")
    }
    
}


final class MockDraftsRepository: DraftsRepositoryProtocol, ObservableObject {
    
    @Published var drafts: [String: Draft] = [:]
    var draftsPublisher: Published<[String: Draft]>.Publisher { $drafts }
    var draftsPublished: Published<[String: Draft]> { _drafts }
    
    private var user: User
    
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
                                "spreadFavoriteBetStr": "EVEN", // "HOU -4"
                                "spreadUnderdogBetStr": "EVEN", // "CLE +4"
                                "doesSpreadBetExist": false,
                                "overBetStr": "o 218.5",
                                "underBetStr": "u 218.5",
                                "player1_spreadBetStr": "HOU -4",
                                "player2_spreadBetStr": "CLE +4",
                                "spreadBetDrafter": "player1"
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
                                "doesSpreadBetExist": true,
                                "overBetStr": "o 224.5",
                                "underBetStr": "u 224.5",
                                "player1_ouBetStr": "u 224.5",
                                "player2_ouBetStr": "o 224.5",
                                "ouBetDrafter": "player1"
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
                                "doesSpreadBetExist": true,
                                "overBetStr": "o 225",
                                "underBetStr": "u 225",
                                "player1_ouBetStr": "o 225",
                                "player2_ouBetStr": "u 225",
                                "ouBetDrafter": "player2"
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
                                "doesSpreadBetExist": true,
                                "overBetStr": "o 221",
                                "underBetStr": "u 221",
                                "player1_spreadBetStr": "CHI +3.5",
                                "player2_spreadBetStr": "POR -3.5",
                                "spreadBetDrafter": "player2"
                            ],
                        ]
                ]
    ]
    
    
    
    init(user: User){
        
        self.user = user
        getDrafts(uid: user.uid)
    }
    
    func getDrafts(uid: String) {
        
        
        var drafts: [String: Draft] = [:]
        
        
        for (draftId, draftData) in self.mockData {
            
            drafts[draftId] = Draft(data: draftData, playerUid: uid)!
           
        }
       
        self.drafts = drafts
    }
    
    func makeDraftPickSelection(draftPickSelection: DraftPickSelection, draft: Draft, completion: @escaping (Result<Void, Error>) -> Void){
        completion(.success(()))
    }
    
    func stopListeningForDrafts(){
        
        print("no longer listening for drafts data")
    }
    
}

