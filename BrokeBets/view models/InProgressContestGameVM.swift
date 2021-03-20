//
//  InProgressContestGameVM.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/6/21.
//

import Combine

class InProgressContestGameVM: ObservableObject {
    
    @Published var gameScoreboard: LiveGameScoreboard
    var game: InProgressContestGame
    private var inProgressContestsRepo: InProgressContestsRepositoryProtocol
    
    private var cancellables: [AnyCancellable] = []

    init(game: InProgressContestGame, inProgressContestsRepo: InProgressContestsRepositoryProtocol){
        
        let gameId = game.gameId
        let homeTeam = game.homeTeam
        let awayTeam = game.awayTeam
        
        self.gameScoreboard = LiveGameScoreboard(homeTeam: homeTeam, awayTeam: awayTeam, timeLeftStr: "1st 12:00")
        self.game = game
        self.inProgressContestsRepo = inProgressContestsRepo
        
        getGameScore(gameId: gameId)
    }
    
    func getGameScore(gameId: String){
        
        inProgressContestsRepo.liveGameScoreboardsPublisher
            .sink { scoreboards in
                
                if let scoreboard = scoreboards[gameId] {
                    
                    // makes sure that the score or time left has changed since last proposed update, if it hasnt then dont update the local copy of it
                    if scoreboard.homeScore != self.gameScoreboard.homeScore || scoreboard.awayScore != self.gameScoreboard.awayScore || scoreboard.timeLeftStr != self.gameScoreboard.timeLeftStr {
                        
                        self.gameScoreboard = scoreboard
                    }
                    
                }
                else{
                    print("Game was not found")
                    
                }
            }
            .store(in: &cancellables)
    }
}
