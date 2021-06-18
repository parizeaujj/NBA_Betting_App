//
//  CreateContestInvitationService.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/17/21.
//

import Foundation
import FirebaseFirestore


enum ContestCreationResult: String {
    case success = ""
    case no_games_left = "Sorry, there are no available games to bet on right now. Try again later."
    case not_enough_games_failure = "Not enough games available. Select a different value for the number of draft rounds."
    case db_failure = "Sorry, there was an error creating your contest invitation, please try again."
}


protocol CreateContestInvitationServiceProtocol {
        
    typealias AvailableGame = DraftGame
    
    var maxAvailableDraftRounds: Int { get }
    var maxAvailableDraftRoundsPublisher: Published<Int>.Publisher  { get }
    var maxAvailableDraftRoundsPublished: Published<Int>  { get }
    
    
    
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
    
    @Published var maxAvailableDraftRounds: Int = 0
    var maxAvailableDraftRoundsPublisher: Published<Int>.Publisher { $maxAvailableDraftRounds }
    var maxAvailableDraftRoundsPublished: Published<Int> { _maxAvailableDraftRounds }
    
    
    var mockData: [[String: Any]] = [

        [
            "gameId": "gameid1",
            "homeTeam": "HOU Rockets",
            "awayTeam": "CLE Cavaliers",
            "gameStartDateTime": Timestamp(date: Date()),
            "isSpreadBetStillAvailable": true,
            "isOverUnderBetStillAvailable": true,
            "isHomeTeamFavorite": true,
            "spreadFavoriteBetStr": "HOU -4",
            "spreadUnderdogBetStr": "CLE +4",
            "doesSpreadBetExist": true,
            "overBetStr": "o 218.5",
            "underBetStr": "u 218.5"
        ],
        
        [
            "gameId": "gameid2",
            "homeTeam": "LA Clippers",
            "awayTeam": "SA Spurs",
            "gameStartDateTime": Timestamp(date: Date()),
            "isSpreadBetStillAvailable": true,
            "isOverUnderBetStillAvailable": true,
            "isHomeTeamFavorite": false,
            "spreadFavoriteBetStr": "SA -3",
            "spreadUnderdogBetStr": "LA +3",
            "doesSpreadBetExist": true,
            "overBetStr": "o 224.5",
            "underBetStr": "u 224.5"
        ],
        [
            "gameId": "gameid3",
            "homeTeam": "PHI 76ers",
            "awayTeam": "GS Warriors",
            "gameStartDateTime": Timestamp(date: Date()),
            "isSpreadBetStillAvailable": true,
            "isOverUnderBetStillAvailable": true,
            "isHomeTeamFavorite": true,
            "spreadFavoriteBetStr": "PHI -5",
            "spreadUnderdogBetStr": "GS +5",
            "doesSpreadBetExist": true,
            "overBetStr": "o 225",
            "underBetStr": "u 225"
        ],
        [
            "gameId": "gameid4",
            "homeTeam": "CHI Bulls",
            "awayTeam": "POR Trail Blazers",
            "gameStartDateTime": Timestamp(date: Date()),
            "isSpreadBetStillAvailable": true,
            "isOverUnderBetStillAvailable": true,
            "isHomeTeamFavorite": false,
            "spreadFavoriteBetStr": "POR -3.5",
            "spreadUnderdogBetStr": "CHI +3.5",
            "doesSpreadBetExist": true,
            "overBetStr": "o 221",
            "underBetStr": "u 221"
        ]
    ]
    
    
    let extraGame: [String: Any] = [
    
        "gameId": "gameid5",
        "homeTeam": "NO Pelicans",
        "awayTeam": "SAC Kings",
        "gameStartDateTime": Timestamp(date: Date()),
        "isSpreadBetStillAvailable": true,
        "isOverUnderBetStillAvailable": true,
        "isHomeTeamFavorite": true,
        "spreadFavoriteBetStr": "NO -8",
        "spreadUnderdogBetStr": "SAC +8",
        "doesSpreadBetExist": true,
        "overBetStr": "o 223",
        "underBetStr": "u 223"
    ]
    
    init(user: User){
        self.user = user
        
        getAvailableGames()
        
        addAvailableGameAfterTenSeconds()
    }
    
    func getAvailableGames(){
       
        var numBetsAvailable: Int = 0
        var availableGames: [AvailableGame] = []
        
        for game in self.mockData {
            
            availableGames.append(AvailableGame(data: game)!)
            
            guard let doesSpreadBetExist = game["doesSpreadBetExist"] as? Bool else{
                print("Error getting doesSpreadBetExist")
                return
            }
            
            if doesSpreadBetExist {
                numBetsAvailable += 1
            }
            
            numBetsAvailable += 1
            
        }
        
        self.maxAvailableDraftRounds = Int(numBetsAvailable / 2)
        self.availableGames = availableGames
    }
    
