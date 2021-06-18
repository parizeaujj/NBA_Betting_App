//
//  MainAppView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/13/21.
//

import SwiftUI

import Combine

class MainAppVM<T: AppStateProtocol>: ObservableObject {

    @Published var badgeValues: [String?] = [nil, nil, nil]

    @Published var selectedTab: Int = 0
    
    @Published var tab: Int = 0
    
    var appState: T
    
    private var cancellables: [AnyCancellable] = []
    
    init(appState: T){
        self.appState = appState
        
        listenForBadgeValueChanges()
        
        
        self.appState.selectedMainTabPublisher.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
        .store(in: &cancellables)
        
    }
    
    
    func listenForBadgeValueChanges(){
        
        self.getBadgeValuesPublisher()?.sink { [weak self] badgeValues in
            
//            if ((self?.appState.doesHavePermissionForAppIconBadge) != nil) {
//
                let total = badgeValues.reduce(0, { $0 + $1})
                UIApplication.shared.applicationIconBadgeNumber = total

//            }
            
            self?.badgeValues = badgeValues.map { $0.toStringReplacingZeroWithNil() }
        }
        .store(in: &cancellables)
       
    }
    
    func getBadgeValuesPublisher() -> AnyPublisher<[Int], Never>? {
        
        guard
            let recInvPub = self.appState.receivedInvitationsRepo?.receivedInvitationsPublisher,
            let draftsPub = self.appState.draftsRepo?.draftsPublisher
            else {
            
            return nil
        }
        
        return Publishers.CombineLatest(recInvPub, draftsPub)
            .map { recInvs, drafts in
                
                
                let numUserTurnDrafts = drafts.values.filter { $0.isUserTurn }
                
                return [0, recInvs.count, numUserTurnDrafts.count]
                
            }
            .eraseToAnyPublisher()
        
    }
}

extension Int {
    
    func toStringReplacingZeroWithNil() -> String?{
        
        if self == 0 {
            return nil
        }
        
        return "\(self)"
    }
}

//

struct MainAppView<T: AppStateProtocol>: View {
    
    @StateObject var mainAppVM: MainAppVM<T>
    
//    @EnvironmentObject var appState: T
    
    
//    @State var selectedTab = 0
    @State var isShowingProfileModal = false
        // selectedIndex: $selectedTab,
    var body: some View {
        // self.$mainAppVM.appState.selectedMainTab
        ZStack {
            UIKitTabView(selectedIndex: self.$mainAppVM.appState.selectedMainTab, badgeValues: self.$mainAppVM.badgeValues) {
       
                ContestsView<T>(appState: mainAppVM.appState, contestsVM: ContestsVM(appState: mainAppVM.appState),isShowingProfileModal: $isShowingProfileModal)
                    .tab(title: "Contests", image: "outline-emoji_events-black-24dp", selectedImage: "emoji_events-black-24dp")
                
//                Text("Betslip Screen").tab(title: "Betslip", image: "outline-receipt_long-black-24dp", selectedImage: "receipt_long-black-24dp")
                
                InvitationsView<T>(appState: mainAppVM.appState, invitationsVM: InvitationsVM(appState: mainAppVM.appState), isShowingProfileModal: $isShowingProfileModal)
                    .tab(title: "Invitations", image: "tray", selectedImage: "tray.fill")
                
                DraftsListView<T>(draftsListVM: DraftsListVM(draftsRepo: mainAppVM.appState.draftsRepo!), isShowingProfileModal: $isShowingProfileModal)
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
        
        MainAppView<MockAppState>(mainAppVM: MainAppVM(appState: appState))
//            .environmentObject(UserScreenInfo(.regular))
            .environmentObject(appState)
    }
}

