//
//  RecievedInvitationView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/16/21.
//

import SwiftUI

struct ReceivedInvitationView: View {
    
    var invitation: ReceivedInvitation
    
    var onInvitationAction: (InvitationAction) -> Void
    
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
                    AcceptButtonView(action: {
                        self.onInvitationAction(InvitationAction(action: .accepted, invitation: self.invitation))
                    })
                        .frame(minWidth: 86)
                
                    DeclineButtonView(action: {
                        self.onInvitationAction(InvitationAction(action: .declined, invitation: self.invitation))
                    })
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
        ReceivedInvitationView(invitation: ReceivedInvitation(data: MockReceivedInvitationsRepository(user: User(uid: "testToddUid", username: "testTodd123")).mockData[0])!, onInvitationAction: {_ in })
    }
}
