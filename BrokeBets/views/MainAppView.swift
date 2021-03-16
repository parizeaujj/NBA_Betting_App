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
    @State var isShowingContestModal = false
    
    var body: some View {
        ZStack{
            UIKitTabView {
                ContestsView<T>(isShowingProfileModal: $isShowingContestModal).tab(title: "Contests", image: "outline-emoji_events-black-24dp", selectedImage: "emoji_events-black-24dp")
                Text("Betslip Screen").tab(title: "Betslip", image: "outline-receipt_long-black-24dp", selectedImage: "receipt_long-black-24dp")
                Text("Invitations Screen").tab(title: "Invitations", image: "tray", selectedImage: "tray.fill", badgeValue: "2")
                DraftsListView(draftsListVM: DraftsListVM(draftsRepo: appState.draftsRepo!), isShowingProfileModal: $isShowingContestModal)
                                .tab(title: "Drafts", image: "outline-assignment-black-24dp", selectedImage: "assignment-black-24dp")
                Text("Statistics Screen").tab(title: "Statistics", image: "outline-leaderboard-black-24dp", selectedImage: "leaderboard-black-24dp")
            }.accentColor(.black)
            
            if(isShowingContestModal){
                ProfileModalView<T>(isShowingProfileModal: $isShowingContestModal)
            }
        }
    }
}


struct MainAppView_Previews: PreviewProvider {
    static var previews: some View {
        MainAppView<MockAppState>()
            .environmentObject(UserScreenInfo(.regular))
            .environmentObject(UserService())
            .environmentObject(MockAppState())
    }
}
