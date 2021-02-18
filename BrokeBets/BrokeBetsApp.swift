//
//  BrokeBetsApp.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/5/21.
//

import SwiftUI
import Firebase

@main
struct BrokeBetsApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelagate
    

    
    var body: some Scene {
        WindowGroup {
            
             
                ContentView()
                    .environmentObject(UserService())
                
            
//            if userService.isLoggedIn {
//                MainAppView()
//                    .environment(\.colorScheme, .light)
//                    .environmentObject(userService)
//            }
//            else {
//                LoginView()
//                    .environmentObject(userService)
//            }
        }
    }
}






class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("firebase connected")
        return true
    }
}
