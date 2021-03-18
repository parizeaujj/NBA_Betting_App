//
//  CreateContestInvitationService.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/17/21.
//

import Foundation
import FirebaseFirestore


enum ContestCreationResult {
    case success
    case not_enough_games_failure
    case db_failure
}


protocol CreateContestInvitationServiceProtocol {
        
    typealias AvailableGame = DraftGame
    
    var availableGames: [AvailableGame] { get }
    var availableGamesPublisher: Published<[AvailableGame]>.Publisher { get }
    var availableGamesPublished: Published<[AvailableGame]> { get }
    
    func getAvailableGames()
    func createContestInvitation(selectedOpponent: User, numDraftRounds: Int, completion: @escaping (ContestCreationResult) -> Void)
}

class MockCreateContestInvitationService: ObservableObject, CreateContestInvitationServiceProtocol {
    
    private var user: User
    
    @Published var availableGames: [AvailableGame] = []
    var availableGamesPublisher: Published<[AvailableGame]>.Publisher { $availableGames }
    var availableGamesPublished: Published<[AvailableGame]> { _availableGames }
    
    
    let mockData: [[String: Any]] = [

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
        ]
    ]
    
    
    
    init(user: User){
        self.user = user
        
        getAvailableGames()
    }
    
    func getAvailableGames(){
       
        self.availableGames = self.mockData.map { game in
            AvailableGame(data: game)!
        }
    }
    
    func createContestInvitation(selectedOpponent: User, numDraftRounds: Int, completion: @escaping (ContestCreationResult) -> Void){
        completion(.success)
    }
}



class CreateContestInvitationService: ObservableObject, CreateContestInvitationServiceProtocol {
        
    @Published var availableGames: [AvailableGame] = []
    var availableGamesPublisher: Published<[AvailableGame]>.Publisher { $availableGames }
    var availableGamesPublished: Published<[AvailableGame]> { _availableGames }
    
    private var user: User
    private var db = Firestore.firestore()
    private var availableGamesListenerHandle: ListenerRegistration? = nil
    
    init(user: User){
        self.user = user
        
        getAvailableGames()
    }
    
    func getAvailableGames(){
       
        self.availableGamesListenerHandle = db.collection("games")
            .whereField("gameStatus", isEqualTo: "upcoming")
            .whereField("isAvailableForContestInvitation", isEqualTo: true)
            .addSnapshotListener { (querySnapshot, error) in
                
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                var availableGames: [AvailableGame] = []
                
                for document in documents {
                    
                    guard let game = AvailableGame(data: document.data()) else {
                        print("Issue getting available game")
                        return
                    }
                    
                    availableGames.append(game)
                    
                }
                
                self.availableGames = availableGames
                
            }
    }
    
    func createContestInvitation(selectedOpponent: User, numDraftRounds: Int, completion: @escaping (ContestCreationResult) -> Void){
        
   
        let invitor_uid = user.uid
        let invitor_uname = user.username
        
        let recipient_uid = selectedOpponent.uid
        let recipient_uname = selectedOpponent.username
        
        
        if self.availableGames.count <= numDraftRounds {
            completion(.not_enough_games_failure)
            return
        }
        
        let sortedGames = self.availableGames.sorted { $0.gameStartDateTime < $1.gameStartDateTime }
        
        let latestAcceptableGameStart = sortedGames[numDraftRounds].gameStartDateTime
        
        let invitationExpirationDateTime = Calendar.current.date(byAdding: .minute, value: -30, to: latestAcceptableGameStart)!
        

        // get id of invitation time by converting invitationExpirationDateTime to a UTC string
        let utcDateFormatter = DateFormatter()
        utcDateFormatter.timeZone = TimeZone(identifier: "UTC")
        utcDateFormatter.dateFormat = "yyyy-MM-dd-HH:mm"
        let id = utcDateFormatter.string(from: invitationExpirationDateTime)

        let expirationSubDocRef = db.collection("invitation_expiration_subscriptions").document(id)
        
        let newInvitationDocRef = db.collection("invitations").document()
        
        
        // batched write
        
        let batch = db.batch();
        
        batch.setData([
            
            "invitationId": newInvitationDocRef.documentID,
            "invitationStatus": "pending",
            "invitor_uid": invitor_uid,
            "invitor_uname": invitor_uname!,
            "recipient_uid": recipient_uid,
            "recipient_uname": recipient_uname!,
            "draftRounds": numDraftRounds,
            "expirationDateTime": Timestamp(date: invitationExpirationDateTime)
        
        ], forDocument: newInvitationDocRef)
        
      
        batch.updateData([
            "invitationIds": FieldValue.arrayUnion([newInvitationDocRef.documentID])
        ], forDocument: expirationSubDocRef)
        

        
        
        
    }
    
}
