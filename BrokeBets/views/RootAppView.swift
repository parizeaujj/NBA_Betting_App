//
//  ContentView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/5/21.
//

import SwiftUI
import FirebaseFirestore

struct RootAppView<T: AppStateProtocol>: View {
    
    @StateObject var rootAppVM: RootAppVM<T>
    
    var body: some View {
        

        if rootAppVM.isLoggedIn {
            
            if rootAppVM.doesHaveUsername {
                
                MainAppView<T>()
             
            }
            else{
                CreateUsernameView(viewModel: CreateUsernameVM(userService: rootAppVM.appState.userService))
            }
        }
        else{
            LoginView<T>()
           
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootAppView<MockAppState>(rootAppVM: RootAppVM(appState: MockAppState()))
            .environmentObject(UserScreenInfo(.regular))
            .environmentObject(MockAppState())
    }
}