    func createContestInvitation(selectedOpponent: User, numDraftRounds: Int, completion: @escaping (ContestCreationResult) -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            completion(.no_games_left)
        }
    }
    
    func addAvailableGameAfterTenSeconds(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.availableGames.append(AvailableGame(data: self.extraGame)!)
            print("after 10 seconds...")
        }
    }
}



class CreateContestInvitationService: ObservableObject, CreateContestInvitationServiceProtocol {
        
    @Published var availableGames: [AvailableGame] = []
    var availableGamesPublisher: Published<[AvailableGame]>.Publisher { $availableGames }
    var availableGamesPublished: Published<[AvailableGame]> { _availableGames }
    
    
    @Published var maxAvailableDraftRounds: Int = 0
    var maxAvailableDraftRoundsPublisher: Published<Int>.Publisher { $maxAvailableDraftRounds }
    var maxAvailableDraftRoundsPublished: Published<Int> { _maxAvailableDraftRounds }
    
    
    
    
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
                
                var numBetsAvailable: Int = 0
                
                for document in documents {
                    
                    var data = document.data()
                    
                    guard let doesSpreadBetExist = data["doesSpreadBetExist"] as? Bool else {
                        print("Error getting doesSpreadBetExist")
                        return
                    }
                    
                    if doesSpreadBetExist {
                        // inject default data
                        data["isSpreadBetStillAvailable"] = true
                        numBetsAvailable += 1
                    }
                    else{
                        // inject default data
                        data["isSpreadBetStillAvailable"] = false
                    }
                    
                    
                    // inject default data
                    data["isOverUnderBetStillAvailable"] = true
                    data["doesSpreadBetExist"] = doesSpreadBetExist
                    numBetsAvailable += 1
                    
                    guard let game = AvailableGame(data: data) else {
                        print("Issue getting available game")
                        return
                    }
                    
                    availableGames.append(game)
                    
                }
                
                
                self.maxAvailableDraftRounds = Int(numBetsAvailable / 2)
                self.availableGames = availableGames
                
            }
    }
    
    func createContestInvitation(selectedOpponent: User, numDraftRounds: Int, completion: @escaping (ContestCreationResult) -> Void){
        
        let invitor_uid = self.user.uid
        let invitor_uname = self.user.username! 
        
        let recipient_uid = selectedOpponent.uid
        let recipient_uname = selectedOpponent.username
        
        let numAvailableRounds = self.maxAvailableDraftRounds
                
        guard numAvailableRounds != 0 else {
            completion(.no_games_left)
            return
        }
        
        guard numDraftRounds <= numAvailableRounds else {
            completion(.not_enough_games_failure)
            return
        }
        
        
        let sortedGames = self.availableGames.sorted { $0.gameStartDateTime < $1.gameStartDateTime }
        
//        let latestAcceptableGameStart = sortedGames[numAvailableRounds - numDraftRounds].gameStartDateTime
        
//        let invitationExpirationDateTime = Calendar.current.date(byAdding: .minute, value: -30, to: latestAcceptableGameStart)!
        let earliestAvailableGameStart = sortedGames[0].gameStartDateTime
        let invitationExpirationDateTime = Calendar.current.date(byAdding: .minute, value: -30, to: earliestAvailableGameStart)!
        
        let id = invitationExpirationDateTime.customUTCDateString()

        let expirationSubDocRef = db.collection("invitation_expiration_subscriptions").document(id)
        let newInvitationDocRef = db.collection("invitations").document()
        
        
        // batched write
        let batch = db.batch();
        
        // creates the invitation document
        batch.setData([
            
            "invitationId": newInvitationDocRef.documentID,
            "invitationStatus": "pending",
            "invitor_uid": invitor_uid,
            "invitor_uname": invitor_uname,
            "recipient_uid": recipient_uid,
            "recipient_uname": recipient_uname!,
            "draftRounds": numDraftRounds,
            "expirationDateTime": Timestamp(date: invitationExpirationDateTime),
            "games_pool": self.availableGames.map { $0.dictionary }
        
        ], forDocument: newInvitationDocRef)
        
      
        // adds the newly created invitation id to the array of ids for its corresponding expiration time so that it is watched for expiration
        batch.updateData([
            "invitationIds": FieldValue.arrayUnion([newInvitationDocRef.documentID])
        ], forDocument: expirationSubDocRef)
        
        
        
        let recNotifTrackerDocRef = db.collection("user_notifications_tracker").document(recipient_uid)
        
        // increments the counter for pending recieved invitations for the recipient of the invitation so that they can be properly notified of it
        batch.setData([
            "numPendingRecInvitations": FieldValue.increment(1.0)
        ], forDocument: recNotifTrackerDocRef, merge: true)
        
        
        
        batch.commit { error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(.db_failure)
                return
            }
            
            completion(.success)
            
        }
    }
}
