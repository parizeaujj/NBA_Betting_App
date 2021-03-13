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

class CompletedContestsUnitTests: XCTestCase {
    
    //setup reusable variables like mock completed contests
    //variables will be reinitiallized automattically per test
    
    var testUID: String = "testToddUid"
    
    var mockData: [String: Any] =
        ["completionDateTime": Timestamp(date: Date()),
         "player1_uid": "testToddUid",
         "player1_uname": "todd123",
         "player2_uid": "testOppUid",
         "player2_uname": "testOpp",
         "player1_total": 3,
         "player2_total": 1,
         "player1_forced": 1,
         "player2_forced": 0,
         "player1_drafted": 2,
         "player2_drafted": 1,
         "contestResults": [
            "player1": "WON",
            "player2": "LOST"
         ],
         "numBets": 3,
         "games": [
            
            // game 1
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
            ],
            
            // game 2
            
            ["awayTeam": "LA Clippers",
             "homeTeam": "UT Jazz",
             "awayTeamScore": 110,
             "homeTeamScore": 116,
             "gameWinner" : "HOME", // can be 'HOME', 'AWAY', or 'TIE'
             "gameCompletionDateTime": Timestamp(date: Date()),
             "overUnderBetResults": [
                "player1": [
                    "bet": "OVER 220",
                    "result": "WON"
                ],
                "player2": [
                    "bet": "UNDER 220",
                    "result": "LOST"
                ]
             ]
            ],
            
            
         ]
        ]
    
    func test_completedContest_formatted_correctly() throws {
        
        //change something in mock data
        
        //load it in
        let completedContestInstance: CompletedContest? = CompletedContest(data: mockData, playerUid: testUID)
        
        //assert
        XCTAssertNotNil(completedContestInstance, "Assert Not nill for unit test \"test_completedContest_formatted_correctly\" failed.")
    }
    
    func test_completedContest_unfound_uid() throws {
        
        //change something in mock data
        testUID = "neither user has this uid"
        
        //load it in
        let completedContestInstance: CompletedContest? = CompletedContest(data: mockData, playerUid: testUID)
        
        //assert
        XCTAssertNil(completedContestInstance, "Assert nill failed. Should've returned nil when testUID was not found, but did not.")
    }
    
    func test_completedContest_invalid_type_for_cast_to_String() throws {
        
        //change something in mock data
        mockData["player1_uid"] = 999
        
        //load it in
        let completedContestInstance: CompletedContest? = CompletedContest(data: mockData, playerUid: testUID)
        
        //assert
        XCTAssertNil(completedContestInstance, "Assert nil for unit test X failed.")
    }
    
    //test missing dictionary field key and value
    func test_completedContest_missing_dictionary_entry() throws {
        
        //change something in mock data
        mockData.removeValue(forKey: "player1_uname")
        
        //load it in
        let completedContestInstance: CompletedContest? = CompletedContest(data: mockData, playerUid: testUID)
        
        //assert
        XCTAssertNil(completedContestInstance, "Assert nil for unit test X failed.")
    }
    
    //test misspelled dictionary key
    func test_completedContest_replace_dictionary_entry_with_misspelled() throws {
        
        //change something in mock data
        mockData.removeValue(forKey: "player1_uname") //removeing and replacing
        mockData["player1_username"] = "some name" //changed uname to username //to create incorrect key
        
        //load it in
        let completedContestInstance: CompletedContest? = CompletedContest(data: mockData, playerUid: testUID)
        
        //assert
        XCTAssertNil(completedContestInstance, "Assert nil for unit test X failed.")
    }
    
    //UID 32 RID 26, UID 33 RID 31
    func test_completedContest_invalid_finalScore_type() throws {
        
        //change something in mock data
        mockData["player1_total"] = "invalid type of String, should be Int"
        
        //load it in
        let completedContestInstance: CompletedContest? = CompletedContest(data: mockData, playerUid: testUID)
        
        //assert
        XCTAssertNil(completedContestInstance, "Assert nill for unit test final_score failed.")
    }
    
    //UID 32 RID 28, UID 33 RID 33
    func test_completedContest_invalid_forced_type() throws {
        
        //change something in mock data
        mockData["player2_forced"] = "invalid type of String, should be Int"
        
        //load it in
        let completedContestInstance: CompletedContest? = CompletedContest(data: mockData, playerUid: testUID)
        
        //assert
        XCTAssertNil(completedContestInstance, "Assert nill for unit test forced_total failed.")
    }
    
    //UID 32 RID 29, UID 33 RID 33
    func test_completedContest_invalid_drafted_type() throws {
        
        //change something in mock data
        mockData["player1_drafted"] = "invalid type of String, should be Int"
        
        //load it in
        let completedContestInstance: CompletedContest? = CompletedContest(data: mockData, playerUid: testUID)
        
        //assert
        XCTAssertNil(completedContestInstance, "Assert nill for unit test drafted_total failed.")
    }
    
    //UID 32 RID 30, UID 33 RID 34
    func test_completedContest_invalid_numBets_type() throws {
        
        //change something in mock data
        mockData["numBets"] = "invalid type of String, should be Int"
        
        //load it in
        let completedContestInstance: CompletedContest? = CompletedContest(data: mockData, playerUid: testUID)
        
        //assert
        XCTAssertNil(completedContestInstance, "Assert nill for unit test numBets failed.")
    }
    
    func test_completedContest_contestResults_player_keyValues_misspelled() throws {
        
        //change something in mock data
        mockData.removeValue(forKey: "contestResults")
        mockData["contestResults"] = [
            "player3": "WON",
            "player2": "LOST"
         ]
        
        //load it in
        let completedContestInstance: CompletedContest? = CompletedContest(data: mockData, playerUid: testUID)
        
        //assert
        XCTAssertNil(completedContestInstance, "Assert nil for contestResults player1 key misspelled failed.")
    }
    
    //games as empty dictionary
    func test_completedContest_empty_games_dictionary() throws {
        
        //change something in mock data
        mockData.removeValue(forKey: "games")
        mockData["games"] = []
        
        //load it in
        let completedContestInstance: CompletedContest? = CompletedContest(data: mockData, playerUid: testUID)
        
        //assert
        XCTAssertNotNil(completedContestInstance, "Assert not nil for empty games dictionary failed.")
    }
    
    //add games from CompletedContestGame UnitTests.swift //space for readability
    
    
    //
    /*
     "contestResults": [
        "player1": "WON",
        "player2": "LOST"
     ],
     */
}
