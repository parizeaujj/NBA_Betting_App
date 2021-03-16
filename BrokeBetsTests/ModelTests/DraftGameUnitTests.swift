//
//  DraftGameUnitTests.swift
//  BrokeBetsTests
//
//  Created by JJ on 3/14/21.
//

import Foundation
import SwiftUI
import Firebase
import XCTest

@testable import BrokeBets

class DraftGameUnitTests: XCTestCase {
    
    //setup reusable variables like mock completed contests
    //variables will be reinitiallized automattically per test
    
    var mockData: [String:Any] = [
            "gameId": "gameid1",
            "homeTeam": "HOU Rockets",
            "awayTeam": "CLE Cavaliers",
            "gameStartDateTime": Timestamp(date: Date()),
            "isSpreadBetStillAvailable": false,
            "isOverUnderBetStillAvailable": true,
            "isHomeTeamFavorite": true,
            "spreadFavoriteBetStr": "HOU -4",
            "spreadUnderdogBetStr": "CLE +4",
            "overBetStr": "o 218.5",
            "underBetStr": "u 218.5"
        ]
    
    func test_draftGame_formatted_correctly() throws {
        
        //change something in mock data
        //control test -where nothing is changed
        
        //load it in
        let draftGameInstance: DraftGame? = DraftGame(data: mockData)
        
        //assert
        XCTAssertNotNil(draftGameInstance, "Assert Not nil for unit test \"test_draftGame_formatted_correctly\" failed.")
    }
    
    func test_draftGame_invalid_type() throws {
        
        //change something in mock data
        mockData["isSpreadBetStillAvailable"] = "INVALID TYPE"
        
        //load it in
        let draftGameInstance: DraftGame? = DraftGame(data: mockData)
        
        //assert
        XCTAssertNil(draftGameInstance, "Assert nil for invalid_type failed.")
    }
    
    func test_draftGame_missing_dictionary_key_and_value() throws {
        
        //deleting ___ in mock data
        mockData.removeValue(forKey: "homeTeam")
        
        //load it in
        let draftGameInstance: DraftGame? = DraftGame(data: mockData)
        
        //assert
        XCTAssertNil(draftGameInstance, "Assert nil for missing_dictionary_key_and_value failed.")
    }
    
}
