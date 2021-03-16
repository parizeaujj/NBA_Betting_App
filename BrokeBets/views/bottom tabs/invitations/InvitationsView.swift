//
//  Invitations.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/16/21.
//

import SwiftUI

struct InvitationsView<T: AppStateProtocol>: View {
    
    @EnvironmentObject var appState: T
    @State private var selectedTab = 0
    @State private var isCreateContestSheetPresented = false
    @Binding var isShowingProfileModal: Bool
    
    var body: some View {
        
        NavigationView{
            VStack(spacing: 0){
            
            Tabs(tabs: .constant(["Recieved", "Sent"]),
                       selection: $selectedTab,
                       underlineColor: .white) { title, isSelected in
                         Text(title)
                           .font(.headline)
                           .fontWeight(.semibold)
                           .foregroundColor(isSelected ? .white : .white)
                           .padding(.bottom, 10)
                           .frame(width: UIScreen.main.bounds.size.width / 2)
                            
            }
            .frame(maxWidth: .infinity).padding(.top, 15).background(Color(UIColor.systemBlue))
            
            
            if(selectedTab == 0){
            
                ReceivedInvitationsListView(receivedInvitationsListVM: ReceivedInvitationsListVM(receivedInvitationsRepo: appState.receivedInvitationsRepo!))
                
            }
            else{
                SentInvitationsListView(sentInvitationsListVM: SentInvitationsListVM(sentInvitationsRepo: appState.sentInvitationsRepo!))
                
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
        .fullScreenCover(isPresented: $isCreateContestSheetPresented, content: CreateContestView.init)
        .preferredColorScheme(.light)
    }
}

struct InvitationsView_Previews: PreviewProvider {
    static var previews: some View {
        InvitationsView<AppState>(isShowingProfileModal: .constant(false))
//            .environmentObject(MockAppState())
            .environmentObject(AppState(shouldByPassLogin: true))
    }
}
