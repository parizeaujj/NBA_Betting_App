//
//  File.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/20/21.
//

import Foundation
import FirebaseFirestore


protocol UpcomingContestsRepositoryProtocol {

    var upcomingContests: [UpcomingContest] { get }
    var upcomingContestsPublisher: Published<[UpcomingContest]>.Publisher { get }
    var upcomingContestsPublished: Published<[UpcomingContest]> { get }
    
    
    func getUpcomingContests() -> Void
    
}


// MOCK
class MockUpcomingContestsRepository: UpcomingContestsRepositoryProtocol, ObservableObject {
    
    @Published var upcomingContests: [UpcomingContest] = []
    var upcomingContestsPublished: Published<[UpcomingContest]> { _upcomingContests }
    var upcomingContestsPublisher: Published<[UpcomingContest]>.Publisher { $upcomingContests }
    
    let mockData: [[String: Any]] = [
        ["firstGameStartDateTime": Timestamp(date: Date()),
         "player1_uid": "testToddUid",
         "player1_uname": "todd123",
         "player2_uid": "testOppUid",
         "player2_uname": "testOpp",
         "numBets": 3,
         "games": [
            
                    // game 1
                    ["awayTeam": "HOU Rockets",
                     "homeTeam": "MIA Heat",
                     "gameStartDateTime": Timestamp(date: Date()),
                     "overUnderBet": [
                            "player1": "OVER 225.5",
                            "player2": "UNDER 225.5"
                     ],
                     "spreadBet": [
                            "player1": "MIA -7",
                            "player2": "HOU +7"
                    ]
                   ],
                    
                    // game 2
                    ["awayTeam": "GS Warriors",
                     "homeTeam": "NY Knicks",
                     "gameStartDateTime": Timestamp(date: Date()),
                     "spreadBet": [
                            "player1": "GS -3.5",
                            "player2": "NY +3.5"
                     ]
                    ]
            
                ]
        ]
    ]

    
    
