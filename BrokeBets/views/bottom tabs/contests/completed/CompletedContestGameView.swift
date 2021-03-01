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
    
    init(){
        self.paddings = (10, 20) // 10 20 30 20
        self.mainFontType = .body
        self.secondaryFontType = .caption
        self.betsColFrameWidth = 87
    }
    
    init(mainFontType: Font, secondaryFontType: Font, paddings: (leadingTeamsBox: CGFloat, trailingScoresBox: CGFloat), betsColFrameWidth: CGFloat){
        self.paddings = paddings
        self.mainFontType = mainFontType
        self.secondaryFontType = secondaryFontType
        self.betsColFrameWidth = betsColFrameWidth
    }
}


struct CompletedContestGameView: View {
    
    
    @EnvironmentObject var userScreenInfo: UserScreenInfo
    
    
    var game: CompletedContestGame
    var ouResultColor: Color?
    var spreadResultColor: Color?
    
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
                            Text("MIN Timberwolves")
                                .lineLimit(1)
                                .font(userScreenInfo.completedContestGameViewStyleBag.mainFontType)
                                .padding(.vertical, 5)

                            Text("\(game.awayTeam)")
                                .lineLimit(1)
                                .font(userScreenInfo.completedContestGameViewStyleBag.mainFontType)
                                .padding(.vertical, 5)
                        }
                        .padding(.leading, userScreenInfo.completedContestGameViewStyleBag.paddings.leadingTeamsBox) // 15, 10)
                        
                        Spacer()
                        
                        VStack(alignment: HorizontalAlignment.trailing) {
                            Text("\(game.homeTeamScore)")
                                .font(userScreenInfo.completedContestGameViewStyleBag.mainFontType)
                                .fontWeight(.black)
                                .padding(.vertical, 5)
                                
                            
                            Text("\(game.awayTeamScore)")
                                .font(userScreenInfo.completedContestGameViewStyleBag.mainFontType)
                                .padding(.vertical, 5)
                        }.padding(.trailing, userScreenInfo.completedContestGameViewStyleBag.paddings.trailingScoresBox) // 20, 10, 15

//                        Spacer()
                
                    }
                    .padding(.leading, 5)
                    .padding(.vertical, 5)
                    
                
//                    Spacer()
                                        
                    Rectangle().frame(width: 1.5, height: nil, alignment: .leading).foregroundColor(Color.gray)
                    
                  
                    HStack(alignment: .top, spacing: 0){
                        VStack(spacing: 0){
                            
                         
                            Text("Bets")
                                .font(userScreenInfo.completedContestGameViewStyleBag.secondaryFontType)

                                .padding(.vertical, 4)
                            
                            Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color.gray)
                            
                            VStack(alignment: .center, spacing: 10){
                                
                                
                                if let spreadBet = game.spreadBet {
                                    Text("\(spreadBet)")
                                        .font(userScreenInfo.completedContestGameViewStyleBag.secondaryFontType)                                }
                                
                                if let ouBet = game.overUnderBet {
                                    Text("\(ouBet)")
                                        .font(userScreenInfo.completedContestGameViewStyleBag.secondaryFontType)

                                }
                                

                            }
                            .padding(.horizontal, 5)
                            .padding(.vertical, 5)
                            
                        }
//                        .frame(minWidth: 87)
                        .frame(minWidth: userScreenInfo.completedContestGameViewStyleBag.betsColFrameWidth)
                        
                        .fixedSize()

                        Divider()
                            .background(Color.gray)
                    
                        VStack(spacing: 0){
                            
                         
                            Text("Results")
                                .font(userScreenInfo.completedContestGameViewStyleBag.secondaryFontType)

                                .padding(.vertical, 4)
       
                            Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color.gray)
                            
                            VStack(spacing: 10){
                                
                                
                                if let spreadResult = game.spreadBetResult {
                                    Text("\(spreadResult.rawValue)")
                                        .font(userScreenInfo.completedContestGameViewStyleBag.secondaryFontType)
                                        .foregroundColor(spreadResultColor!)
                                }
                            
                                if let ouResult = game.overUnderBetResult {
                                    Text("\(ouResult.rawValue)")
                                        .font(userScreenInfo.completedContestGameViewStyleBag.secondaryFontType)
                                        .foregroundColor(ouResultColor!)
                                }
                            }
                            .padding(.horizontal, 14)
                            .padding(.vertical, 5)
                            
                        }
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
        
        if let games = MockCompletedContestsRepository().mockData[0]["games"] as? [[String: Any]]{
            CompletedContestGameView(game:
                                        CompletedContestGame(game: games[0], playerLookupPrefix: "player1", todaysSimpleDate: SimpleDate(date: Date()))!
            ).environmentObject(UserScreenInfo(.small))
        }
    }
}

 