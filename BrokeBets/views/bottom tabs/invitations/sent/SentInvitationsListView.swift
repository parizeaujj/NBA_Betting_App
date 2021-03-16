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
            Spacer()
        }
    }
}

struct SentInvitationsListView_Previews: PreviewProvider {
    static var previews: some View {
        SentInvitationsListView(sentInvitationsListVM: SentInvitationsListVM(sentInvitationsRepo: MockSentInvitationsRepository(uid: "testToddUid")))
    }
}