    init() {
        getUpcomingContests()
    }
   
    
    func getUpcomingContests(){
        
        
        self.upcomingContests = self.mockData.map { contest -> UpcomingContest in
            
            UpcomingContest(data: contest, playerUid: "testToddUid")!
            
        }
        
        /*
        self.upcomingContests = [
            
            UpcomingContest(id: "fake123", opponent: "CodyShowstoppa", firstGameStartDateTime: "Today at 4pm", numBets: 10,
                            
                            games: [
                                UpcomingContestGame(homeTeam: "HOU Rockets", awayTeam: "CLE Cavaliers", gameStartDateTime: dateFormatter.date(from: "2/20/2021 4:00 PM")!, specialDayType: .Today, overUnderBet: "OVER 225", spreadBet: "HOU -7"),
                                UpcomingContestGame(homeTeam: "MIA Heat", awayTeam: "GS Warriors", gameStartDateTime: dateFormatter.date(from: "2/20/2021 7:30 PM")!, specialDayType: .Today, overUnderBet: "OVER 205.5"),
                                UpcomingContestGame(homeTeam: "LA Lakers", awayTeam: "CHI Bulls", gameStartDateTime: dateFormatter.date(from: "2/20/2021 4:00 PM")!, specialDayType: .Today, spreadBet: "CHI +7"),
                                UpcomingContestGame(homeTeam: "POR Trail Blazers", awayTeam: "PHX Suns", gameStartDateTime: dateFormatter.date(from: "2/21/2021 11:30 AM")!, specialDayType: .Tomorrow, overUnderBet: "OVER 215.5", spreadBet: "POR -3.5"),
                                UpcomingContestGame(homeTeam: "MEM Grizzlies", awayTeam: "LA Clippers", gameStartDateTime: dateFormatter.date(from: "2/22/2021 2:15 PM")!, specialDayType: .None, spreadBet: "LA +2.5")
                            
                            ]
                            
                            ),
            UpcomingContest(id: "test123", opponent: "Gerald456", firstGameStartDateTime: "Today at 4pm", numBets: 10,
                            games: [
                                UpcomingContestGame(homeTeam: "HOU Rockets", awayTeam: "CLE Cavaliers", gameStartDateTime: dateFormatter.date(from: "2/20/2021 4:00 PM")!, specialDayType: .Today, overUnderBet: "OVER 225", spreadBet: "HOU -7"),
                                UpcomingContestGame(homeTeam: "MIA Heat", awayTeam: "GS Warriors", gameStartDateTime: dateFormatter.date(from: "2/20/2021 7:30 PM")!, specialDayType: .Today, overUnderBet: "OVER 205.5"),
                                UpcomingContestGame(homeTeam: "LA Lakers", awayTeam: "CHI Bulls", gameStartDateTime: dateFormatter.date(from: "2/20/2021 4:00 PM")!, specialDayType: .Today, spreadBet: "CHI +7"),
                                UpcomingContestGame(homeTeam: "POR Trail Blazers", awayTeam: "PHX Suns", gameStartDateTime: dateFormatter.date(from: "2/21/2021 11:30 AM")!, specialDayType: .Tomorrow, overUnderBet: "OVER 215.5", spreadBet: "POR -3.5"),
                                UpcomingContestGame(homeTeam: "MEM Grizzlies", awayTeam: "LA Clippers", gameStartDateTime: dateFormatter.date(from: "2/22/2021 2:15 PM")!, specialDayType: .None, spreadBet: "LA +2.5")
                            
                            ]),
            
            UpcomingContest(id: "dkfkdjkj", opponent: "Sam7890", firstGameStartDateTime: "Today at 5pm", numBets: 10,
                            games: [
                                UpcomingContestGame(homeTeam: "HOU Rockets", awayTeam: "CLE Cavaliers", gameStartDateTime: dateFormatter.date(from: "2/20/2021 4:00 PM")!, specialDayType: .Today, overUnderBet: "OVER 225", spreadBet: "HOU -7"),
                                UpcomingContestGame(homeTeam: "MIA Heat", awayTeam: "GS Warriors", gameStartDateTime: dateFormatter.date(from: "2/20/2021 7:30 PM")!, specialDayType: .Today, overUnderBet: "OVER 205.5"),
                                UpcomingContestGame(homeTeam: "LA Lakers", awayTeam: "CHI Bulls", gameStartDateTime: dateFormatter.date(from: "2/20/2021 4:00 PM")!, specialDayType: .Today, spreadBet: "CHI +7"),
                                UpcomingContestGame(homeTeam: "POR Trail Blazers", awayTeam: "PHX Suns", gameStartDateTime: dateFormatter.date(from: "2/21/2021 11:30 AM")!, specialDayType: .Tomorrow, overUnderBet: "OVER 215.5", spreadBet: "POR -3.5"),
                                UpcomingContestGame(homeTeam: "MEM Grizzlies", awayTeam: "LA Clippers", gameStartDateTime: dateFormatter.date(from: "2/22/2021 2:15 PM")!, specialDayType: .None, spreadBet: "LA +2.5")
                            
                            ]),
            UpcomingContest(id: "fsodkodko3", opponent: "Toddd4445", firstGameStartDateTime: "Today at 5:15pm", numBets: 10,
                            games: [
                                UpcomingContestGame(homeTeam: "HOU Rockets", awayTeam: "CLE Cavaliers", gameStartDateTime: dateFormatter.date(from: "2/20/2021 4:00 PM")!, specialDayType: .Today, overUnderBet: "OVER 225", spreadBet: "HOU -7"),
                                UpcomingContestGame(homeTeam: "MIA Heat", awayTeam: "GS Warriors", gameStartDateTime: dateFormatter.date(from: "2/20/2021 7:30 PM")!, specialDayType: .Today, overUnderBet: "OVER 205.5"),
                                UpcomingContestGame(homeTeam: "LA Lakers", awayTeam: "CHI Bulls", gameStartDateTime: dateFormatter.date(from: "2/20/2021 4:00 PM")!, specialDayType: .Today, spreadBet: "CHI +7"),
                                UpcomingContestGame(homeTeam: "POR Trail Blazers", awayTeam: "PHX Suns", gameStartDateTime: dateFormatter.date(from: "2/21/2021 11:30 AM")!, specialDayType: .Tomorrow, overUnderBet: "OVER 215.5", spreadBet: "POR -3.5"),
                                UpcomingContestGame(homeTeam: "MEM Grizzlies", awayTeam: "LA Clippers", gameStartDateTime: dateFormatter.date(from: "2/22/2021 2:15 PM")!, specialDayType: .None, spreadBet: "LA +2.5")
                            
                            ]),
            UpcomingContest(id: "fa0130kfko", opponent: "Frank677", firstGameStartDateTime: "Today at 5:30pm", numBets: 10,
                            games: [
                                UpcomingContestGame(homeTeam: "HOU Rockets", awayTeam: "CLE Cavaliers", gameStartDateTime: dateFormatter.date(from: "2/20/2021 4:00 PM")!, specialDayType: .Today, overUnderBet: "OVER 225", spreadBet: "HOU -7"),
                                UpcomingContestGame(homeTeam: "MIA Heat", awayTeam: "GS Warriors", gameStartDateTime: dateFormatter.date(from: "2/20/2021 7:30 PM")!, specialDayType: .Today, overUnderBet: "OVER 205.5"),
                                UpcomingContestGame(homeTeam: "LA Lakers", awayTeam: "CHI Bulls", gameStartDateTime: dateFormatter.date(from: "2/20/2021 4:00 PM")!, specialDayType: .Today, spreadBet: "CHI +7"),
                                UpcomingContestGame(homeTeam: "POR Trail Blazers", awayTeam: "PHX Suns", gameStartDateTime: dateFormatter.date(from: "2/21/2021 11:30 AM")!, specialDayType: .Tomorrow, overUnderBet: "OVER 215.5", spreadBet: "POR -3.5"),
                                UpcomingContestGame(homeTeam: "MEM Grizzlies", awayTeam: "LA Clippers", gameStartDateTime: dateFormatter.date(from: "2/22/2021 2:15 PM")!, specialDayType: .None, spreadBet: "LA +2.5")
                            
                            ]),
            UpcomingContest(id: "fofodkok", opponent: "Peter_78", firstGameStartDateTime: "Today at 8pm", numBets: 10,
                            games: [
                                UpcomingContestGame(homeTeam: "HOU Rockets", awayTeam: "CLE Cavaliers", gameStartDateTime: dateFormatter.date(from: "2/20/2021 4:00 PM")!, specialDayType: .Today, overUnderBet: "OVER 225", spreadBet: "HOU -7"),
                                UpcomingContestGame(homeTeam: "MIA Heat", awayTeam: "GS Warriors", gameStartDateTime: dateFormatter.date(from: "2/20/2021 7:30 PM")!, specialDayType: .Today, overUnderBet: "OVER 205.5"),
                                UpcomingContestGame(homeTeam: "LA Lakers", awayTeam: "CHI Bulls", gameStartDateTime: dateFormatter.date(from: "2/20/2021 4:00 PM")!, specialDayType: .Today, spreadBet: "CHI +7"),
                                UpcomingContestGame(homeTeam: "POR Trail Blazers", awayTeam: "PHX Suns", gameStartDateTime: dateFormatter.date(from: "2/21/2021 11:30 AM")!, specialDayType: .Tomorrow, overUnderBet: "OVER 215.5", spreadBet: "POR -3.5"),
                                UpcomingContestGame(homeTeam: "MEM Grizzlies", awayTeam: "LA Clippers", gameStartDateTime: dateFormatter.date(from: "2/22/2021 2:15 PM")!, specialDayType: .None, spreadBet: "LA +2.5")
                            
                            ]),
            UpcomingContest(id: "dodkokok", opponent: "MattSmith2", firstGameStartDateTime: "Today at 8:45pm", numBets: 10,
                            games: [
                                UpcomingContestGame(homeTeam: "HOU Rockets", awayTeam: "CLE Cavaliers", gameStartDateTime: dateFormatter.date(from: "2/20/2021 4:00 PM")!, specialDayType: .Today, overUnderBet: "OVER 225", spreadBet: "HOU -7"),
                                UpcomingContestGame(homeTeam: "MIA Heat", awayTeam: "GS Warriors", gameStartDateTime: dateFormatter.date(from: "2/20/2021 7:30 PM")!, specialDayType: .Today, overUnderBet: "OVER 205.5"),
                                UpcomingContestGame(homeTeam: "LA Lakers", awayTeam: "CHI Bulls", gameStartDateTime: dateFormatter.date(from: "2/20/2021 4:00 PM")!, specialDayType: .Today, spreadBet: "CHI +7"),
                                UpcomingContestGame(homeTeam: "POR Trail Blazers", awayTeam: "PHX Suns", gameStartDateTime: dateFormatter.date(from: "2/21/2021 11:30 AM")!, specialDayType: .Tomorrow, overUnderBet: "OVER 215.5", spreadBet: "POR -3.5"),
                                UpcomingContestGame(homeTeam: "MEM Grizzlies", awayTeam: "LA Clippers", gameStartDateTime: dateFormatter.date(from: "2/22/2021 2:15 PM")!, specialDayType: .None, spreadBet: "LA +2.5")
                            
                            ])
        ]
 
    */
    }
}
