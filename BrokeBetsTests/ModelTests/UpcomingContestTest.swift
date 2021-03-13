//
//  UpcomingContestTest.swift
//  BrokeBetsTests
//
//  Created by Aland Nguyen on 3/13/21.
//
import Foundation
import SwiftUI
import Firebase
import XCTest
@testable import BrokeBets


class UpcomingContestTest: XCTestCase {

    var testUID: String = "testToddUid"
    
    var mockData: [String: Any] =
            ["firstGameStartDateTime": Timestamp(date: Date()),
             "player1_uid": "testToddUid",
             "player1_uname": "todd123",
             "player2_uid": "testOppUid",
             "player2_uname": "testOpp",
             "numBets": 3,
             "games": [
                
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
                       ],
                        
                        // game 2
                        ["awayTeam": "GS Warriors",
                         "homeTeam": "NY Knicks",
                         "gameStartDateTime": Timestamp(date: Date()),
                         "spreadBet": [
                                "player1": "GS -3.5",
                                "player2": "NY +3.5"
                         ]
                        ]
                
                    ]
            ]
        
    // First test to test it is working correctly
    func test1() throws {
            
            //change something in mock data

            //load it in
            let upcomingContestInstance: UpcomingContest? = UpcomingContest(data: mockData, playerUid: testUID)
            
            //assert
            XCTAssertNotNil(upcomingContestInstance, "Assert Not nill for unit test X failed.")
        }
    
    func test_2() throws {
            
            //change something in mock data
            mockData["numBets"] = "3"
            //load it in
            let upcomingContestInstance: UpcomingContest? = UpcomingContest(data: mockData, playerUid: testUID)
            
            //assert
            XCTAssertNil(upcomingContestInstance, "Assert nill for unit test X failed.")
        }
    
    func test_3() throws {
            
            //change something in mock data
            mockData["player1_uid"] = 3
            //load it in
            let upcomingContestInstance: UpcomingContest? = UpcomingContest(data: mockData, playerUid: testUID)
            
            //assert
            XCTAssertNil(upcomingContestInstance, "Assert nill for unit test X failed.")
        }
    
    func test_4() throws {
            
            //change something in mock data
            mockData["player1_uname"] = 34512
            //load it in
            let upcomingContestInstance: UpcomingContest? = UpcomingContest(data: mockData, playerUid: testUID)
            
            //assert
            XCTAssertNil(upcomingContestInstance, "Assert nill for unit test X failed.")
        }
    
    func test_5() throws {
            
            //change something in mock data
            mockData["firstGameStartDateTime"] = "not_valid"
            //load it in
            let upcomingContestInstance: UpcomingContest? = UpcomingContest(data: mockData, playerUid: testUID)
            
            //assert
            XCTAssertNil(upcomingContestInstance, "Assert nill for unit test X failed.")
        }
    
    func test_6() throws {
            //change something in mock data
            mockData.removeValue(forKey: "player1_uname")
            
            //load it in
            let upcomingContestInstance: UpcomingContest? = UpcomingContest(data: mockData, playerUid: testUID)
            
            //assert
            XCTAssertNil(upcomingContestInstance, "Assert nill for unit test X failed.")
        }
    func test_7() throws {
            
            //change something in mock data
            mockData["player1_uname"] = nil
            //load it in
            let upcomingContestInstance: UpcomingContest? = UpcomingContest(data: mockData, playerUid: testUID)
            
            //assert
            XCTAssertNil(upcomingContestInstance, "Assert nill for unit test X failed.")
        }
    
    func test_8() throws {
            
            //change something in mock data
            mockData["player2_uname"] = "different_key"
            //load it in
            let upcomingContestInstance: UpcomingContest? = UpcomingContest(data: mockData, playerUid: testUID)
            
            //assert
            XCTAssertNotNil(upcomingContestInstance, "Assert not nill for unit test X failed.")
        }
    
    func test_9() throws {
            
            //change something in mock data
            mockData["games"] = "invalid"
            //load it in
            let upcomingContestInstance: UpcomingContest? = UpcomingContest(data: mockData, playerUid: testUID)
            
            //assert
            XCTAssertNil(upcomingContestInstance, "Assert nill for unit test X failed.")
        }
    
    func test_10() throws {
            
            //change something in mock data
            testUID = "invalid"
            //load it in
            let upcomingContestInstance: UpcomingContest? = UpcomingContest(data: mockData, playerUid: testUID)
            
            //assert
            XCTAssertNil(upcomingContestInstance, "Assert nill for unit test X failed.")
        }
    
//    func test_10() throws {
//
//            //change something in mock data
//            testUID = "invalid"
//            //load it in
//            let upcomingContestInstance: UpcomingContest? = UpcomingContest(data: mockData, playerUid: testUID)
//
//            //assert
//            XCTAssertNil(upcomingContestInstance, "Assert nill for unit test X failed.")
//        }


}
