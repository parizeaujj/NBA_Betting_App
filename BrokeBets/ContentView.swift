//
//  ContentView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/5/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var userService : UserService
    
    
    var body: some View {
        
//        if userService.isLoggedIn {
//
//            if(userService.doesHaveUsername){
//                MainAppView()
//                    .environmentObject(userService)
//            }
//            else{
//                CreateUsernameView(viewModel: CreateUsernameVM(userService: userService))
//            }
//        }
//        else {
//            LoginView()
//                .environmentObject(userService)
//        }

        if true {

            if(true){
                DraftsListView(draftsListVM: DraftsListVM(draftsRepo: MockDraftsRepository()))
//                DraftView(draft: Draft(data: MockDraftsRepository().mockData[0], playerUid: "testToddUid", draftId: "draftid1")!)
//                MainAppView()
//                    .environmentObject(userService)
//                InProgressContestGamesListView(inProgressGamesListVM: InProgressContestGamesListVM(contestId: "contest1", inProgressContestRepo: MockInProgressContestsRepository()))
//                    .environmentObject(userService)
//                    .environmentObject(UserScreenInfo(.regular))
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserService())
            .environmentObject(UserScreenInfo(.regular))
    }
}

