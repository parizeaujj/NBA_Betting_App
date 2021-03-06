//
//  AvailableDraftGameView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/8/21.
//

import SwiftUI

struct AvailableDraftGameView: View {
    
    var game: DraftGame
    var draftRound: Int
    var onDraftPickSelection: (DraftPickSelection) -> Void
    
    
    init(game: DraftGame, round: Int, onDraftPickSelection: @escaping (DraftPickSelection) -> Void){
        self.game = game
        self.onDraftPickSelection = onDraftPickSelection
        self.draftRound = round
    }
    
    var body: some View {
  
        HStack(spacing: 0){
                
                VStack(alignment: .leading, spacing: 0){
                    
                    Text("\(game.gameStartDateTimeStr)")
                        .font(.caption)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.top, 8)
                        .padding(.bottom, 2)
                        .padding(.leading)
                    
                    Rectangle().frame(width: nil, height: 1.5, alignment: .bottom).foregroundColor(Color.gray)
                    
                    HStack(spacing: 0){
                        
                        VStack(alignment: .leading, spacing: 0){
                            
                            Text("\(game.awayTeam)")
                                .lineLimit(1)
                                .font(.subheadline)
                                .padding(.leading)
                                .padding(.top, 11)
                                .padding(.bottom, 14)
                            
                            
                            Text("\(game.homeTeam)")
                                .font(.subheadline)
                                .padding(.leading)
                                .padding(.top, 14)
                                .padding(.bottom, 11)
                            
                        }
                    
                        Spacer()
                        
                        Rectangle().frame(width: 1.5, height: nil, alignment: .leading).foregroundColor(Color.gray)
                    }
                    .frame(minWidth: 155)
                    .background(Color.gray.opacity(0.12))
                    
                }
                .fixedSize(horizontal: false, vertical: true)
                
                VStack(spacing: 0){
                    
                    Text("Spread")
                        
                        .font(.caption)
                        .padding(.top, 8)
                        .padding(.bottom, 2)
                        .padding(.trailing, 1.5)
                    
                    Rectangle().frame(width: nil, height: 1.5, alignment: .bottom).foregroundColor(Color.gray)
                    
                    HStack(spacing:0){
                        
                        VStack(spacing: 0){
                            
                            Button(action: {
                                
                                let pick = DraftPickSelection(gameId: game.gameId, round: draftRound, pick: game.awaySpreadBetStr, inversePick: game.homeSpreadBetStr, homeTeam: game.homeTeam, awayTeam: game.awayTeam, betType: .spread)
                                
                                self.onDraftPickSelection(pick)
                                
                            }, label: {
                                
                                DraftBetCapsule(label: game.awaySpreadBetStr, isDisabled: !game.isSpreadBetStillAvailable)
                                    .padding(.top, 7)
                                    .padding(.bottom, 10)
                                
                            })
                            .disabled(!game.isSpreadBetStillAvailable)
                            
                            
                            Button(action: {
                                
                                let pick = DraftPickSelection(gameId: game.gameId, round: draftRound, pick: game.homeSpreadBetStr, inversePick: game.awaySpreadBetStr, homeTeam: game.homeTeam, awayTeam: game.awayTeam, betType: .spread)
                                
                                self.onDraftPickSelection(pick)
                                
                            }, label: {
                                
                                DraftBetCapsule(label: game.homeSpreadBetStr, isDisabled: !game.isSpreadBetStillAvailable)
                                    .padding(.top, 10)
                                    .padding(.bottom, 7)
                                
                            })
                            .disabled(!game.isSpreadBetStillAvailable)
                        
                            
                        }
                        
                        Rectangle().frame(width: 1.5, height: nil, alignment: .leading).foregroundColor(Color.gray)
                    }
                   
                    .background(Color.gray.opacity(0.12))
                   
                }
                .fixedSize()
               
                VStack(spacing: 0){
                    
                    Text("O/U")
                        .font(.caption)
                        .padding(.bottom, 2)
                        .padding(.top, 8)
                    Rectangle().frame(width: nil, height: 1.5, alignment: .bottom).foregroundColor(Color.gray)
                    
                    HStack(spacing: 0){
                         
                        VStack(spacing: 0){

                            Button(action: {
                                
                                let pick = DraftPickSelection(gameId: game.gameId, round: draftRound, pick: game.overBetStr, inversePick: game.underBetStr, homeTeam: game.homeTeam, awayTeam: game.awayTeam, betType: .overUnder)
                                
                                self.onDraftPickSelection(pick)
                                
                            }, label: {
                                
                                DraftBetCapsule(label: game.overBetStr, isDisabled: !game.isOverUnderBetStillAvailable)
                                    .padding(.top, 10)
                                    .padding(.bottom, 7)
                                
                            }).disabled(!game.isOverUnderBetStillAvailable)
                            
                            Button(action: {
                                let pick = DraftPickSelection(gameId: game.gameId, round: draftRound, pick: game.underBetStr, inversePick: game.overBetStr, homeTeam: game.homeTeam, awayTeam: game.awayTeam, betType: .overUnder)
                                
                                self.onDraftPickSelection(pick)
                            }, label: {
                                
                                DraftBetCapsule(label: game.underBetStr, isDisabled: !game.isOverUnderBetStillAvailable)
                                    .padding(.top, 7)
                                    .padding(.bottom, 10)
                                
                            })
                            .disabled(!game.isOverUnderBetStillAvailable)

                        }
                    }
                    .background(Color.gray.opacity(0.12))
                    
                }
                .fixedSize()
                
        }
        .accentColor(.black)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1.0))
//        .padding(.horizontal, 10)
        
    }
}



struct AvailableDraftGameView_Previews: PreviewProvider {
    static var previews: some View {
        
        
        if let games  = MockDraftsRepository(user: User(uid: "testToddUid", username: "testTodd123")).mockData["draftid1"]!["games_pool"] as? [[String: Any]]{
            
            AvailableDraftGameView(game: DraftGame(data: games[1])!, round: 1, onDraftPickSelection: {_ in })
        }
    }
}
