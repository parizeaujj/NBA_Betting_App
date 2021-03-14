//
//  UpcomingContestGameTest.swift
//  BrokeBetsTests
//
//  Created by Aland Nguyen on 3/13/21.
//

import Foundation
import SwiftUI
import Firebase
import XCTest
@testable import BrokeBets

class UpcomingContestGameTest: XCTestCase {
    
    // Mock data for testing
    var playerLookup: PlayerLookupType = .PlayerOne
    var todaysDate: SimpleDate = SimpleDate(date: Date())
    
    var game1: [String: Any] =
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
                       ]
    var game2: [String: Any] =
                        // game 2
                        ["awayTeam": "GS Warriors",
                         "homeTeam": "NY Knicks",
                         "gameStartDateTime": Timestamp(date: Date()),
                         "spreadBet": [
                                "player1": "GS -3.5",
                                "player2": "NY +3.5"
                         ]
                        ]
                
            
    // First test to test it is working correctly
    func test1() throws {
            
            //change something in mock data

            //load it in
        let upcomingContestGameInstance: UpcomingContestGame? = UpcomingContestGame(game: game1, playerLookupPrefix: playerLookup.rawValue, todaysSimpleDate: todaysDate)
            
            //assert
            XCTAssertNotNil(upcomingContestGameInstance, "Assert nill for unit test X failed.")
        }
    
    func test2() throws {
            
            //change something in mock data
            game1["awayTeam"] = 56
        
            //load it in
        let upcomingContestGameInstance: UpcomingContestGame? = UpcomingContestGame(game: game1, playerLookupPrefix: playerLookup.rawValue, todaysSimpleDate: todaysDate)
            
            //assert
            XCTAssertNil(upcomingContestGameInstance, "Assert nill for unit test X failed.")
        }
    
    func test3() throws {
            
            //change something in mock data
            game1["homeTeam"] = 5123
        
            //load it in
        let upcomingContestGameInstance: UpcomingContestGame? = UpcomingContestGame(game: game1, playerLookupPrefix: playerLookup.rawValue, todaysSimpleDate: todaysDate)
            
            //assert
            XCTAssertNil(upcomingContestGameInstance, "Assert nill for unit test X failed.")
        }
    
    func test4() throws {
            
            //change something in mock data
            game1["gameStartDateTime"] = "invalid"
        
            //load it in
        let upcomingContestGameInstance: UpcomingContestGame? = UpcomingContestGame(game: game1, playerLookupPrefix: playerLookup.rawValue, todaysSimpleDate: todaysDate)
            
            //assert
            XCTAssertNil(upcomingContestGameInstance, "Assert nill for unit test X failed.")
        }
    
    // Still need to complete some tests
    
    func test5() throws {
        
        //change something in mock data
        game1.removeValue(forKey: "overUnderBet")
        
        //load it in
        let upcomingContestGameInstance: UpcomingContestGame? = UpcomingContestGame(game: game1, playerLookupPrefix: playerLookup.rawValue, todaysSimpleDate: todaysDate)
            
        //assert
        XCTAssertNotNil(upcomingContestGameInstance, "Assert Not nill for unit test X failed.")
    }

    func test6() throws {
        
        //change something in mock data
        game1.removeValue(forKey: "overUnderBet")
        game1["overUnderBet"] = ["not player": ["not bet label": "not bet"]]
        
        //load it in
        let upcomingContestGameInstance: UpcomingContestGame? = UpcomingContestGame(game: game1, playerLookupPrefix: playerLookup.rawValue, todaysSimpleDate: todaysDate)
            
        //assert
        XCTAssertNil(upcomingContestGameInstance, "Assert nill for unit test X failed.")
    }
    
    func test7() throws {
        
        //change something in mock data
        game1.removeValue(forKey: "overUnderBet")
        game1["overUnderBet"] = [
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
        let upcomingContestGameInstance: UpcomingContestGame? = UpcomingContestGame(game: game1, playerLookupPrefix: playerLookup.rawValue, todaysSimpleDate: todaysDate)
            
        //assert
        XCTAssertNil(upcomingContestGameInstance, "Assert nill for unit test X failed.")
    }
    
    func test8() throws {
        
        //change something in mock data
        game1.removeValue(forKey: "overUnderBet")
        game1["overUnderBet"] = [
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
        let upcomingContestGameInstance: UpcomingContestGame? = UpcomingContestGame(game: game1, playerLookupPrefix: playerLookup.rawValue, todaysSimpleDate: todaysDate)
            
        //assert
        XCTAssertNil(upcomingContestGameInstance, "Assert nill for unit test X failed.")
    }
    
    func test9() throws {
        
        //change something in mock data
        game1.removeValue(forKey: "spreadBet")
        
        //load it in
        let upcomingContestGameInstance: UpcomingContestGame? = UpcomingContestGame(game: game1, playerLookupPrefix: playerLookup.rawValue, todaysSimpleDate: todaysDate)
            
            //assert
            XCTAssertNotNil(upcomingContestGameInstance, "Assert nill for unit test X failed.")
    }
    
    func test10() throws {
        
        //change something in mock data
        game1.removeValue(forKey: "spreadBet")
        game1["spreadBet"] = ["not player": ["not bet label": "not bet"]]
        
        //load it in
        let upcomingContestGameInstance: UpcomingContestGame? = UpcomingContestGame(game: game1, playerLookupPrefix: playerLookup.rawValue, todaysSimpleDate: todaysDate)
            
        //assert
        XCTAssertNil(upcomingContestGameInstance, "Assert nill for unit test X failed.")
    }
    
    func test11() throws {
        
        //change something in mock data
        game1.removeValue(forKey: "spreadBet")
        game1["spreadBet"] = [
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
        //load it in
        let upcomingContestGameInstance: UpcomingContestGame? = UpcomingContestGame(game: game1, playerLookupPrefix: playerLookup.rawValue, todaysSimpleDate: todaysDate)
            
        //assert
        XCTAssertNil(upcomingContestGameInstance, "Assert nill for unit test X failed.")
    }
    
    func test12() throws {
        
        //change something in mock data
        game1.removeValue(forKey: "spreadBet")
        game1["spreadBet"] = [
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
        let upcomingContestGameInstance: UpcomingContestGame? = UpcomingContestGame(game: game1, playerLookupPrefix: playerLookup.rawValue, todaysSimpleDate: todaysDate)
            
        //assert
        XCTAssertNil(upcomingContestGameInstance, "Assert nill for unit test X failed.")
    }
    
}
