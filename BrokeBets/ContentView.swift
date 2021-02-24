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
        
        if userService.isLoggedIn {

            if(userService.doesHaveUsername){
                MainAppView()
                    .environmentObject(userService)
            }
            else{
                CreateUsernameView(viewModel: CreateUsernameVM(userService: userService))
            }
        }
        
        else {
            LoginView()
                .environmentObject(userService)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserService())
    }
}

