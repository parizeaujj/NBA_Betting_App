//
//  RecievedInvitationView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/16/21.
//

import SwiftUI

struct ReceivedInvitationView: View {
    
    var invitation: ReceivedInvitation
    
    var body: some View {
        
        HStack(spacing: 0){
            
            VStack(alignment: .leading, spacing: 18){
                
                HStack(spacing: 0){
                    Text("From:")
                        .font(.footnote)
                        .padding(.trailing, 5)
                    Text("\(invitation.invitor_uname)")
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
                
                HStack{
                    AcceptButtonView(action: {})
                        .frame(minWidth: 86)
                
                    DeclineButtonView(action: {})
                        .frame(minWidth: 86)
                }
                .padding(.top, 5)
                
                Text("Expires: \(invitation.expirationDateTimeStr)")
                    .foregroundColor(Color(UIColor.darkGray))
                    .font(.caption2)
                    .padding(.top)
                    .padding(.trailing, 2)
            }
        }
        .padding(.horizontal, 20)
    }
}


struct ReceivedInvitationView_Previews: PreviewProvider {
    static var previews: some View {
    ReceivedInvitationView(invitation: ReceivedInvitation(data: MockReceivedInvitationsRepository(uid: "testToddUid").mockData[0])!)
    }
}
