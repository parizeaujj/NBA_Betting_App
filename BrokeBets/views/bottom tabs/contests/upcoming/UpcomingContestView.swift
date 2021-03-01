//
//  UpcomingContestView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/17/21.
//

import SwiftUI
import FirebaseFirestore

struct UpcomingContestView: View {
    
    @EnvironmentObject var userScreenInfo : UserScreenInfo
    
    var upcomingContest: UpcomingContest
    
    init(upcomingContest: UpcomingContest){
        self.upcomingContest = upcomingContest
    }
    
    var body: some View {
        
        
        NavigationLink(destination: UpcomingContestGamesListView(contest: upcomingContest)
                        .navigationBarTitle("Contest Betslip", displayMode: .inline))
        {
            HStack {
                VStack {
                    HStack {
                        
                        
                        // if the screen size is small, then make text smaller so that it does not need to wrap to new line
                        if userScreenInfo.screenSizeType == .small {
                            
                            Text("Opponent:")
                                .font(.subheadline)

                            Text("\(upcomingContest.opponent)")
                                .font(.subheadline)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                .lineLimit(1)
                        }
                        else{
                            
                            Text("Opponent:")
                               
                            Text("\(upcomingContest.opponent)")
                               
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        }
                        
                        Spacer()
                        
                        Text("Total bets:")
                            .font(.subheadline)
                        
                        Text("\(upcomingContest.numBets)")
                            .font(.subheadline)
                            
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(.trailing, 8)
                        
                    }
                    .padding(.bottom, 15)
                    
                    
                    HStack {
                        Text("First game start: ")
                            .font(.subheadline)
                      
                        Text("\(upcomingContest.firstGameStartDateTimeStr)")
                            .fontWeight(.bold)
                            .font(.subheadline)
                        Spacer()
                    }
                }
                
                
                Image(systemName: "chevron.right")
                    .font(.system(.footnote))
                
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.black.opacity(0.65), lineWidth: 1.2)
            )
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            
        }
    }
}



//struct UpcomingContestView_Previews: PreviewProvider {
//
//
//    static var previews: some View {
//        UpcomingContestView(upcomingContest: UpcomingContest(opponent: "Cody_ShowStoppa", firstGameStartDateTime: Date(), numBets: 3, games: [
//
//            UpcomingContestGame(homeTeam: "IND Pacers", awayTeam: "ORL Magic", gameStartDateTime: Date(), specialDayType: .Today, overUnderBet: "UNDER 225", spreadBet: "IND +2.5"),
//            UpcomingContestGame(homeTeam: "NO Pelicans", awayTeam: "LA Lakers", gameStartDateTime: Date(), specialDayType: .Today, overUnderBet: "UNDER 215.5", spreadBet: "LA -3")
//
//        ]
//        )
//        )
//        .environmentObject(UserScreenInfo(.regular))
//
//    }
//}

struct UpcomingContestView_Previews: PreviewProvider {


    static var previews: some View {
        UpcomingContestView(upcomingContest: UpcomingContest(data:  MockUpcomingContestsRepository().mockData[0], playerUid: "testToddUid")!
        )
        .environmentObject(UserScreenInfo(.regular))

    }
}

