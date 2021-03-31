//
//  SentInvitationsListView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/16/21.
//

import SwiftUI

struct SentInvitationsListView: View {
    
    @StateObject var sentInvitationsListVM: SentInvitationsListVM
    
    var body: some View {
        
        VStack{
            
            if sentInvitationsListVM.sentInvitations.count > 0 {
                
                ScrollView{
                    
                    LazyVStack(spacing: 0){
                        
                        Rectangle().frame(width: nil, height: 1.0, alignment: .bottom).foregroundColor(Color.gray)
                        
                        ForEach(sentInvitationsListVM.sentInvitations){ invitation in
                            
                            SentInvitationView(invitation: invitation)
                                .padding(.vertical, 18)
                               
                            
                            Rectangle().frame(width: nil, height: 1.0, alignment: .bottom).foregroundColor(Color.gray)
                            
                        }
                    }
                }
                
            }
            else {
                
                Text("You have not sent any invitations")
                    .font(.title3)
                    .padding(.top, 100)
                
            }
            
            
            
            
            Spacer()
        }
    }
}

struct SentInvitationsListView_Previews: PreviewProvider {
    static var previews: some View {
        SentInvitationsListView(sentInvitationsListVM: SentInvitationsListVM(sentInvitationsRepo: MockSentInvitationsRepository(uid: "testToddUid")))
    }
}
