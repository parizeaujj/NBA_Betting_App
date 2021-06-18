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
//    @StateObject var userScreenInfo: UserScreenInfo
    @State private var shouldShowSplash: Bool = true
    
    var body: some View {
        
        if shouldShowSplash {
            
            SplashScreen()
                .onAppear(perform: {
                
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                        withAnimation(Animation.easeOut(duration: 0.3)) {
                            shouldShowSplash = false
                        }
                    }
                    
            })
        }
        else{
            
            if rootAppVM.appState.userService!.user != nil {
                
                if rootAppVM.appState.userService!.stillCheckingForUsername {
                    
                    if rootAppVM.appState.userService!.justLoggedIn {
                        LoadingView()
                    }
                    else {
                        SplashScreen()
                    }
                }
                else{
                    
                    if rootAppVM.appState.userService!.user!.username != nil {
                        
                        MainAppView<T>(mainAppVM: MainAppVM(appState: rootAppVM.appState))
                     
                    }
                    else{
                        CreateUsernameView(viewModel: CreateUsernameVM(userService: rootAppVM.appState.userService!))
                    }
                }
            }
            else{
                LoginView<T>()
               
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let appState = AppState(shouldByPassLogin: true)
        
        RootAppView(rootAppVM: RootAppVM(appState: appState))
//            .environmentObject(UserScreenInfo(.regular))
            .environmentObject(appState)
    }
}



