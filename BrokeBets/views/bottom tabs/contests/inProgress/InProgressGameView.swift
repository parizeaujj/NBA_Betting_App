//
//  InProgressGameView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/4/21.
//

import SwiftUI

struct InProgressContestGameViewStyleBag {
    
    let paddings: (leadingTeamsBox: CGFloat, trailingScoresBox: CGFloat)
    let mainFontType: Font
    let secondaryFontType: Font
    let betsColFrameWidth: CGFloat
    
    init(){
        self.paddings = (10, 20) // 10 20 30 20
        self.mainFontType = .body
        self.secondaryFontType = .caption
        self.betsColFrameWidth = 107 // 87
    }
    
    init(mainFontType: Font, secondaryFontType: Font, paddings: (leadingTeamsBox: CGFloat, trailingScoresBox: CGFloat), betsColFrameWidth: CGFloat){
        self.paddings = paddings
        self.mainFontType = mainFontType
        self.secondaryFontType = secondaryFontType
        self.betsColFrameWidth = betsColFrameWidth
    }
}


struct InProgressContestGameView: View {
    
    @EnvironmentObject var userScreenInfo: UserScreenInfo
    
    var game: InProgressContestGame
    
    init(game: InProgressContestGame){
        self.game = game
    }
    
    var body: some View {
        
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.black.opacity(0.65), lineWidth: 1.2)
                
                VStack(spacing: 0) {
                    
                    HStack{
                        Text("2nd 3:26")
                            .font(.caption)
                            .foregroundColor(Color.red)
                            .fontWeight(.semibold)
                            .padding(.leading)
                            .padding(.bottom, 5)
                        Spacer()
                    }.padding(.top, 5)
                    
                    
                    Rectangle().frame(width: nil, height: 1.5, alignment: .bottom).foregroundColor(Color.gray)
                    
                    HStack(alignment: .top, spacing: 0){
                        HStack{
                            VStack(alignment: .leading) {
                                Text("\(game.homeTeam)")
                                    .lineLimit(1)
                                    .font(userScreenInfo.inProgressContestGameViewStyleBag.mainFontType)
                                    .padding(.vertical, 5)
                                
                                Text("\(game.awayTeam)")
                                    .lineLimit(1)
                                    .font(userScreenInfo.inProgressContestGameViewStyleBag.mainFontType)
                                    .padding(.vertical, 5)
                            }
                            .padding(.leading, userScreenInfo.inProgressContestGameViewStyleBag.paddings.leadingTeamsBox) // 15, 10)
                            
                            Spacer()
                            
                            VStack(alignment: HorizontalAlignment.trailing) {
                                Text("0")
                                    .font(userScreenInfo.inProgressContestGameViewStyleBag.mainFontType)
                                    .padding(.vertical, 5)
                                
                                
                                Text("000")
                                    .font(userScreenInfo.inProgressContestGameViewStyleBag.mainFontType)
                                    .padding(.vertical, 5)
                            }.padding(.trailing, userScreenInfo.inProgressContestGameViewStyleBag.paddings.trailingScoresBox) // 20, 10, 15
                            
                            //                        Spacer()
                            
                        }
                        .padding(.leading, 5)
                        .padding(.vertical, 5)
                        
                        Rectangle().frame(width: 1.5, height: nil, alignment: .leading).foregroundColor(Color.gray)
                        
                        
                        HStack(alignment: .top, spacing: 0){
                            VStack(spacing: 0 ){
                                
                                
                                Text("Bets")
                                    .font(userScreenInfo.inProgressContestGameViewStyleBag.secondaryFontType)
                                    
                                    .padding(.vertical, 4)
                                
                                Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color.gray)
                                
                                VStack(alignment: .center, spacing: 10){
                                    
                                    
                                    if let spreadBet = game.spreadBet {
                                        Text("\(spreadBet)")
                                            .font(userScreenInfo.inProgressContestGameViewStyleBag.secondaryFontType)                                }
                                    
                                    if let ouBet = game.overUnderBet {
                                        Text("\(ouBet)")
                                            .font(userScreenInfo.inProgressContestGameViewStyleBag.secondaryFontType)
                                        
                                    }
//                                    Spacer()
                                }
                                .padding(.horizontal, 5)
                                .padding(.vertical, 5)
                            }
                            .frame(minWidth: userScreenInfo.inProgressContestGameViewStyleBag.betsColFrameWidth)
                            .fixedSize()
                            
                        }
                        .padding(.vertical, 1)
                        
                    }
                    .background(Color.gray.opacity(0.08))
                    
                }
                
            }.frame(width: UIScreen.main.bounds.width - 20).fixedSize()
            
            Spacer()
        }
    }
}

struct InProgressContestGameView_Previews: PreviewProvider {
    static var previews: some View {
        
        if let games = MockInProgressContestsRepository().mockData["contest1"]!["inProgressGames"] as? [[String: Any]]{
            
            InProgressContestGameView(game:
                                        InProgressContestGame(game: games[0], playerLookupPrefix: "player1")!
            ).environmentObject(UserScreenInfo(.small))
        }
    }
}


