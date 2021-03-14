//
//  InProgressContestView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/4/21.
//

import SwiftUI

struct InProgressContestViewStyleBag{
    
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


struct InProgressContestView: View {
    
    @EnvironmentObject var userScreenInfo: UserScreenInfo
//    @EnvironmentObject var appState: T
    
    private var inProgressContest: InProgressContest
    private var accentColor: Color = .blue
    private var inProgressContestsRepo: InProgressContestsRepositoryProtocol
  
    init(inProgressContest: InProgressContest, inProgressContestsRepo: InProgressContestsRepositoryProtocol){
        self.inProgressContest = inProgressContest
        self.inProgressContestsRepo = inProgressContestsRepo
    }
    
    var body: some View {
        
        NavigationLink(destination:
                        InProgressContestGamesListView(inProgressContestGamesListVM: InProgressContestGamesListVM(contestId: inProgressContest.contestId, inProgressContestRepo: inProgressContestsRepo))
                        
                        .navigationBarTitle("Contest Betslip", displayMode: .inline))
        {
            
            VStack(alignment: .leading, spacing: 0){
                
                HStack(alignment: .bottom, spacing: 0) {
                    
                    VStack(alignment: .leading, spacing: 0){
                                  
                        Rectangle().frame(width: nil, height: 1.5, alignment: .bottom).foregroundColor(Color.gray)
                        
                        Text("You")
                            .font(userScreenInfo.inProgressContestViewStyleBag.mainFontType)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.vertical, 6)
                            .padding(.leading, 5)
                        
                        Text("\(inProgressContest.opponent)")
                            .font(userScreenInfo.inProgressContestViewStyleBag.mainFontType)
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
                            .padding(.horizontal, userScreenInfo.inProgressContestViewStyleBag.boxScoreColHPaddings.drafted)
                        
                        Rectangle().frame(width: nil, height: 1.5, alignment: .bottom).foregroundColor(Color.gray)
                        
                        Text("\(inProgressContest.userDraftedWins)")
                            .font(userScreenInfo.inProgressContestViewStyleBag.mainFontType)
                            .foregroundColor(.black)
                            .padding(.vertical, 6)

                        Text("\(inProgressContest.opponentDraftedWins)")
                            .font(userScreenInfo.inProgressContestViewStyleBag.mainFontType)
                            .foregroundColor(.black)
                            .padding(.vertical, 6)

                    }.fixedSize()
                    
                    
                    VStack(spacing: 0){
                        Text("Forced")
                            .foregroundColor(.black)
                            .font(.caption)
                            .padding(.bottom, 2)
                            .padding(.horizontal, userScreenInfo.inProgressContestViewStyleBag.boxScoreColHPaddings.forced)
                            
                    
                        Rectangle().frame(width: nil, height: 1.5, alignment: .bottom).foregroundColor(Color.gray)
                            
                    
                        
                        Text("\(inProgressContest.userForcedWins)")
                            .font(userScreenInfo.inProgressContestViewStyleBag.mainFontType)
                            .foregroundColor(.black)
                            .padding(.vertical, 6)

                        Text("\(inProgressContest.opponentForcedWins)")
                            .font(userScreenInfo.inProgressContestViewStyleBag.mainFontType)
                            .foregroundColor(.black)
                            .padding(.vertical, 6)

                    }
                    .fixedSize()
                    
                    
                    
                    VStack(spacing: 0){
                        Text("Total")
                            .font(.caption)
                            .foregroundColor(.black)
                            .padding(.bottom, 2)
                            .padding(.horizontal, userScreenInfo.inProgressContestViewStyleBag.boxScoreColHPaddings.total)

                        Rectangle().frame(width: nil, height: 1.5, alignment: .bottom).foregroundColor(Color.gray)
                        
                        Text("\(inProgressContest.userTotalWins)")
                            .font(userScreenInfo.inProgressContestViewStyleBag.mainFontType)
                            .foregroundColor(.black)
                            .padding(.vertical, 6)

                        Text("\(inProgressContest.opponentTotalWins)")
                            .font(userScreenInfo.inProgressContestViewStyleBag.mainFontType)
                            .foregroundColor(.black)
                            .padding(.vertical, 6)

                    }.fixedSize()
                }
                
                HStack {
                    HStack{
                        Text("Bets Completed:")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .padding(.top, 5)
                            .padding(.leading, 10)
                        
                        Text("\(inProgressContest.numBetsCompleted)")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .padding(.top, 5)
                            
                    }
                    
                    Spacer()
                    
                    HStack{
                        HStack(spacing: 6){
                            Text("Bets Remaining:")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                                .padding(.top, 5)
                            
                            Text("\(inProgressContest.numBetsRemaining)")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                                .padding(.top, 5)
                                .padding(.trailing, 10)
                        }
                    }
                }
            }
        }
        .padding(.vertical, 8)
        .padding(.leading, 10)
        .overlay(CustomRoundedRect(tabColor: accentColor))
        .padding(.horizontal, 6)
    }
}


//struct InProgressContestView_Previews: PreviewProvider {
//    static var previews: some View {
//        InProgressContestView(inProgressContest: InProgressContest(data: MockInProgressContestsRepository().mockData[0], playerUid: "testToddUid")!
//        )
//        .environmentObject(UserScreenInfo(.regular))
//    }
//}

struct InProgressContestView_Previews: PreviewProvider {
    static var previews: some View {
        InProgressContestView(inProgressContest: InProgressContest(data: MockInProgressContestsRepository(uid: "testToddUid").mockData["contest1"]!, playerUid: "testToddUid", contestId: "contest1")!, inProgressContestsRepo: MockInProgressContestsRepository(uid: "testToddUid")
        )
        .environmentObject(UserScreenInfo(.small))
        .environmentObject(MockAppState())
    }
}

