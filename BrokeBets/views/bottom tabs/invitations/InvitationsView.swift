//
//  Invitations.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/16/21.
//

import SwiftUI

import Combine

class InvitationsVM<T: AppStateProtocol>: ObservableObject {
    
    @Published var selectedTab: Int = 0
    
    let receivedInvitationsListVM: ReceivedInvitationsListVM
    let sentInvitationsListVM: SentInvitationsListVM
    
    var appState: T
    
    var cancellables: [AnyCancellable] = []
    
    init(appState: T){
        
        self.appState = appState
        
        self.receivedInvitationsListVM = ReceivedInvitationsListVM(receivedInvitationsRepo: appState.receivedInvitationsRepo!)
        
        self.sentInvitationsListVM = SentInvitationsListVM(sentInvitationsRepo: appState.sentInvitationsRepo!)
        
        self.appState.selectedSubTabPublisher.sink { ind in
//            guard ind >= 0 && ind <= 1 else {
//                return
//            }
//
//            self.selectedTab = ind
            print("invitation sub tab changed")
        }
        .store(in: &cancellables)
        
    }
}

struct InvitationsView<T: AppStateProtocol>: View {
    
    @StateObject var appState: T
    @StateObject var invitationsVM: InvitationsVM<T>
    
    @State private var isCreateContestSheetPresented = false
    @Binding var isShowingProfileModal: Bool
    
    var body: some View {
        
        NavigationView{
            VStack(spacing: 0){
            
            Tabs(tabs: .constant(["Received", "Sent"]),
                 selection: self.$appState.selectedSubTabs[1],
                       underlineColor: .white) { title, isSelected in
                         Text(title)
                           .font(.headline)
                           .fontWeight(isSelected ? .semibold : .regular)
                           .foregroundColor(isSelected ? .white : .white)
                           .padding(.bottom, 10)
                           .frame(width: UIScreen.main.bounds.size.width / 2)
                            
            }
            .frame(maxWidth: .infinity).padding(.top, 15).background(Color(UIColor.systemBlue))
            
            
            if(self.appState.selectedSubTabs[1] == 0){
            
                if let repo = self.appState.receivedInvitationsRepo {
                    ReceivedInvitationsListView(receivedInvitationsListVM: ReceivedInvitationsListVM(receivedInvitationsRepo: repo))
                }
            }
            else if(self.appState.selectedSubTabs[1] == 1){
                
                if let repo = self.appState.sentInvitationsRepo {
                    SentInvitationsListView(sentInvitationsListVM: SentInvitationsListVM(sentInvitationsRepo: repo))
                }
                
//                SentInvitationsListView(sentInvitationsListVM: invitationsVM.sentInvitationsListVM)

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
        .fullScreenCover(isPresented: $isCreateContestSheetPresented, content: { CreateContestView(createContestVM: CreateContestVM(createContestInvitationService: invitationsVM.appState.createContestInvitationService!, userService: invitationsVM.appState.userService!)) })
        .preferredColorScheme(.light)
    }
}

struct InvitationsView_Previews: PreviewProvider {
    static var previews: some View {
        
        let appState = MockAppState()
        
        InvitationsView(appState: appState, invitationsVM: InvitationsVM(appState: appState), isShowingProfileModal: .constant(false))
//            .environmentObject(appState)
    }
}
