//
//  CompletedContestView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/23/21.
//

import SwiftUI


struct CompletedContestViewStyleBag{
    
    let boxScoreColHPaddings: (drafted: CGFloat?, forced: CGFloat?, total: CGFloat?)
    let mainFontType: Font
    
    init(){
        self.boxScoreColHPaddings = (nil, nil, nil)
        self.mainFontType = .body
    }
    
    init(boxScoreColHPaddings: (drafted: CGFloat?, forced: CGFloat?, total: CGFloat?), mainFontType: Font){
        self.boxScoreColHPaddings = boxScoreColHPaddings
        self.mainFontType = mainFontType
    }
}



struct CompletedContestView: View {
    
    @EnvironmentObject var userScreenInfo: UserScreenInfo
    
    private var completedContest: CompletedContest
    private var accentColor: Color
    private var userTotalBoldStyle: Font.Weight
    private var oppTotalBoldStyle: Font.Weight
  
    init(completedContest: CompletedContest){
        self.completedContest = completedContest

        switch(completedContest.result){
            case .Won:
                self.accentColor = .green
                self.userTotalBoldStyle = .black
                self.oppTotalBoldStyle = .regular
                break
            case .Lost:
                self.accentColor = .red
                self.userTotalBoldStyle = .regular
                self.oppTotalBoldStyle = .black
                break
        default:
                self.accentColor = Color.black.opacity(0.65)
                self.userTotalBoldStyle = .regular
                self.oppTotalBoldStyle = .regular
        }
    }
    
    var body: some View {
        
        NavigationLink(destination: CompletedContestGamesListView(contest: completedContest)
                        .navigationBarTitle("Contest Betslip", displayMode: .inline))
        {
            
            VStack(alignment: .leading, spacing: 0){
                
                HStack(alignment: .bottom, spacing: 0) {
                    
                    VStack(alignment: .leading, spacing: 0){
                        
                        HStack{
                            Text("Result:")
                                .font(.caption)
                                .foregroundColor(Color.black)
                                .fontWeight(.semibold)
                                .padding(.bottom, 2)
                                .padding(.leading, 5)
                            
                            Text(completedContest.result.rawValue)
                                .font(.caption)
                                .foregroundColor(accentColor)
                                .fontWeight(.bold)
                                .padding(.bottom, 2)
                        }
                        
                        
                        Rectangle().frame(width: nil, height: 1.5, alignment: .bottom).foregroundColor(Color.gray)
                        
                        Text("You")
                            .font(userScreenInfo.completedContestViewStyleBag.mainFontType)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.vertical, 6)
                            .padding(.leading, 5)
                        
                        Text("\(completedContest.opponent)")
                            .font(userScreenInfo.completedContestViewStyleBag.mainFontType)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .lineLimit(1)
                            .padding(.vertical, 6)
                            .padding(.leading, 5)
                    }
                    
                
                    
                    VStack(spacing: 0){
                        Text("Drafted")
                           
                            .foregroundColor(.black)
                            .font(.caption)
                            .padding(.bottom, 2)
                            .padding(.horizontal, userScreenInfo.completedContestViewStyleBag.boxScoreColHPaddings.drafted)
                        
                        Rectangle().frame(width: nil, height: 1.5, alignment: .bottom).foregroundColor(Color.gray)
                        
                        Text("\(completedContest.userDraftedWins)")
                            .font(userScreenInfo.completedContestViewStyleBag.mainFontType)
                            .foregroundColor(.black)
                            .padding(.vertical, 6)

                        Text("\(completedContest.opponentDraftedWins)")
                            .font(userScreenInfo.completedContestViewStyleBag.mainFontType)
                            .foregroundColor(.black)
                            .padding(.vertical, 6)

                    }.fixedSize()
                    
                    
                    VStack(spacing: 0){
                        Text("Forced")
                            .foregroundColor(.black)
                            .font(.caption)
                            .padding(.bottom, 2)
                            .padding(.horizontal, userScreenInfo.completedContestViewStyleBag.boxScoreColHPaddings.forced)
                            
                    
                        Rectangle().frame(width: nil, height: 1.5, alignment: .bottom).foregroundColor(Color.gray)
                            
                    
                        
                        Text("\(completedContest.userForcedWins)")
                            .font(userScreenInfo.completedContestViewStyleBag.mainFontType)
                            .foregroundColor(.black)
                            .padding(.vertical, 6)

                        Text("\(completedContest.opponentForcedWins)")
                            .font(userScreenInfo.completedContestViewStyleBag.mainFontType)
                            .foregroundColor(.black)
                            .padding(.vertical, 6)

                    }
                    .fixedSize()
                    
                    
                    
                    VStack(spacing: 0){
                        Text("Total")
                            .font(.caption)
                            .foregroundColor(.black)
                            .padding(.bottom, 2)
                            .padding(.horizontal, userScreenInfo.completedContestViewStyleBag.boxScoreColHPaddings.total)

                        Rectangle().frame(width: nil, height: 1.5, alignment: .bottom).foregroundColor(Color.gray)
                        
                        Text("\(completedContest.userTotalWins)")
                            .font(userScreenInfo.completedContestViewStyleBag.mainFontType)
                            .foregroundColor(.black)
                            .fontWeight(completedContest.result == .Won ? .black : .regular)
                            .padding(.vertical, 6)

                        Text("\(completedContest.opponentTotalWins)")
                            .font(userScreenInfo.completedContestViewStyleBag.mainFontType)
                            .foregroundColor(.black)
                            .fontWeight(completedContest.result == .Won ? .regular: .black)
                            .padding(.vertical, 6)

                    }.fixedSize()
                }
                
                HStack {
                    HStack{
                        Text("Total Bets:")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .padding(.top, 5)
                            .padding(.leading, 10)
                        
                        Text("\(completedContest.numBets)")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .padding(.top, 5)
                            
                    }
                    
                    Spacer()
                    
                    HStack{
                        HStack(spacing: 6){
                            Text("Completed:")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 0, green: 38/255, blue: 77/255))
                                .padding(.top, 5)
                            
                            Text("\(completedContest.contestCompletionDateStr)")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 0, green: 38/255, blue: 77/255))
                                .padding(.top, 5)
                                .padding(.trailing, 10)
                        }
                    }
                }
            }
        }
        .padding(.vertical, 8)
        .padding(.leading, 10)
        
//        .frame(width: .infinity)
        .overlay(CustomRoundedRect(tabColor: accentColor))
        .padding(.horizontal, 6)
    }
    
    
}

//struct CompletedContestView_Previews: PreviewProvider {
//    static var previews: some View {
//        CompletedContestView(completedContest: CompletedContest(opponent: "CodyShowstoppa", numBets: 4, result: .Won, userScores: (total: 3, drafted: 2, forced: 1), oppScores: (total: 1, drafted: 1, forced: 0), completionDT: Date(), games: [
//
//            CompletedContestGame(homeTeam: "HOU Rockets", awayTeam: "ORL Magic", htScore: 107, atScore: 117, completedDT: Date(), specialDayType: .Today, ouBet: "OVER 215.5", ouBetRes: .Won, spreadBet: "ORL -7", spreadBetRes: .Won, gameWinner: .AWAY)
//        ]
//
//
//        )).environmentObject(UserScreenInfo(.regular))
//    }
//}


struct CompletedContestView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedContestView(completedContest: CompletedContest(data: MockCompletedContestsRepository().mockData[0], playerUid: "testToddUid")!
        )
        .environmentObject(UserScreenInfo(.regular))
    }
}
