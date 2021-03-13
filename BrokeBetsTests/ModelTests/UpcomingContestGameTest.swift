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
    
//    func test5() throws {
//
//            //change something in mock data
//            game1["overUnderBet"] = 1234
//
//            //load it in
//        let upcomingContestGameInstance: UpcomingContestGame? = UpcomingContestGame(game: game1, playerLookupPrefix: playerLookup.rawValue, todaysSimpleDate: todaysDate)
//
//            //assert
//            XCTAssertNil(upcomingContestGameInstance, "Assert nill for unit test X failed.")
//        }
//
//    func test6() throws {
//
//            //change something in mock data
//        game1["overUnderBet"] = "invalid"
//
//            //load it in
//        let upcomingContestGameInstance: UpcomingContestGame? = UpcomingContestGame(game: game1, playerLookupPrefix: playerLookup.rawValue, todaysSimpleDate: todaysDate)
//
//            //assert
//            XCTAssertNil(upcomingContestGameInstance, "Assert  nill for unit test X failed.")
//        }
    
    
}
