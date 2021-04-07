//
//  CompletedContestGameView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/28/21.
//

import SwiftUI

struct CompletedContestGameViewStyleBag{
    
    let paddings: (leadingTeamsBox: CGFloat, trailingScoresBox: CGFloat)
    let mainFontType: Font
    let secondaryFontType: Font
    let betsColFrameWidth: CGFloat
    let resultsColFrameWidth: CGFloat
    
    init(){
        self.paddings = (10, 20) // 10 20 30 20
        self.mainFontType = .body
        self.secondaryFontType = .caption
        self.betsColFrameWidth = 75 // was 87
        self.resultsColFrameWidth = 65
    }
    
    init(mainFontType: Font, secondaryFontType: Font, paddings: (leadingTeamsBox: CGFloat, trailingScoresBox: CGFloat), betsColFrameWidth: CGFloat, resultsColFrameWidth: CGFloat){
        self.paddings = paddings
        self.mainFontType = mainFontType
        self.secondaryFontType = secondaryFontType
        self.betsColFrameWidth = betsColFrameWidth
        self.resultsColFrameWidth = resultsColFrameWidth
    }
}


struct CompletedContestGameView: View {
    
    
    @EnvironmentObject var userScreenInfo: UserScreenInfo
    
    
    var game: CompletedContestGame
    var ouResultColor: Color?
    var spreadResultColor: Color?
    var homeTotalBoldStyle: Font.Weight
    var awayTotalBoldStyle: Font.Weight
    
    init(game: CompletedContestGame){
        
        self.game = game
        
        if let ouResult = game.overUnderBetResult {
            switch(ouResult){
                case .Lost: self.ouResultColor = .red
                case .Won: self.ouResultColor = .green
                case .Push: self.ouResultColor = Color.black.opacity(0.65)
            }
        }
        
        if let spreadResult = game.spreadBetResult {
            switch(spreadResult){
                case .Lost: self.spreadResultColor = .red
                case .Won: self.spreadResultColor = .green
                case .Push: self.spreadResultColor = Color.black.opacity(0.65)
            }
        }
        
        switch(game.gameWinner){
            case .HOME:
                self.homeTotalBoldStyle = .black
                self.awayTotalBoldStyle = .regular
                break
            case .AWAY:
                self.homeTotalBoldStyle = .regular
                self.awayTotalBoldStyle = .black
                break
            case .TIE:
                self.homeTotalBoldStyle = .regular
                self.awayTotalBoldStyle = .regular
        }
    }
    
    
    
    
    var body: some View {
        
        VStack{
        ZStack{
            RoundedRectangle(cornerRadius: 5)
            .stroke(Color.black.opacity(0.65), lineWidth: 1.2)
            
            VStack(spacing: 0) {
            
                        HStack{
                            Text("Completed: \(game.gameCompletionDateTimeStr)")
                                .font(.caption)
                                .foregroundColor(Color(red: 0, green: 38/255, blue: 77/255))
                                .fontWeight(.semibold)
                                .padding(.leading)
                                .padding(.bottom, 5)
                            Spacer()
                        }.padding(.top, 5)
                        
                            
                Rectangle().frame(width: nil, height: 1.5, alignment: .bottom).foregroundColor(Color.gray)

                HStack(spacing: 0){
                    HStack{
                        VStack(alignment: .leading) {
                            
                            
                            Text("\(game.awayTeam)")
                                .lineLimit(1)
                                .font(UserScreenInfoV2.current.completedContestGameViewStyleBag.mainFontType)
                                .padding(.vertical, 5)
                            
                            
                            Text("\(game.homeTeam)")
                                .lineLimit(1)
                                .font(UserScreenInfoV2.current.completedContestGameViewStyleBag.mainFontType)
                                
                                .padding(.vertical, 5)

                        }
                        .padding(.leading, UserScreenInfoV2.current.completedContestGameViewStyleBag.paddings.leadingTeamsBox) // 15, 10)
                        
                        Spacer()
                        
                        VStack(alignment: HorizontalAlignment.trailing) {
                            
                            Text("\(game.awayTeamScore)")
                                .font(UserScreenInfoV2.current.completedContestGameViewStyleBag.mainFontType)
                                .fontWeight(awayTotalBoldStyle)
                                .padding(.vertical, 5)
                            
                            Text("\(game.homeTeamScore)")
                                .font(UserScreenInfoV2.current.completedContestGameViewStyleBag.mainFontType)
                                .fontWeight(homeTotalBoldStyle)
                                .padding(.vertical, 5)
                            
                        }.padding(.trailing, UserScreenInfoV2.current.completedContestGameViewStyleBag.paddings.trailingScoresBox) // 20, 10, 15

//                        Spacer()
                
                    }
                    .padding(.leading, 5)
                    .padding(.vertical, 5)
                    
                
//                    Spacer()
                                        
                    Rectangle().frame(width: 1.5, height: nil, alignment: .leading).foregroundColor(Color.gray)
                    
                  
                    HStack(alignment: .top, spacing: 0){
                        VStack(spacing: 0){
                            
                         
                            Text("Bets")
                                .font(UserScreenInfoV2.current.completedContestGameViewStyleBag.secondaryFontType)

                                .padding(.vertical, 4)
                            
                            Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color.gray)
                            
                            VStack(alignment: .center, spacing: 10){
                                
                                
                                if let spreadBet = game.spreadBet {
                                    Text("\(spreadBet)")
                                        .font(UserScreenInfoV2.current.completedContestGameViewStyleBag.secondaryFontType)                                }
                                
                                if let ouBet = game.overUnderBet {
                                    Text("\(ouBet)")
                                        .font(UserScreenInfoV2.current.completedContestGameViewStyleBag.secondaryFontType)

                                }
                            }
                            .padding(.horizontal, 5)
                            .padding(.vertical, 5)
                            
                        }
                        .frame(minWidth: UserScreenInfoV2.current.completedContestGameViewStyleBag.betsColFrameWidth)
                        .fixedSize()

                        Divider()
                            .background(Color.gray)
                    
                        VStack(spacing: 0){
                            
                            Text("Results")
                                .font(UserScreenInfoV2.current.completedContestGameViewStyleBag.secondaryFontType)

                                .padding(.vertical, 4)
       
                            Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color.gray)
                            
                            VStack(spacing: 10){
                                
                                
                                if let spreadResult = game.spreadBetResult {
                                    Text("\(spreadResult.rawValue)")
                                        .font(UserScreenInfoV2.current.completedContestGameViewStyleBag.secondaryFontType)
                                        .foregroundColor(spreadResultColor!)
                                }
                            
                                if let ouResult = game.overUnderBetResult {
                                    Text("\(ouResult.rawValue)")
                                        .font(UserScreenInfoV2.current.completedContestGameViewStyleBag.secondaryFontType)
                                        .foregroundColor(ouResultColor!)
                                }
                            }
                            .padding(.horizontal, 14)
                            .padding(.vertical, 5)
                            
                        }
                        .frame(minWidth: UserScreenInfoV2.current.completedContestGameViewStyleBag.resultsColFrameWidth)
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

struct CompletedContestGameView_Previews: PreviewProvider {
    static var previews: some View {
        
        if let games = MockCompletedContestsRepository(uid: "testToddUid").mockData[0]["completed_games"] as? [[String: Any]]{
            CompletedContestGameView(game:
                                        CompletedContestGame(game: games[1], playerLookupPrefix: "player1", todaysSimpleDate: SimpleDate(date: Date()))!
            )
            .environmentObject(UserScreenInfo(.regular))
//            .environmentObject(UserScreenInfo(.xsmall))
        }
    }
}

 
