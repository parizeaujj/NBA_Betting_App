//
//  UpcomingContestGameTest.swift
//  BrokeBetsTests
//
//  Created by Fabrizio Herrera on 3/14/21.
//

import Foundation
import SwiftUI
import Firebase
import XCTest
@testable import BrokeBets

class InProgressContestGameTest: XCTestCase {
    
    var playerLookupType: PlayerLookupType = .PlayerOne
    var rightNow: SimpleDate = SimpleDate(date: Date())
    
    var game: [String: Any] =
                                [
                                 "gameId": "game1id",
                                 "awayTeam": "HOU Rockets",
                                 "homeTeam": "MIA Heat",
                                 "timeGameStarted": Timestamp(date: Date()),
                                 "overUnderBet": [
                                        "player1": "OVER 225.5",
                                        "player2": "UNDER 225.5"
                                 ],
                                 "spreadBet": [
                                        "player1": "MIA -7",
                                        "player2": "HOU +7"
                                 ]
                                ]
    
    func test_inProgressContestGame_formatted_correctly() throws {
        
        let inProgressContestGameInstance: InProgressContestGame? = InProgressContestGame(game: game, playerLookupPrefix: playerLookupType.rawValue)
        
        XCTAssertNotNil(inProgressContestGameInstance, "Assert not nil for unit test \"test_InProgressContestGame_formatted_correctly\" failed")
    }
    
    func test_inProgressContestGame_incorrect_data_type_for_String_key() throws {
        
        game["gameId"] = 999
        
        let inProgressContestGameInstance: InProgressContestGame? = InProgressContestGame(game: game, playerLookupPrefix: playerLookupType.rawValue)
        
        XCTAssertNil(inProgressContestGameInstance, "Assert nil for unit test \"test_inProgressContestGame_incorrect_data_type_for_String_key\" failed")
    }
    
    func test_inProgressContestGame_incorrect_data_type_for_timestamp_key() throws {
        
        game["timeGameStarted"] = 999
        
        let inProgressContestGameInstance: InProgressContestGame? = InProgressContestGame(game: game, playerLookupPrefix: playerLookupType.rawValue)
        
        XCTAssertNil(inProgressContestGameInstance, "Assert nil for unit test \"test_inProgressContestGame_incorrect_data_type_for_timestamp_key\" failed")
    }
    
    func test_inProgressContestGame_incorrect_data_type_homeTeam() throws {
        
        game["homeTeam"] = 999
        
        let inProgressContestGameInstance: InProgressContestGame? = InProgressContestGame(game: game, playerLookupPrefix: playerLookupType.rawValue)
        
        XCTAssertNil(inProgressContestGameInstance, "Assert nil for unit test \"test_inProgressContestGame_homeTeam_incorrect_value\" failed")
    }
    
    func test_inProgressContestGame_missing_spreadBet() throws {
        
        game.removeValue(forKey: "spreadBet")
        
        let inProgressContestGameInstance: InProgressContestGame? = InProgressContestGame(game: game, playerLookupPrefix: playerLookupType.rawValue)
        
        XCTAssertNotNil(inProgressContestGameInstance, "Assert nil for unit test \"test_inProgressContestGame_missing_spreadBet\" failed")
    }
}

