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
    
    //drafted picks
    //forced picks
    //games pool
    
    //add games from CompletedContestGameUnitTests.swift
    //correctly formatted
//    func test_completedContest_games_correct() throws {
//
//        //change something in mock data
//        mockData.removeValue(forKey: "games")
//        mockData["games"] = [CompletedContestGameUnitTests().game]
//
//        //load it in
//        let completedContestInstance: CompletedContest? = CompletedContest(data: mockData, playerUid: testUID)
//
//        //assert
//        XCTAssertNotNil(completedContestInstance, "Assert not nil for games correct failed.")
//    }
//
//    //add games from CompletedContestGameUnitTests.swift
//    //incorrectly formatted
//    func test_completedContest_invalid_games_dictionary() throws {
//
//        //change something in mock data
//        mockData.removeValue(forKey: "games")
//        mockData["games"] = ["Invalid": "Data"]
//
//        //load it in
//        let completedContestInstance: CompletedContest? = CompletedContest(data: mockData, playerUid: testUID)
//
//        //assert
//        XCTAssertNil(completedContestInstance, "Assert nil for invalid games dictionary failed.")
//    }
    
    
}
