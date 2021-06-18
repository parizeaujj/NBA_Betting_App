//
//  UpccomingContestGameView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/17/21.
//

import SwiftUI

struct UpcomingContestGameViewStyleBag {
    
    let leadingTeamsBoxPadding: CGFloat
    let mainFontType: Font
    let secondaryFontType: Font
    let betsColFrameWidth: CGFloat
    
    init(){
        self.leadingTeamsBoxPadding = 10
        self.mainFontType = .body
        self.secondaryFontType = .caption
        self.betsColFrameWidth = 107 // 87
    }
    
    init(mainFontType: Font, secondaryFontType: Font, leadingTeamsBoxPadding: CGFloat, betsColFrameWidth: CGFloat){
        self.mainFontType = mainFontType
        self.secondaryFontType = secondaryFontType
        self.leadingTeamsBoxPadding = leadingTeamsBoxPadding
        self.betsColFrameWidth = betsColFrameWidth
    }
}


struct UpcomingContestGameView: View {
    
//    @EnvironmentObject var userScreenInfo: UserScreenInfo
    
    var game: UpcomingContestGame
    
    init(game: UpcomingContestGame){
        self.game = game
    }
    
    var body: some View {
        
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.black.opacity(0.65), lineWidth: 1.2)
                
                VStack(spacing: 0) {
                    
                    HStack{
                        Text("\(game.gameStartDateTimeStr)")
                            .font(.caption)
                            .foregroundColor(Color(red: 0, green: 38/255, blue: 77/255))
                            .fontWeight(.semibold)
                            .padding(.leading)
                            .padding(.bottom, 5)
                        Spacer()
                    }.padding(.top, 5)
                    
                    
                    Rectangle().frame(width: nil, height: 1.5, alignment: .bottom).foregroundColor(Color.gray)
                    
                    HStack(alignment: .top, spacing: 0){
                        HStack{
                            VStack(alignment: .leading) {
                                
                                Text("\(game.awayTeam)")
                                    .lineLimit(1)
                                    .font(UserScreenInfoV2.current.upcomingContestGameViewStyleBag.mainFontType)
                                    .padding(.vertical, 5)
                                
                                Text("\(game.homeTeam)")
                                    .lineLimit(1)
                                    .font(UserScreenInfoV2.current.upcomingContestGameViewStyleBag.mainFontType)
                                    .padding(.vertical, 5)
                                
                            }
                            .padding(.leading, UserScreenInfoV2.current.upcomingContestGameViewStyleBag.leadingTeamsBoxPadding) // 15, 10)
                            
                            Spacer()
                            
                            
                        }
                        .padding(.leading, 5)
                        .padding(.vertical, 5)
                        
                        Rectangle().frame(width: 1.5, height: nil, alignment: .leading).foregroundColor(Color.gray)
                        
                        
                        HStack(alignment: .top, spacing: 0){
                            VStack(spacing: 0 ){
                                
                                
                                Text("Bets")
                                    .font(UserScreenInfoV2.current.upcomingContestGameViewStyleBag.secondaryFontType)
                                    
                                    .padding(.vertical, 4)
                                
                                Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color.gray)
                                
                                VStack(alignment: .center, spacing: 10){
                                    
                                    
                                    if let spreadBet = game.spreadBet {
                                        Text("\(spreadBet)")
                                            .font(UserScreenInfoV2.current.upcomingContestGameViewStyleBag.secondaryFontType)                                }
                                    
                                    if let ouBet = game.overUnderBet {
                                        Text("\(ouBet)")
                                            .font(UserScreenInfoV2.current.upcomingContestGameViewStyleBag.secondaryFontType)
                                        
                                    }
                                }
                                .padding(.horizontal, 5)
                                .padding(.vertical, 5)
                            }
                            .frame(minWidth: UserScreenInfoV2.current.upcomingContestGameViewStyleBag.betsColFrameWidth)
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


struct UpcomingContestGameView_Previews: PreviewProvider {
    static var previews: some View {
        
        if let games = MockUpcomingContestsRepository(uid: "testToddUid").mockData[0]["games"] as? [[String: Any]]{
            UpcomingContestGameView(game:
                                        UpcomingContestGame(game: games[0], playerLookupPrefix: "player1", todaysSimpleDate: SimpleDate(date: Date()))!
            )
//            .environmentObject(UserScreenInfo(.regular))
        }
    }
}




