//
//  RecievedInvitationsListView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/16/21.
//

import SwiftUI

struct ReceivedInvitationsListView: View {
    
    @StateObject var receivedInvitationsListVM: ReceivedInvitationsListVM
    
    var body: some View {
        
        VStack{
            ScrollView{
                
                LazyVStack(spacing: 0){
                    
                    Rectangle().frame(width: nil, height: 1.0, alignment: .bottom).foregroundColor(Color.gray)
                    
                    ForEach(receivedInvitationsListVM.receivedInvitations){ invitation in
                        
                        
                        ReceivedInvitationView(invitation: invitation)
                            .padding(.vertical, 18)
                        
                        Rectangle().frame(width: nil, height: 1.0, alignment: .bottom).foregroundColor(Color.gray)
                        
                    }
                }
            }
            Spacer()
        }
    }
}

struct ReceivedInvitationsListView_Previews: PreviewProvider {
    static var previews: some View {
        ReceivedInvitationsListView(receivedInvitationsListVM: ReceivedInvitationsListVM(receivedInvitationsRepo: MockReceivedInvitationsRepository(uid: "testToddUid")))
    }
}
