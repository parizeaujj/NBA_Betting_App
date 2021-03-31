//
//  Invitations.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/16/21.
//

import SwiftUI

class InvitationsVM<T: AppStateProtocol>: ObservableObject {
    
    let receivedInvitationsListVM: ReceivedInvitationsListVM
    let sentInvitationsListVM: SentInvitationsListVM
    
    let appState: T
    
    init(appState: T){
        
        self.appState = appState
        
        self.receivedInvitationsListVM = ReceivedInvitationsListVM(receivedInvitationsRepo: appState.receivedInvitationsRepo!)
        
        self.sentInvitationsListVM = SentInvitationsListVM(sentInvitationsRepo: appState.sentInvitationsRepo!)
        
    }
}

struct InvitationsView<T: AppStateProtocol>: View {
    
    
    @StateObject var invitationsVM: InvitationsVM<T>
    
    
//    @EnvironmentObject var appState: T
    @State private var selectedTab = 0
    @State private var isCreateContestSheetPresented = false
    @Binding var isShowingProfileModal: Bool
    
    var body: some View {
        
        NavigationView{
            VStack(spacing: 0){
            
            Tabs(tabs: .constant(["Received", "Sent"]),
                       selection: $selectedTab,
                       underlineColor: .white) { title, isSelected in
                         Text(title)
                           .font(.headline)
                           .fontWeight(isSelected ? .semibold : .regular)
                           .foregroundColor(isSelected ? .white : .white)
                           .padding(.bottom, 10)
                           .frame(width: UIScreen.main.bounds.size.width / 2)
                            
            }
            .frame(maxWidth: .infinity).padding(.top, 15).background(Color(UIColor.systemBlue))
            
            
            if(selectedTab == 0){
            
                ReceivedInvitationsListView(receivedInvitationsListVM: invitationsVM.receivedInvitationsListVM)
//                ReceivedInvitationsListView(receivedInvitationsListVM: ReceivedInvitationsListVM(receivedInvitationsRepo: appState.receivedInvitationsRepo!))
                
            }
            else{
                
                SentInvitationsListView(sentInvitationsListVM: invitationsVM.sentInvitationsListVM)
//                SentInvitationsListView(sentInvitationsListVM: SentInvitationsListVM(sentInvitationsRepo: appState.sentInvitationsRepo!))
//
            }
        
            Spacer()
        }
        .navigationBarTitle("Invitations", displayMode: .inline)
        .navigationBarItems(trailing:
                                
                                HStack{
                                    Button(action: {
                                        print("pressed")
                                        isCreateContestSheetPresented = true
                                    }, label: {
                                        Image(systemName: "plus.square")
                                            .font(Font.system(.title).bold())
                                    })
                                    .padding(.trailing, 10)
                                    
                                    Button(action: {
                                    
                                        withAnimation{
                                            isShowingProfileModal = true
                                        }
                                      
                                    }, label: {
                                        Image(systemName: "person.circle")
                                            .font(Font.system(.title).bold())
                                    })
                                }
        )
        }
        .accentColor(.white)
        .fullScreenCover(isPresented: $isCreateContestSheetPresented, content: { CreateContestView(createContestVM: CreateContestVM(createContestInvitationService: invitationsVM.appState.createContestInvitationService!, userService: invitationsVM.appState.userService)) })
        .preferredColorScheme(.light)
    }
}

struct InvitationsView_Previews: PreviewProvider {
    static var previews: some View {
        
        let appState = MockAppState()
        
        InvitationsView(invitationsVM: InvitationsVM(appState: appState), isShowingProfileModal: .constant(false))
//            .environmentObject(appState)
    }
}
