//
//  DateFormatStringUnitTests.swift
//  BrokeBetsTests
//
//  Created by Todd Weidler on 2/28/21.
//

import XCTest
@testable import BrokeBets

class DateFormatStringUnitTests: XCTestCase {


    func test_that_get_special_day_type_returns_none_if_date_is_more_than_one_day_prior_to_today() throws {
                
        let tZeroDateComponents = DateComponents(year: 2021, month: 2, day: 10)
        let tMinusTwoDateComponents = DateComponents(year: 2021, month: 2, day: 8)
        
        let tZeroDate = Calendar.current.date(from: tZeroDateComponents)!
        let tMinusTwoDate = Calendar.current.date(from: tMinusTwoDateComponents)!
                
        let specialDayType = tMinusTwoDate.getSpecialDayType(todaysSimpleDate: SimpleDate(date: tZeroDate))
        
        
        XCTAssertTrue(specialDayType == .None)
    }
    
    
    func test_that_get_special_day_type_returns_none_if_date_is_more_than_one_day_after_today() throws {
                
        let tZeroDateComponents = DateComponents(year: 2021, month: 2, day: 10)
        let tPlusTwoDateComponents = DateComponents(year: 2021, month: 2, day: 12)
        
        let tZeroDate = Calendar.current.date(from: tZeroDateComponents)!
        let tPlusTwoDate = Calendar.current.date(from: tPlusTwoDateComponents)!
                
        let specialDayType = tPlusTwoDate.getSpecialDayType(todaysSimpleDate: SimpleDate(date: tZeroDate))
        
        
        XCTAssertTrue(specialDayType == .None)
    }
    
    
    func test_that_get_special_day_type_returns_tomorrow_if_date_is_one_day_after_today() throws {
                
        let tZeroDateComponents = DateComponents(year: 2021, month: 2, day: 10)
        let tPlusOneDateComponents = DateComponents(year: 2021, month: 2, day: 11)
        
        let tZeroDate = Calendar.current.date(from: tZeroDateComponents)!
        let tPlusOneDate = Calendar.current.date(from: tPlusOneDateComponents)!
                
        let specialDayType = tPlusOneDate.getSpecialDayType(todaysSimpleDate: SimpleDate(date: tZeroDate))
        
        
        XCTAssertTrue(specialDayType == .Tomorrow)
    }
    
    
    func test_that_get_special_day_type_returns_yesterday_if_date_one_day_prior_to_today() throws {
                
        let tZeroDateComponents = DateComponents(year: 2021, month: 2, day: 10)
        let tMinusOneDateComponents = DateComponents(year: 2021, month: 2, day: 9)
        
        let tZeroDate = Calendar.current.date(from: tZeroDateComponents)!
        let tMinusOneDate = Calendar.current.date(from: tMinusOneDateComponents)!
                
        let specialDayType = tMinusOneDate.getSpecialDayType(todaysSimpleDate: SimpleDate(date: tZeroDate))
        
        
        XCTAssertTrue(specialDayType == .Yesterday)
    }
    
    
    func test_that_get_special_day_type_returns_today_if_date_is_the_current_date() throws {
                
        let specialDayType = Date().getSpecialDayType(todaysSimpleDate: SimpleDate(date: Date()))
        
        XCTAssertTrue(specialDayType == .Today)
    }
    

}
