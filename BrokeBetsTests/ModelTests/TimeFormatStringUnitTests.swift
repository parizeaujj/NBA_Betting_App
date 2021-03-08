//
//  TimeFormatStringUnitTest.swift
//  BrokeBetsTests
//
//  Created by Fabrizio Herrera on 3/7/21.
//

import XCTest

@testable import BrokeBets

class TimeFormatStringUnitTest: XCTestCase {
    
    func test_seconds_with_zero_after_decimal() throws {
        
        let mins = 4
        let secs = 45.0
        
        let sut = LiveGameScoreboard(homeTeam: "", awayTeam: "", timeLeftStr: "")
        
        let time_output = sut.getFormattedTimeLeft(mins: mins, secs: secs)
        
        XCTAssert("4:45" == time_output)
    }
    
    func test_seconds_with_nonzero_after_decimal() throws {
        
        let mins = 5
        let secs = 45.7
        
        let sut = LiveGameScoreboard(homeTeam: "", awayTeam: "", timeLeftStr: "")
        
        let time_output = sut.getFormattedTimeLeft(mins: mins, secs: secs)
        
        XCTAssert("5:45" == time_output)
    }
    
    func test_single_digit_seconds() throws {
        
        let mins = 12
        let secs = 4.0
        
        let sut = LiveGameScoreboard(homeTeam: "", awayTeam: "", timeLeftStr: "")
        
        let time_output = sut.getFormattedTimeLeft(mins: mins, secs: secs)
        
        XCTAssert("12:04" == time_output)
    }
    
    func test_zero_minutes_and_multi_digit_seconds_with_zero_after_decimal() throws {
        
        let mins = 0
        let secs = 36.0
        
        let sut = LiveGameScoreboard(homeTeam: "", awayTeam: "", timeLeftStr: "")
        
        let time_output = sut.getFormattedTimeLeft(mins: mins, secs: secs)
        
        XCTAssert("36.0" == time_output)
    }
    
    func test_zero_minuts_and_multi_seconds_with_nonzero_after_decial() throws {
        
        let mins = 0
        let secs = 25.6
        
        let sut = LiveGameScoreboard(homeTeam: "", awayTeam: "", timeLeftStr: "")
        
        let time_output = sut.getFormattedTimeLeft(mins: mins, secs: secs)
        
        XCTAssert("25.6" == time_output)
    }
    
    func test_zero_minutes_and_single_digit_seconds_with_nonzero_after_decimal() throws {
        
        let mins = 0
        let secs = 4.2

        let sut = LiveGameScoreboard(homeTeam: "", awayTeam: "", timeLeftStr: "")
        
        let time_output = sut.getFormattedTimeLeft(mins: mins, secs: secs)
        
        XCTAssert("4.2" == time_output)
    }
    
    func test_zero_minutes_and_seconds_with_multiple_digits_after_decimal() throws {
        
        let mins = 0
        let secs = 7.8669
        
        let sut = LiveGameScoreboard(homeTeam: "", awayTeam: "", timeLeftStr: "")
        
        let time_output = sut.getFormattedTimeLeft(mins: mins, secs: secs)
        
        XCTAssert("7.9" == time_output)
    }
    
    func test_nonzero_minutes_and_seconds_with_multiple_digits_after_decimal() throws {
        
        let mins = 1
        let secs = 7.8669
        
        let sut = LiveGameScoreboard(homeTeam: "", awayTeam: "", timeLeftStr: "")
        
        let time_output = sut.getFormattedTimeLeft(mins: mins, secs: secs)
        
        XCTAssert("1:08" == time_output)
    }
}

