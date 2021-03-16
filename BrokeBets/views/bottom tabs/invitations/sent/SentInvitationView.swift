//
//  SentInvitationView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/16/21.
//

import SwiftUI

struct SentInvitationView: View {
    
    var invitation: SentInvitation
    
    var body: some View {
        
        HStack(spacing: 0){
            
            VStack(alignment: .leading, spacing: 18){
                
                HStack(spacing: 0){
                    Text("To:")
                        .font(.footnote)
                        .padding(.trailing, 5)
                    Text("\(invitation.recipient_uname)")
                        .font(.body)
                        .foregroundColor(.blue)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                }
                
                HStack(spacing: 0){
                    Text("Draft Rounds:")
                        .font(.footnote)
                        .padding(.trailing, 5)
                    Text("\(invitation.draftRounds)")
                        .fontWeight(.bold)
                        .font(.subheadline)
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 0){
                
                HStack(alignment: .top, spacing: 0){
                    Text("Status:")
                        .font(.subheadline)
                        .padding(.trailing, 5)
                    Text("\(invitation.invitationStatus.rawValue)")
                        .fontWeight(.semibold)
                        .font(.subheadline)
                        .foregroundColor(invitation.invitationStatus == .pending ? Color.black: Color.red)
                
                }
                .padding(.top, 5)
                
                if invitation.invitationStatus == .pending {
                    Text("Expires: \(invitation.expirationDateTimeStr!)")
                        .font(.caption2)
                        .foregroundColor(Color(UIColor.darkGray))
                        .padding(.top, 24)
                        .padding(.trailing, 2)
                }
                else{
                    
                    Text("Rejected: \(invitation.rejectedDateTimeStr!)")
                        .font(.caption2)
                        .foregroundColor(Color(UIColor.darkGray))
                        .padding(.top, 24)
                        .padding(.trailing, 2)
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

struct SentInvitationView_Previews: PreviewProvider {
    static var previews: some View {
        SentInvitationView(invitation: SentInvitation(data: MockSentInvitationsRepository(uid: "testToddUid").mockData[0])!)
    }
}
