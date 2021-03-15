//
//  DraftRoundUnitTests.swift
//  BrokeBetsTests
//
//  Created by JJ on 3/14/21.
//

import Foundation
import SwiftUI
import Firebase
import XCTest

@testable import BrokeBets

class DraftRoundUnitTests: XCTestCase {
    
    //setup reusable variables like mock completed contests
    //variables will be reinitiallized automattically per test
    
    var mockRoundNumber: Int = 1
    var mockDataDrafted: [String:Any]? = [
            "round": 1,
            "gameId": "gameid1",
            "betType": "spread",
            "betInfo": "CLE +4",
            "betDisplayStr": "CLE +4 (vs HOU)"
        ]
    var mockDataForced: [String:Any]? = [
            "round": 1,
            "gameId": "gameid1",
            "betType": "spread",
            "betInfo": "CLE +4",
            "betDisplayStr": "CLE +4 (vs HOU)"
        ]
    
    func test_draftRound_formatted_correctly() throws {
        
        //change something in mock data
        //control test -where nothing is changed
        
        //load it in
        let draftRoundInstance: DraftRound? = DraftRound(round: mockRoundNumber, draftedPick: mockDataDrafted, forcedPick: mockDataForced)
        
        //assert
        XCTAssertNotNil(draftRoundInstance, "Assert Not nil for unit test \"test_draftRound_formatted_correctly\" failed.")
    }
    
    func test_draftRound_nil_drafted_and_forced() throws {
        
        //change something in mock data
        mockDataDrafted = nil
        mockDataForced = nil
        
        //load it in
        let draftRoundInstance: DraftRound? = DraftRound(round: mockRoundNumber, draftedPick: mockDataDrafted, forcedPick: mockDataForced)
        
        //assert
        XCTAssertNil(draftRoundInstance, "Assert nil for nil_drafted_and_forced failed.")
    }
    
    func test_draftRound_drafted_invalid_type() throws {
        
        //change something in mock data
        mockDataDrafted?["round"] = "INVALID TYPE. Expecting Int"
        
        //load it in
        let draftRoundInstance: DraftRound? = DraftRound(round: mockRoundNumber, draftedPick: mockDataDrafted, forcedPick: mockDataForced)
        
        //assert
        XCTAssertNil(draftRoundInstance, "Assert nil for drafted_invalid_type failed.")
    }
    
    func test_draftRound_forced_and_drafted_round_numbers_unmatching() throws {
        
        //change something in mock data
        mockDataDrafted?["round"] = 4
        mockDataForced?["round"] = -1
        
        //load it in
        let draftRoundInstance: DraftRound? = DraftRound(round: mockRoundNumber, draftedPick: mockDataDrafted, forcedPick: mockDataForced)
        
        //assert
        XCTAssertNil(draftRoundInstance, "Assert nil for forced_and_drafted_round_numbers_unmatching failed.")
    }
    
    func test_draftRound_forced_and_passed_round_numbers_unmatching() throws {
        
        //change something in mock data
        mockDataDrafted?["round"] = 29
        mockDataForced?["round"] = 29
        mockRoundNumber = 30
        
        //load it in
        let draftRoundInstance: DraftRound? = DraftRound(round: mockRoundNumber, draftedPick: mockDataDrafted, forcedPick: mockDataForced)
        
        //assert
        XCTAssertNil(draftRoundInstance, "Assert nil for forced_and_passed_round_numbers_unmatching failed.")
    }
    
    func test_draftRound_betDisplayStr_missing() throws {
        
        //change something in mock data
        mockDataDrafted?.removeValue(forKey: "betDisplayStr")
        
        //load it in
        let draftRoundInstance: DraftRound? = DraftRound(round: mockRoundNumber, draftedPick: mockDataDrafted, forcedPick: mockDataForced)
        
        //assert
        XCTAssertNil(draftRoundInstance, "Assert nil for betDisplayStr_missing failed.")
    }
    
}
