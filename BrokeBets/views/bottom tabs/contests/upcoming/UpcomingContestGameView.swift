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
    
    @EnvironmentObject var userScreenInfo: UserScreenInfo
    
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
                                Text("\(game.homeTeam)")
                                    .lineLimit(1)
                                    .font(userScreenInfo.upcomingContestGameViewStyleBag.mainFontType)
                                    .padding(.vertical, 5)
                                
                                Text("\(game.awayTeam)")
                                    .lineLimit(1)
                                    .font(userScreenInfo.upcomingContestGameViewStyleBag.mainFontType)
                                    .padding(.vertical, 5)
                            }
                            .padding(.leading, userScreenInfo.upcomingContestGameViewStyleBag.leadingTeamsBoxPadding) // 15, 10)
                            
                            Spacer()
                            
//                            VStack(alignment: HorizontalAlignment.trailing) {
//                                Text("0")
//                                    .font(userScreenInfo.upcomingContestGameViewStyleBag.mainFontType)
//                                    .padding(.vertical, 5)
//
//
//                                Text("000")
//                                    .font(userScreenInfo.upcomingContestGameViewStyleBag.mainFontType)
//                                    .padding(.vertical, 5)
//                            }.padding(.trailing, userScreenInfo.upcomingContestGameViewStyleBag.paddings.trailingScoresBox) // 20, 10, 15
//
                            //                        Spacer()
                            
                        }
                        .padding(.leading, 5)
                        .padding(.vertical, 5)
                        
                        Rectangle().frame(width: 1.5, height: nil, alignment: .leading).foregroundColor(Color.gray)
                        
                        
                        HStack(alignment: .top, spacing: 0){
                            VStack(spacing: 0 ){
                                
                                
                                Text("Bets")
                                    .font(userScreenInfo.upcomingContestGameViewStyleBag.secondaryFontType)
                                    
                                    .padding(.vertical, 4)
                                
                                Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color.gray)
                                
                                VStack(alignment: .center, spacing: 10){
                                    
                                    
                                    if let spreadBet = game.spreadBet {
                                        Text("\(spreadBet)")
                                            .font(userScreenInfo.upcomingContestGameViewStyleBag.secondaryFontType)                                }
                                    
                                    if let ouBet = game.overUnderBet {
                                        Text("\(ouBet)")
                                            .font(userScreenInfo.upcomingContestGameViewStyleBag.secondaryFontType)
                                        
                                    }
                                }
                                .padding(.horizontal, 5)
                                .padding(.vertical, 5)
                            }
                            .frame(minWidth: userScreenInfo.upcomingContestGameViewStyleBag.betsColFrameWidth)
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




/*
struct UpcomingContestGameView: View {
    
    var game: UpcomingContestGame
    
    var body: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 5)
            .stroke(Color.black.opacity(0.65), lineWidth: 1.2)
            
            VStack(spacing: 0) {
            
                        HStack{
                            Text(game.gameStartDateTimeStr)
                                .font(.subheadline)
                                .foregroundColor(Color(red: 0, green: 38/255, blue: 77/255))
                                .fontWeight(.semibold)
                                .padding(.leading)
                                .padding(.bottom, 5)
                            Spacer()
                            
                        }.padding(.top, 5)
                        
                Rectangle().frame(width: nil, height: 1.5, alignment: .bottom).foregroundColor(Color.gray)

                HStack(spacing: 0){
                    HStack(){
                        VStack(alignment: .leading) {
                            Text(game.homeTeam)
                                .padding(.vertical, 5)
                            Text(game.awayTeam)
                                .padding(.vertical, 5)
                        }
                        .padding(.leading, 15)
                        
                        Spacer()
                    }
                    .padding(.leading, 5)
                    .padding(.top, 5)
                    
                
                    Spacer()
                    
                    Rectangle().frame(width: 1.5, height: nil, alignment: .leading).foregroundColor(Color.gray)
                    
                    HStack(spacing: 0){
                        VStack(spacing: 0){
                            
                         
                            Text("Bets")
                                .font(.subheadline)
                            
                                .padding(.horizontal, 45)
                                .padding(.vertical, 4)
                                .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color.gray), alignment: .bottom)
                                    
                            Spacer()
                            VStack(spacing: 8){
                                
                                if let spreadBet = game.spreadBet {
                                    Text(spreadBet)
                                        .font(.subheadline)
                                }
        
                                if let overUnderBet = game.overUnderBet {
                                    Text(overUnderBet)
                                        .font(.subheadline)
                                }
        
                            }.padding(.vertical, 5)
                            
                            Spacer()

                        }
                        .fixedSize(horizontal: true, vertical: false)
                    }
                    .padding(1)
                    
                }
                .background(Color.gray.opacity(0.08))
            }
        }
        .frame(height: 120)
    }
    
}


*/


//struct UpcomingContestGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        UpcomingContestGameView(game:
//                                    UpcomingContestGame(homeTeam: "HOU Rockets", awayTeam: "MIA Heat", gameStartDateTime: Date(), specialDayType: .Today, overUnderBet: "OVER 225.5", spreadBet: "MIA -7"))
//    }
//}




struct UpcomingContestGameView_Previews: PreviewProvider {
    static var previews: some View {
        
        if let games = MockUpcomingContestsRepository(uid: "testToddUid").mockData[0]["games"] as? [[String: Any]]{
            UpcomingContestGameView(game:
                                        UpcomingContestGame(game: games[0], playerLookupPrefix: "player1", todaysSimpleDate: SimpleDate(date: Date()))!
            ).environmentObject(UserScreenInfo(.regular))
        }
    }
}




