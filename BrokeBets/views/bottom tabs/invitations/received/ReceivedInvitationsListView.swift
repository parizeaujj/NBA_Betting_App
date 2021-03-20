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
    
    @State private var showError: Bool = false
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
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: AnyTransition.opacity.combined(with: AnyTransition.move(edge: .top)).animation(Animation.easeInOut(duration: 0.5).delay(0.0))))
                    .animation(Animation.easeInOut.delay(0.6))
//                    .transition(.move(edge: .bottom))
//                    .animation(.easeOut)
//                    .transition(AnyTransition.asymmetric(insertion: AnyTransition.move(edge: .top).combined(with: .opacity).animation(Animation.easeIn(duration: 0.4)),
//
//                                removal: AnyTransition.opacity.combined(with: AnyTransition.move(edge: .bottom)).animation(Animation.easeInOut(duration: 0.3).delay(0))))
//                    .animation(Animation.easeInOut(duration: 0.2))
//                    .animation(Animation.easeInOut(duration: 0.4).delay(0.6))
                }
            }
            Spacer()
        }
        .alert(isPresented: $showError, content: {

            Alert(title: Text("Error"), message: Text("Please try again"), dismissButton: .default(Text("Ok")))

        })
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
                            case .accepted: receivedInvitationsListVM.acceptInvitation(invitation: invitationAction!.invitation)
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
        .onReceive(receivedInvitationsListVM.didHaveError, perform: { _ in
            self.showError = true
        })
    }
}


struct ReceivedInvitationsListView_Previews: PreviewProvider {
    static var previews: some View {
        ReceivedInvitationsListView(receivedInvitationsListVM: ReceivedInvitationsListVM(receivedInvitationsRepo: MockReceivedInvitationsRepository(user: User(uid:"testToddUid", username: "testTodd123"))))
    }
}
