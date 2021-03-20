//
//  SentinvitationTest.swift
//  BrokeBetsTests
//
//  Created by Aland Nguyen on 3/20/21.
//

import Foundation
import SwiftUI
import Firebase
import XCTest


@testable import BrokeBets
class SentInvitationUnitTests: XCTestCase { // change name later
    
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
        "draftRounds": 10
    ]
    
    
    func test_sent_invitation_formatted_correctly() throws {
        
        //change something in mock data
        //control test -where nothing is changed
        
        //load it in
        let sentInvitationInstance: SentInvitation? = SentInvitation(data: mockData)
        
        //assert
        XCTAssertNotNil(sentInvitationInstance, "Assert Not nil for unit test sent_invitation_formatted_correctly failed.")
    }
    
    func test_invalid_type_recipient_uname() throws {
        
        //change something in mock data
        mockData["recipient_uname"] = 999
        
        //load it in
        let sentInvitationInstance: SentInvitation? = SentInvitation(data: mockData)
        
        //assert
        XCTAssertNil(sentInvitationInstance, "Assert nil for unit test test_invalid_type_recipient_uname failed.")
    }
    
    func test_invalid_type_recipient_uid() throws {
        
        //change something in mock data
        mockData["recipient_uid"] = 999
        
        //load it in
        let sentInvitationInstance: SentInvitation? = SentInvitation(data: mockData)
        
        //assert
        XCTAssertNil(sentInvitationInstance, "Assert nil for unit test test_invalid_type_recipient_uid failed.")
    }
    
    func test_invalid_type_draft_rounds() throws {
        
        //change something in mock data
        mockData["draftRounds"] = "Not an int"
        
        //load it in
        let sentInvitationInstance: SentInvitation? = SentInvitation(data: mockData)
        
        //assert
        XCTAssertNil(sentInvitationInstance, "Assert nil for unit test invalid_type_draft_rounds failed.")
    }
    
    func test_invalid_type_invitation_status() throws {
        
        //change something in mock data
        mockData["invitationStatus"] = 999
        
        //load it in
        let sentInvitationInstance: SentInvitation? = SentInvitation(data: mockData)
        
        //assert
        XCTAssertNil(sentInvitationInstance, "Assert nil for unit test invalid_type_invitation_status failed.")
    }
    
    func test_removing_key_from_dictionary() throws {
        
        //change something in mock data
        mockData.removeValue(forKey: "invitationId")
        
        //load it in
        let sentInvitationInstance: SentInvitation? = SentInvitation(data: mockData)
        
        //assert
        XCTAssertNil(sentInvitationInstance, "Assert nil for unit test removing_key_from_dictionary failed.")
    }
    
    func test_invalid_date() throws {
        
        //change something in mock data
        mockData["expirationDateTime"] = Date()
        
        //load it in
        let sentInvitationInstance: SentInvitation? = SentInvitation(data: mockData)
        
        //assert
        XCTAssertNil(sentInvitationInstance, "Assert nil for unit test removing_key_from_dictionary failed.")
    }
    
    func test_sentInvitiation_replace_dictionary_with_misspelled() throws {
        
        //change something in mock data
        mockData.removeValue(forKey: "invitationStatus") //removeing and replacing
        mockData["invitationStatuss"] = "notPending" //changed invitationStatus to invitationStatuss
        
        //load it in
        let sentInvitationInstance: SentInvitation? = SentInvitation(data: mockData)
        
        //assert
        XCTAssertNil(sentInvitationInstance, "Assert nil for unit test removing_key_from_dictionary failed.")
    }
    
    func test_invalid_type_recipient_uname_nil() throws {
        
        //change something in mock data
        mockData["recipient_uname"] = nil
        
        //load it in
        let sentInvitationInstance: SentInvitation? = SentInvitation(data: mockData)
        
        //assert
        XCTAssertNil(sentInvitationInstance, "Assert nil for unit test test_invalid_type_recipient_uname_nil failed.")
    }
    
    func test_rejected_invitation_status() throws {
        
        //change something in mock data
        mockData["invitationStatus"] = "rejected"
        mockData["rejectedDateTime"] = Timestamp(date:Date())
        
        //load it in
        let sentInvitationInstance: SentInvitation? = SentInvitation(data: mockData)
        
        //assert
        XCTAssertNotNil(sentInvitationInstance, "Assert Not nil for unit test rejected_invitation_status failed.")
    }
    
    func test_rejected_invitation_invalid_type() throws {
        
        //change something in mock data
        mockData["invitationStatus"] = 999
        
        //load it in
        let sentInvitationInstance: SentInvitation? = SentInvitation(data: mockData)
        
        //assert
        XCTAssertNil(sentInvitationInstance, "Assert nil for unit test rejected_invitation_invalid_type failed.")
    }
}
