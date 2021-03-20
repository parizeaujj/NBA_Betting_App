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
                ScrollView{
                    
                    LazyVStack(spacing: 0){
                        
                        Rectangle().frame(width: nil, height: 1.0, alignment: .bottom).foregroundColor(Color.gray)
                        
                        ForEach(receivedInvitationsListVM.receivedInvitations){ invitation in
                            
                            Group {
                            ReceivedInvitationView(invitation: invitation, onInvitationAction: {
                                invitationAction in
                                //                            self.invitationAction = invitationAction
                                //                            self.didAcceptOrDeclineInvitation = true
                                self.alertType = .confirm(invitationAction)
                                self.showAlert = true
                            })
                            .padding(.vertical, 18)
                            
                            
                            Rectangle().frame(width: nil, height: 1.0, alignment: .bottom).foregroundColor(Color.gray)
                            
                            }
                          
//                            .transition(AnyTransition.asymmetric(insertion: .opacity, removal: AnyTransition.opacity.combined(with: AnyTransition.move(edge: .top)).animation(Animation.easeOut(duration: 0.5))))
                           
//                            .animation(Animation.easeOut.delay(0.5))
                        }
                        
//                        .animation(Animation.easeInOut.delay(0.6))
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
//                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
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
