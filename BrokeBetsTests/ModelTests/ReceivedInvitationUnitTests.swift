//
//  ReceivedInvitationUnitTests.swift
//  BrokeBetsTests
//
//  Created by JJ on 3/18/21.
//

import Foundation
import SwiftUI
import Firebase
import XCTest


@testable import BrokeBets
class ReceivedInvitationUnitTests: XCTestCase {
    
    //setup reusable variables like mock completed contests
    //variables will be reinitiallized automattically per test
    
    var playerUid: String = "testToddUid"
    
    var mockData: [String:Any] = [
        "invitationId": "invitationId1",
        "invitor_uid": "testUID1",
        "invitor_uname": "testUnameInvitor",
        "recipient_uid": "testUnameRecipient",
        "recipient_uname": "recpientUsername",
        "invitationStatus": "pending",
        "expirationDateTime": Timestamp(date: Date()),
        "draftRounds": 10,
        "games_pool": []
    ]
    
    func test_draft_formatted_correctly() throws {
        
        //change something in mock data
        //control test -where nothing is changed
        
        //load it in
        let receivedInvitationInstance: ReceivedInvitation? = ReceivedInvitation(data: mockData)
        
        //assert
        XCTAssertNotNil(receivedInvitationInstance, "Assert Not nil for unit test \"test_draft_formatted_correctly\" failed.")
    }
    
    func test_draft_missing_invitationId() throws {
        
        //change something in mock data
        mockData.removeValue(forKey: "invitationId")
        
        //load it in
        let receivedInvitationInstance: ReceivedInvitation? = ReceivedInvitation(data: mockData)
        
        //assert
        XCTAssertNil(receivedInvitationInstance, "Assert nil for unit test missing_invitationId failed.")
    }
    
    func test_draft_invalid_type_draftRounds() throws {
        
        //change something in mock data
        mockData["draftRounds"] = "invalid type"
        
        //load it in
        let receivedInvitationInstance: ReceivedInvitation? = ReceivedInvitation(data: mockData)
        
        //assert
        XCTAssertNil(receivedInvitationInstance, "Assert nil for unit test invalid_type_draftRounds failed.")
    }
    
    func test_draft_invalid_type_invitationId() throws {
        
        //change something in mock data
        mockData["invitationId"] = 999
        
        //load it in
        let receivedInvitationInstance: ReceivedInvitation? = ReceivedInvitation(data: mockData)
        
        //assert
        XCTAssertNil(receivedInvitationInstance, "Assert nil for unit test invalid_type_invitationId failed.")
    }
    
    func test_draft_nil_value_for_invitor_uid() throws {
        
        //change something in mock data
        mockData["invitor_uid"] = nil
        
        //load it in
        let receivedInvitationInstance: ReceivedInvitation? = ReceivedInvitation(data: mockData)
        
        //assert
        XCTAssertNil(receivedInvitationInstance, "Assert nil for unit test nil_value_for_invitor_uid failed.")
    }
    
    func test_draft_expirationDateTime_as_date() throws {
        
        //change something in mock data
        mockData["expirationDateTime"] = Date()
        
        //load it in
        let receivedInvitationInstance: ReceivedInvitation? = ReceivedInvitation(data: mockData)
        
        //assert
        XCTAssertNil(receivedInvitationInstance, "Assert nil for unit test expirationDateTime_as_date failed.")
    }
    
}
