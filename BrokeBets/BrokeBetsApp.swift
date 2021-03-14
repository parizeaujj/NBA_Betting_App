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
    
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelagate
    
    var appState: AppState
    
    init(){
        FirebaseApp.configure()
        
        self.appState = AppState()
        
    }
    
    var body: some Scene {
        WindowGroup {
                RootAppView<AppState>(rootAppVM: RootAppVM(appState: appState))
                    .environmentObject(appState)
                    .environmentObject(UserScreenInfo(getScreenSizeType()))
                    .environment(\.colorScheme, .light)
                    .preferredColorScheme(.light)
                    
        }
    }
    
    func getScreenSizeType() -> ScreenSizeType {

        switch(UIDevice.current.name.trimmingCharacters(in: .whitespacesAndNewlines)){

        case "iPhone 6s": return .small
        case "iPhone SE (1st Generation)": return .xsmall
        case "iPhone SE (2nd Generation)": return .small
        case "iPhone 7": return .small
        case "iPhone 8": return .small
        case "iPod touch (7th Generation)": return .xsmall
        default: return .regular
        }
    }
}



//class AppDelegate: NSObject, UIApplicationDelegate {
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        FirebaseApp.configure()
//        print("firebase connected")
//        return true
//    }
//}
