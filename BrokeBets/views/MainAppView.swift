//
//  MainAppView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/13/21.
//

import SwiftUI

struct MainAppView<T: AppStateProtocol>: View {
    
    @EnvironmentObject var appState: T
    @State var selectedTab = 0
    @State var isShowingProfileModal = false
    
    var body: some View {
        ZStack{
            UIKitTabView {
       
                ContestsView<T>(contestsVM: ContestsVM(appState: appState),isShowingProfileModal: $isShowingProfileModal)
//                ContestsView<T>(isShowingProfileModal: $isShowingProfileModal)
                    .tab(title: "Contests", image: "outline-emoji_events-black-24dp", selectedImage: "emoji_events-black-24dp")
//                Text("Betslip Screen").tab(title: "Betslip", image: "outline-receipt_long-black-24dp", selectedImage: "receipt_long-black-24dp")
                InvitationsView<T>(invitationsVM: InvitationsVM(appState: appState), isShowingProfileModal: $isShowingProfileModal)
                    .tab(title: "Invitations", image: "tray", selectedImage: "tray.fill")
                DraftsListView<T>(draftsListVM: DraftsListVM(draftsRepo: appState.draftsRepo!), isShowingProfileModal: $isShowingProfileModal)
                                .tab(title: "Drafts", image: "outline-assignment-black-24dp", selectedImage: "assignment-black-24dp")
//                Text("Statistics Screen").tab(title: "Statistics", image: "outline-leaderboard-black-24dp", selectedImage: "leaderboard-black-24dp")
            }
            .accentColor(.black)
            
            if(isShowingProfileModal){
                ProfileModalView<T>(isShowingProfileModal: $isShowingProfileModal)
            }
        }
    }
}


struct MainAppView_Previews: PreviewProvider {
    static var previews: some View {
        
        let appState = MockAppState()
        
        MainAppView<MockAppState>()
            .environmentObject(UserScreenInfo(.regular))
            .environmentObject(appState)
    }
}

struct MainAppView_Previews_2: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
