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
        
    let appState = AppState()
    
    
    var body: some Scene {
        WindowGroup {
            RootAppView(rootAppVM: RootAppVM(appState: appState))
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
