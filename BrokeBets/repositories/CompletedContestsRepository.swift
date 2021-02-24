//
//  CompletedContestsRepository.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/23/21.
//

import Foundation

/*
protocol CompletedContestsRepositoryProtocol {

    var completedContests: [UpcomingContest] { get }
    var completedContestsPublisher: Published<[UpcomingContest]>.Publisher { get }
    var completedContestsPublished: Published<[UpcomingContest]> { get }
    
    
    func getUpcomingContests() -> Void
    
}


// MOCK
class MockCompletedContestsRepository: CompletedContestsRepositoryProtocol, ObservableObject {
    
    @Published var completedContests: [CompletedContest] = []
    var completedContestsPublished: Published<[CompletedContest]> { _cpcomingContests }
    var completedContestsPublisher: Published<[CompletedContest]>.Publisher { $cpcomingContests }
    
    
    var dateFormatter: DateFormatter
    
    init() {
        
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yyyy h:mm a"
        
        getUpcomingContests()
    }
    
    func getUpcomingContests(){
        
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
    }
}
*/