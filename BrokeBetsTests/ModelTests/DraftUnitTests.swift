//
//  DraftUnitTests.swift
//  BrokeBetsTests
//
//  Created by JJ on 3/14/21.
//

import Foundation
import SwiftUI
import Firebase
import XCTest

@testable import BrokeBets

class DraftUnitTests: XCTestCase {
    
    //setup reusable variables like mock completed contests
    //variables will be reinitiallized automattically per test
    
    var playerUid: String = "testToddUid"
    
    var mockData: [String:Any] = [
        "draftId": "draftid_1",
        "player1_uid": "testToddUid",
        "player1_uname": "todd123",
        "player2_uid": "testOppUid",
        "player2_uname": "testopp",
        "currentPlayerTurn": "player1",
        "currentRound": 1,
        "totalRounds": 5,
        "draftExpirationDateTime": Timestamp(date: Date()),
        "player1_drafted_picks": [],
        "player1_forced_picks": [],
        "player2_drafted_picks": [],
        "player2_forced_picks": [],
        "games_pool": []
    ]
    
    func test_draft_formatted_correctly() throws {
        
        //change something in mock data
        //control test -where nothing is changed
        
        //load it in
        let draftInstance: Draft? = Draft(data: mockData, playerUid: playerUid)
        
        //assert
        XCTAssertNotNil(draftInstance, "Assert Not nil for unit test \"test_draft_formatted_correctly\" failed.")
    }
    
    func test_draft_unfound_uid() throws {
        
        //change something in mock data
        playerUid = "INVALID VALUE"
        
        //load it in
        let draftInstance: Draft? = Draft(data: mockData, playerUid: playerUid)
        
        //assert
        XCTAssertNil(draftInstance, "Assert nil failed. Should've returned nil when playerUid was not found, but did not.")
    }
    
    func test_draft_incorrect_type_for_userName() throws {
        
        //change something in mock data
        mockData["player1_uname"] = 9999
        
        //load it in
        let draftInstance: Draft? = Draft(data: mockData, playerUid: playerUid)
        
        //assert
        XCTAssertNil(draftInstance, "Assert nil failed. Should've returned nil cause of incorrect_type_for_userName.")
    }
    
    func test_draft_incorrect_type_for_currentRound() throws {
        
        //change something in mock data
        mockData["currentRound"] = "INVALID VALUE"
        
        //load it in
        let draftInstance: Draft? = Draft(data: mockData, playerUid: playerUid)
        
        //assert
        XCTAssertNil(draftInstance, "Assert nil failed. Should've returned nil cause of incorrect_type_for_currentRound.")
    }
    
    func test_draft_currentRound_missing() throws {
        
        //change something in mock data
        mockData.removeValue(forKey: "currentRound")
        
        //load it in
        let draftInstance: Draft? = Draft(data: mockData, playerUid: playerUid)
        
        //assert
        XCTAssertNil(draftInstance, "Assert nil failed. Should've returned nil cause of currentRound_missing.")
    }
    
    func test_draft_invalid_value_for_currentPlayerTurn() throws {
        
        //change something in mock data
        mockData["currentPlayerTurn"] = "Correct Type, && INVALID VALUE"
        
        //load it in
        let draftInstance: Draft? = Draft(data: mockData, playerUid: playerUid)
        
        //assert
        XCTAssertNil(draftInstance, "Assert nil failed. Should've returned nil cause there's an invalid_value_for_currentPlayerTurn.")
    }
    
    func test_draft_nil_draftExpirationDateTime() throws {
        
        //change something in mock data
        mockData["draftExpirationDateTime"] = nil
        
        //load it in
        let draftInstance: Draft? = Draft(data: mockData, playerUid: playerUid)
        
        //assert
        XCTAssertNil(draftInstance, "Assert nil failed. Should've returned nil cause draftExpirationDateTime is nil.")
    }
    
    func test_draft_drafted_and_forcedPicks_invalid_lengths() throws {
        
        //change something in mock data //lengths of 2 and 0 > 1, so nil
        mockData["player1_drafted_picks"] = [
            ["String":"String"],
            ["String":"String"]
        ]
        mockData["player1_forced_picks"] = []
        
        //load it in
        let draftInstance: Draft? = Draft(data: mockData, playerUid: playerUid)
        
        //assert
        XCTAssertNil(draftInstance, "Assert nil failed. Should've returned nil cause draftExpirationDateTime is nil.")
    }
    
    
    
    
    //games pool
    //add games pool from CompletedContestGameUnitTests.swift
    func test_draft_games_correct() throws {

        //correct games_pool data
        mockData.removeValue(forKey: "games_pool")
        mockData["games_pool"] = [DraftGameUnitTests().mockData]

        //load it in
        let draftInstance: Draft? = Draft(data: mockData, playerUid: playerUid)

        //assert
        XCTAssertNotNil(draftInstance, "Assert not nil for games_pool with correct data failed.")
    }
    
    //drafted picks
    func test_draft_games_player1_drafted_picks() throws {

        //correct player1_drafted_picks data
        mockData.removeValue(forKey: "player1_drafted_picks")
        mockData["player1_drafted_picks"] = [DraftRoundUnitTests().mockDataDrafted]

        //load it in
        let draftInstance: Draft? = Draft(data: mockData, playerUid: playerUid)

        //assert
        XCTAssertNotNil(draftInstance, "Assert not nil for player1_drafted_picks with correct data failed.")
    }

    //forced picks
    func test_draft_games_player1_forced_picks() throws {

        //correct player1_drafted_picks data
        mockData.removeValue(forKey: "player1_forced_picks")
        mockData["player1_forced_picks"] = [DraftRoundUnitTests().mockDataForced]

        //load it in
        let draftInstance: Draft? = Draft(data: mockData, playerUid: playerUid)

        //assert
        XCTAssertNotNil(draftInstance, "Assert not nil for player1_drafted_picks with correct data failed.")
    }
    
    
}
