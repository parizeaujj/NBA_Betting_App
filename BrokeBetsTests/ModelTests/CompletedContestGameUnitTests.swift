//
//  CompletedContestsUnitTests.swift
//  BrokeBetsTests
//
//  Created by JJ on 3/13/21.
//

import Foundation
import SwiftUI
import Firebase
import XCTest

@testable import BrokeBets

class CompletedContestGameUnitTests: XCTestCase {
    
    //setup reusable variables like mock completed contests
    //variables will be reinitiallized automattically per test
    
    var playerLookupType: PlayerLookupType = .PlayerOne
    var rightNow: SimpleDate = SimpleDate(date: Date())
    
    var game1: [String: Any] =
        ["awayTeam": "HOU Rockets",
            "homeTeam": "MIA Heat",
            "awayTeamScore": 97,
            "homeTeamScore": 110,
            "gameWinner" : "HOME", // can be 'HOME', 'AWAY', or 'TIE'
            "gameCompletionDateTime": Timestamp(date: Date()),
            "overUnderBetResults": [
               "player1": [
                   "bet": "UNDER 225.5",
                   "result": "LOST"
               ],
               "player2": [
                   "bet": "OVER 225.5",
                   "result": "WON"
               ]
            ],
            "spreadBetResults": [
               "player1": [
                   "bet": "MIA -7",
                   "result": "WON"
               ],
               "player2": [
                   "bet": "HOU +7",
                   "result": "LOST"
               ]
            ]
        ]
    
//    var game2: [String: Any] =
//        ["awayTeam": "LA Clippers",
//         "homeTeam": "UT Jazz",
//         "awayTeamScore": 110,
//         "homeTeamScore": 116,
//         "gameWinner" : "HOME", // can be 'HOME', 'AWAY', or 'TIE'
//         "gameCompletionDateTime": Timestamp(date: Date()),
//         "overUnderBetResults": [
//            "player1": [
//                "bet": "OVER 220",
//                "result": "WON"
//            ],
//            "player2": [
//                "bet": "UNDER 220",
//                "result": "LOST"
//            ]
//         ]
//        ]
    
    func test_completedContestGame_formatted_correctly() throws {
        
        //change something in mock data
        
        //load it in
        let completedContestGameInstance: CompletedContestGame? = CompletedContestGame(game: game1, playerLookupPrefix: playerLookupType.rawValue, todaysSimpleDate: rightNow)
        
        //assert
        XCTAssertNotNil(completedContestGameInstance, "Assert Not nil for unit test \"test_completedContestGame_formatted_correctly\" failed.")
    }
    
    //homeTeam
    func test_completedContest_incorrect_data_type_for_String_key() throws {
        
        //change something in mock data
        game1["homeTeam"] = 66
        
        //load it in
        let completedContestGameInstance: CompletedContestGame? = CompletedContestGame(game: game1, playerLookupPrefix: playerLookupType.rawValue, todaysSimpleDate: rightNow)
        
        //assert
        XCTAssertNil(completedContestGameInstance, "Assert nil for unit test incorrect_data_type_String_expected failed.")
    }
    
    //awayTeamScore
    func test_completedContest_incorrect_data_type_for_Int_key() throws {
        
        //change something in mock data
        game1["awayTeamScore"] = "Invalid Data type. Int Expected"
        
        //load it in
        let completedContestGameInstance: CompletedContestGame? = CompletedContestGame(game: game1, playerLookupPrefix: playerLookupType.rawValue, todaysSimpleDate: rightNow)
        
        //assert
        XCTAssertNil(completedContestGameInstance, "Assert nil for unit test incorrect_data_type_Int_expected failed.")
    }
    
    //gameWinner
    func test_completedContest_gameWinner_incorrect_value() throws {
        
        //change something in mock data
        game1["gameWinner"] = "Incorrect Value"
        
        //load it in
        let completedContestGameInstance: CompletedContestGame? = CompletedContestGame(game: game1, playerLookupPrefix: playerLookupType.rawValue, todaysSimpleDate: rightNow)
        
        //assert
        XCTAssertNil(completedContestGameInstance, "Assert nil for unit test gameWinner failed.")
    }
}
