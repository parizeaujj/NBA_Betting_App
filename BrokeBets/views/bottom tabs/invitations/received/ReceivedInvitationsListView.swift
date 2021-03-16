//
//  RecievedInvitationsListView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/16/21.
//

import SwiftUI

enum InvitationActionType: String {
    case accepted = "Accept"
    case declined = "Decline"
}

struct InvitationAction {
    var action: InvitationActionType
    var invitation: ReceivedInvitation
}

struct ReceivedInvitationsListView: View {
    
    @StateObject var receivedInvitationsListVM: ReceivedInvitationsListVM
    
    @State private var didAcceptOrDeclineInvitation: Bool = false
    @State private var invitationAction: InvitationAction? = nil
    
    var body: some View {
        
        VStack{
            ScrollView{
                
                LazyVStack(spacing: 0){
                    
                    Rectangle().frame(width: nil, height: 1.0, alignment: .bottom).foregroundColor(Color.gray)
                    
                    ForEach(receivedInvitationsListVM.receivedInvitations){ invitation in
                        
                        ReceivedInvitationView(invitation: invitation, onInvitationAction: {
                            invitationAction in
                            self.invitationAction = invitationAction
                            self.didAcceptOrDeclineInvitation = true
                        })
                            .padding(.vertical, 18)
                        
                        Rectangle().frame(width: nil, height: 1.0, alignment: .bottom).foregroundColor(Color.gray)
                        
                    }
                }
            }
            Spacer()
        }
        .alert(isPresented: $didAcceptOrDeclineInvitation, content: {
            Alert(

                title: Text("\(invitationAction!.action.rawValue) Invitation"),
               message:
                Text("\nFrom: \(invitationAction!.invitation.invitor_uname)"),
               primaryButton:
                   .default(
                   Text("Confirm"),
                     action: {
                        
                        switch(invitationAction!.action){
                            case .accepted: break
                            case .declined: receivedInvitationsListVM.rejectInvitation(invitation: invitationAction!.invitation)
                        }
                        self.invitationAction = nil
                     }
               )
               ,
               secondaryButton:
                    .destructive(
                       Text("Cancel"), action: {
                            self.invitationAction = nil
                       }
               )
           )
        })
    }
}


struct ReceivedInvitationsListView_Previews: PreviewProvider {
    static var previews: some View {
        ReceivedInvitationsListView(receivedInvitationsListVM: ReceivedInvitationsListVM(receivedInvitationsRepo: MockReceivedInvitationsRepository(uid: "testToddUid")))
    }
}
