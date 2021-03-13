//
//  CompletedContestGameUnitTests.swift
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
    
    var game: [String: Any] =
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
    
    func test_completedContestGame_formatted_correctly() throws {
        
        //change something in mock data
        //nothing to change, since this is the control group of the tests
        
        //load it in
        let completedContestGameInstance: CompletedContestGame? = CompletedContestGame(game: game, playerLookupPrefix: playerLookupType.rawValue, todaysSimpleDate: rightNow)
        
        //assert
        XCTAssertNotNil(completedContestGameInstance, "Assert Not nil for unit test \"test_completedContestGame_formatted_correctly\" failed.")
    }
    
    //homeTeam
    func test_completedContestGame_incorrect_data_type_for_String_key() throws {
        
        //change something in mock data
        game["homeTeam"] = 66
        
        //load it in
        let completedContestGameInstance: CompletedContestGame? = CompletedContestGame(game: game, playerLookupPrefix: playerLookupType.rawValue, todaysSimpleDate: rightNow)
        
        //assert
        XCTAssertNil(completedContestGameInstance, "Assert nil for unit test incorrect_data_type_String_expected failed.")
    }
    
    //awayTeamScore
    func test_completedContestGame_incorrect_data_type_for_Int_key() throws {
        
        //change something in mock data
        game["awayTeamScore"] = "Invalid Data type. Int Expected"
        
        //load it in
        let completedContestGameInstance: CompletedContestGame? = CompletedContestGame(game: game, playerLookupPrefix: playerLookupType.rawValue, todaysSimpleDate: rightNow)
        
        //assert
        XCTAssertNil(completedContestGameInstance, "Assert nil for unit test incorrect_data_type_Int_expected failed.")
    }
    
    //gameWinner
    func test_completedContestGame_gameWinner_incorrect_value() throws {
        
        //change something in mock data
        game["gameWinner"] = "Incorrect Value"
        
        //load it in
        let completedContestGameInstance: CompletedContestGame? = CompletedContestGame(game: game, playerLookupPrefix: playerLookupType.rawValue, todaysSimpleDate: rightNow)
        
        //assert
        XCTAssertNil(completedContestGameInstance, "Assert nil for unit test gameWinner failed.")
    }
    
    //remove overUnderBetResults
    func test_completedContestGame_missing_overUnderBetResults() throws {
        
        //change something in mock data
        game.removeValue(forKey: "overUnderBetResults")
        
        //load it in
        let completedContestGameInstance: CompletedContestGame? = CompletedContestGame(game: game, playerLookupPrefix: playerLookupType.rawValue, todaysSimpleDate: rightNow)
        
        //assert
        XCTAssertNotNil(completedContestGameInstance, "Assert not nil for unit test remove overUnderBetResults failed.")
    }
    
    //Testing for OverUnderBetResults
    //invalid overUnderBetResults playerLookupPrefix
    func test_completedContestGame_invalid_overUnderBetResults_playerLookupPrefix() throws {
        
        //change something in mock data
        game.removeValue(forKey: "overUnderBetResults")
        game["overUnderBetResults"] = ["not player": ["not bet label": "not bet"]]
        
        //load it in
        let completedContestGameInstance: CompletedContestGame? = CompletedContestGame(game: game, playerLookupPrefix: playerLookupType.rawValue, todaysSimpleDate: rightNow)
        
        //assert
        XCTAssertNil(completedContestGameInstance, "Assert nil for unit test invalid_data_overUnderBetResults failed.")
    }
    
    //empty overUnderBetResults
    func test_completedContestGame_invalid_bet_Key_data_overUnderBetResults() throws {
        
        //change something in mock data
        game.removeValue(forKey: "overUnderBetResults")
        game["overUnderBetResults"] = [
               "player1": [
                   "Invalid Data here": "UNDER 225.5",
                   "result": "LOST"
               ],
               "player2": [
                   "Invalid Data here": "OVER 225.5",
                   "result": "WON"
               ]
            ]
        
        //load it in
        let completedContestGameInstance: CompletedContestGame? = CompletedContestGame(game: game, playerLookupPrefix: playerLookupType.rawValue, todaysSimpleDate: rightNow)
        
        //assert
        XCTAssertNil(completedContestGameInstance, "Assert nil for unit test invalid_bet_Key_data_overUnderBetResults failed.")
    }
    
    func test_completedContestGame_invalid_result_Key_data_overUnderBetResults() throws {
        
        //change something in mock data
        game.removeValue(forKey: "overUnderBetResults")
        game["overUnderBetResults"] = [
               "player1": [
                   "bet": "UNDER 225.5",
                   "Invalid Data here": "LOST"
               ],
               "player2": [
                   "bet": "OVER 225.5",
                   "Invalid Data here": "WON"
               ]
            ]
        
        //load it in
        let completedContestGameInstance: CompletedContestGame? = CompletedContestGame(game: game, playerLookupPrefix: playerLookupType.rawValue, todaysSimpleDate: rightNow)
        
        //assert
        XCTAssertNil(completedContestGameInstance, "Assert nil for unit test invalid_bet_Key_data_overUnderBetResults failed.")
    }
    
    
    //Testing for SpreadBetResults
    //remove overUnderBetResults
    func test_completedContestGame_missing_spreadBetResults() throws {
        
        //change something in mock data
        game.removeValue(forKey: "spreadBetResults")
        
        //load it in
        let completedContestGameInstance: CompletedContestGame? = CompletedContestGame(game: game, playerLookupPrefix: playerLookupType.rawValue, todaysSimpleDate: rightNow)
        
        //assert
        XCTAssertNotNil(completedContestGameInstance, "Assert not nil for unit test remove spreadBetResults failed.")
    }
    
    //invalid overUnderBetResults playerLookupPrefix
    func test_completedContestGame_invalid_spreadBetResults_playerLookupPrefix() throws {
        
        //change something in mock data
        game.removeValue(forKey: "spreadBetResults")
        game["spreadBetResults"] = ["not player": ["not bet label": "not bet"]]
        
        //load it in
        let completedContestGameInstance: CompletedContestGame? = CompletedContestGame(game: game, playerLookupPrefix: playerLookupType.rawValue, todaysSimpleDate: rightNow)
        
        //assert
        XCTAssertNil(completedContestGameInstance, "Assert nil for unit test invalid_data_spreadBetResults failed.")
    }
    
    //empty overUnderBetResults
    func test_completedContestGame_invalid_bet_Key_data_spreadBetResults() throws {
        
        //change something in mock data
        game.removeValue(forKey: "spreadBetResults")
        game["spreadBetResults"] = [
               "player1": [
                   "Invalid Data here": "UNDER 225.5",
                   "result": "LOST"
               ],
               "player2": [
                   "Invalid Data here": "OVER 225.5",
                   "result": "WON"
               ]
            ]
        
        //load it in
        let completedContestGameInstance: CompletedContestGame? = CompletedContestGame(game: game, playerLookupPrefix: playerLookupType.rawValue, todaysSimpleDate: rightNow)
        
        //assert
        XCTAssertNil(completedContestGameInstance, "Assert nil for unit test invalid_bet_Key_data_spreadBetResults failed.")
    }
    
    func test_completedContestGame_invalid_result_Key_data_spreadBetResults() throws {
        
        //change something in mock data
        game.removeValue(forKey: "spreadBetResults")
        game["spreadBetResults"] = [
               "player1": [
                   "bet": "UNDER 225.5",
                   "Invalid Data here": "LOST"
               ],
               "player2": [
                   "bet": "OVER 225.5",
                   "Invalid Data here": "WON"
               ]
            ]
        
        //load it in
        let completedContestGameInstance: CompletedContestGame? = CompletedContestGame(game: game, playerLookupPrefix: playerLookupType.rawValue, todaysSimpleDate: rightNow)
        
        //assert
        XCTAssertNil(completedContestGameInstance, "Assert nil for unit test invalid_bet_Key_data_spreadBetResults failed.")
    }
    
}
