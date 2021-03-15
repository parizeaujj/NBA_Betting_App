//
//  InProgressContestUnitTest.swift
//  BrokeBetsTests
//
//  Created by Fabrizio Herrera on 3/13/21.
//

import Foundation
import SwiftUI
import Firebase
import XCTest

@testable import BrokeBets

class InProgressContestUnitTests: XCTestCase {
    
    var testUID: String = "testToddUid"
    
    var mockData: [String: Any] =
        ["player1_uid": "testToddUid",
         "player1_uname": "todd123",
         "player2_uid": "testOppUid",
         "player2_uname": "testOpp",
         "player1_total": 3,
         "player2_total": 1,
         "player1_forced": 1,
         "player2_forced": 0,
         "player1_drafted": 2,
         "player2_drafted": 1,
         "numBets": 3,
         "numBetsRemaining": 2,
         "numBetsCompleted": 1
        ]

    
    var contestId = "222"
    
    func test_inProgressContest_formatted_correctly() throws {
        
        // using mock data
        
        let inProgressContestInstance: InProgressContest? = InProgressContest(data: mockData, playerUid: testUID, contestId: contestId)
        
        XCTAssertNotNil(inProgressContestInstance, "Assert Not Nil for unit test \"test_InProgressContest_formatted_correctly\" failed.")
    }
    
    func test_inProgressContest_uid_not_found() throws {
        
        testUID = "wrong UID"
        
        let inProgressContestInstance: InProgressContest? = InProgressContest(data: mockData, playerUid: testUID, contestId: contestId)
        
        XCTAssertNil(inProgressContestInstance, "Assert Not Nil for unit test \"test_InProgressContest_uid_not_found\" failed.")
    }
    
    func test_inProgressContest_invalid_type_for_cast_String() throws {
        
        mockData["player1_uid"] = 111
        
        let inProgressContestInstance: InProgressContest? = InProgressContest(data: mockData, playerUid: testUID, contestId: contestId)
        
        XCTAssertNil(inProgressContestInstance, "Assert Nil for unit test \"test_InProgressContest_invalid_type_for_cast_String\" failed.")
    }
    
    func test_inProgressContest_missing_dictionary_entry() throws {
        
        mockData.removeValue(forKey: "numBets")
        
        let inProgressContestInstance: InProgressContest? = InProgressContest(data: mockData, playerUid: testUID, contestId: contestId)
        
        XCTAssertNil(inProgressContestInstance, "Assert Nil for unit test \"test_InProgressContest_invalid_missing_dictionary_entry\" failed.")
    }
    
    func test_completedContest_replace_dictionary_entry_with_misspelled() throws {
        
        mockData.removeValue(forKey: "player2_uname")
        mockData["player2_username"] = "unknown name"
        
        let inProgressContestInstance: InProgressContest? = InProgressContest(data: mockData, playerUid: testUID, contestId: contestId)
        
        XCTAssertNil(inProgressContestInstance, "Assert nil for unit test \"test_completedContest_replace_dictionary_entry_with_misspelled\" failed.")
    }
    
    func test_completedContest_invalid_finalScore_type() throws {
        
        mockData["player2_total"] = "passing String instead of Int"
        
        let inProgressContestInstance: InProgressContest? = InProgressContest(data: mockData, playerUid: testUID, contestId: contestId)
        
        XCTAssertNil(inProgressContestInstance, "Assert nill for unit test \"test_completedContest_invalid_finalScore_type\" failed.")
    }
    
    func test_completedContest_invalid_forced_type() throws {
        
        mockData["player2_forced"] = "passing String instead of Int"
        
        let inProgressContestInstance: InProgressContest? = InProgressContest(data: mockData, playerUid: testUID, contestId: contestId)
        
        XCTAssertNil(inProgressContestInstance, "Assert nill for unit test \"test_completedContest_invalid_forced_type\" failed.")
    }
    
    func test_completedContest_invalid_drafted_type() throws {
        
        mockData["player2_drafted"] = "passing String instead of Int"
        
        let inProgressContestInstance: InProgressContest? = InProgressContest(data: mockData, playerUid: testUID, contestId: contestId)
        
        XCTAssertNil(inProgressContestInstance, "Assert nill for unit test \"test_completedContest_invalid_forced_type\" failed.")
    }
    
    func test_inProgressContest_invalid_numBetsRemaining_type() throws {
        
        mockData["numBets"] = "passing String instead of Int"
        
        let inProgressContestInstance: InProgressContest? = InProgressContest(data: mockData, playerUid: testUID, contestId: contestId)
        
        XCTAssertNil(inProgressContestInstance, "Assert nill for unit test \"test_completedContest_invalid_numBetsRemaining_type\" failed.")
    }
    
    func test_inProgressContest_invalid_upcoming_games_dictionary() throws {
        
        mockData["upcoming_games"]  = []
        
        let inProgressContestInstance: InProgressContest? = InProgressContest(data: mockData, playerUid: testUID, contestId: contestId)
        
        XCTAssertNotNil(inProgressContestInstance, "Assert nil for unit test \"test_inProgressContest_invalid_upcoming_games_dictionary\" failed.")

    }
    
    func test_inProgressContest_valid_upcoming_games_dictionary() throws {
        
        mockData["upcoming_games"]  = [UpcomingContestGameTest().game1]
        
        let inProgressContestInstance: InProgressContest? = InProgressContest(data: mockData, playerUid: testUID, contestId: contestId)
        
        XCTAssertNotNil(inProgressContestInstance, "Assert not nil for unit test \"test_inProgressContest_valid_upcoming_games_dictionary\" failed.")
    }
    
    func test_inProgressContest_invalid_inProgress_games_dictionary() throws {
        
        mockData["inProgress_games"]  = []
        
        let inProgressContestInstance: InProgressContest? = InProgressContest(data: mockData, playerUid: testUID, contestId: contestId)
        
        XCTAssertNotNil(inProgressContestInstance, "Assert nil for unit test \"test_inProgressContest_invalid_inProgress_games_dictionary\" failed.")

    }
    
    func test_inProgressContest_valid_inProgress_games_dictionary() throws {
        
        mockData["inProgress_games"]  = [InProgressContestGameTest().game]
        
        let inProgressContestInstance: InProgressContest? = InProgressContest(data: mockData, playerUid: testUID, contestId: contestId)
        
        XCTAssertNotNil(inProgressContestInstance, "Assert not nil for unit test \"test_inProgressContest_valid_inProgress_games_dictionary\" failed.")
    }
    
    func test_inProgressContest_invalid_completed_games_dictionary() throws {
        
        mockData["completed_games"]  = []
        
        let inProgressContestInstance: InProgressContest? = InProgressContest(data: mockData, playerUid: testUID, contestId: contestId)
        
        XCTAssertNotNil(inProgressContestInstance, "Assert nil for unit test \"test_inProgressContest_invalid_completed_games_dictionary\" failed.")

    }
    
    func test_inProgressContest_valid_completed_games_dictionary() throws {
        
        mockData["completed_games"]  = [CompletedContestGameUnitTests().game]
        
        let inProgressContestInstance: InProgressContest? = InProgressContest(data: mockData, playerUid: testUID, contestId: contestId)
        
        XCTAssertNotNil(inProgressContestInstance, "Assert not nil for unit test \"test_inProgressContest_valid_completed_games_dictionary\" failed.")
    }
}

