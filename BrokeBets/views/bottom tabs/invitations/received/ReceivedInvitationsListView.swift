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

enum AlertType {
    case confirm(InvitationAction)
    case error(String)
}

struct InvitationAction {
    var action: InvitationActionType
    var invitation: ReceivedInvitation
}

struct ReceivedInvitationsListView: View {
    
    @StateObject var receivedInvitationsListVM: ReceivedInvitationsListVM
    
    @State private var showAlert: Bool = false
    @State private var alertType: AlertType = .error("")
    
    @State private var showError: Bool = false
    @State private var didAcceptOrDeclineInvitation: Bool = false
    @State private var invitationAction: InvitationAction? = nil
    
    var body: some View {
        
        ZStack{
            
            VStack{
                
                if receivedInvitationsListVM.receivedInvitations.count > 0 {
                    
                    ScrollView{
                        
                        LazyVStack(spacing: 0){
                            
                            Rectangle().frame(width: nil, height: 1.0, alignment: .bottom).foregroundColor(Color.gray)
                            
                            ForEach(receivedInvitationsListVM.receivedInvitations){ invitation in
                                
                                Group {
                                ReceivedInvitationView(invitation: invitation, onInvitationAction: {
                                    invitationAction in
                                   
                                    self.alertType = .confirm(invitationAction)
                                    self.showAlert = true
                                })
                                .padding(.vertical, 18)
                                
                                
                                Rectangle().frame(width: nil, height: 1.0, alignment: .bottom).foregroundColor(Color.gray)
                                
                                }
                            }
                        }
                    }
                   
                    
                }
                else {
                    
                    Text("You have no received invitations")
                        .font(.title3)
                        .padding(.top, 100)
                    
                }
                
                Spacer()
            }
            .alert(isPresented: $showAlert, content: {
                
                switch(alertType){
                case .confirm(let invitationAction):
                    
                    return Alert(
                        
                        title: Text("\(invitationAction.action.rawValue) Invitation"),
                        message:
                            Text("\nFrom: \(invitationAction.invitation.invitor_uname)"),
                        primaryButton:
                            .default(
                                Text("Confirm"),
                                action: {
                                    
                                    switch(invitationAction.action){
                                    case .accepted: receivedInvitationsListVM.acceptInvitation(invitation: invitationAction.invitation)
                                    case .declined: receivedInvitationsListVM.rejectInvitation(invitation: invitationAction.invitation)
                                    }
                                }
                            )
                        ,
                        secondaryButton:
                            .destructive(
                                Text("Cancel"))
                    )
                    
                case .error(let errorMessage):
                    return Alert(title: Text("Error"), message: Text("\(errorMessage)"), dismissButton: .default(Text("Ok")))
                    
                }
            })
            .onReceive(receivedInvitationsListVM.didHaveError, perform: { errorMessage in
                self.alertType = .error(errorMessage)
                self.showAlert = true
                
            })
            
            if receivedInvitationsListVM.isLoading {
                
                Color.gray.opacity(0.2)
                    .edgesIgnoringSafeArea(.all)

                ProgressView()
                    .scaleEffect(1.4, anchor: .center)
                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                
                
            }
            
        }
    }
}


struct ReceivedInvitationsListView_Previews: PreviewProvider {
    static var previews: some View {
        ReceivedInvitationsListView(receivedInvitationsListVM: ReceivedInvitationsListVM(receivedInvitationsRepo: MockReceivedInvitationsRepository(user: User(uid:"testToddUid", username: "testTodd123"))))
    }
}
