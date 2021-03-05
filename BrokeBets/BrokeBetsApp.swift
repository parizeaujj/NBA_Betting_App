//
//  BrokeBetsApp.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/5/21.
//

import SwiftUI
import Firebase


class UserScreenInfo: ObservableObject {
    
    let screenSizeType: ScreenSizeType
    
    let completedContestViewStyleBag: CompletedContestViewStyleBag
    let completedContestGameViewStyleBag: CompletedContestGameViewStyleBag
    
    let inProgressContestViewStyleBag: InProgressContestViewStyleBag
    let inProgressContestGameViewStyleBag: InProgressContestGameViewStyleBag

    
    init(_ screenSizeType: ScreenSizeType){
        self.screenSizeType = screenSizeType
        
        switch(screenSizeType){
            case .xsmall:
                self.inProgressContestViewStyleBag = InProgressContestViewStyleBag(boxScoreColHPaddings: (5, 5, 10), mainFontType: .subheadline)
                self.inProgressContestGameViewStyleBag = InProgressContestGameViewStyleBag(mainFontType: .caption, secondaryFontType: .caption2, paddings: (9, 10), betsColFrameWidth: 90)
                self.completedContestViewStyleBag = CompletedContestViewStyleBag(boxScoreColHPaddings: (5, 5, 10), mainFontType: .subheadline)
                self.completedContestGameViewStyleBag = CompletedContestGameViewStyleBag(mainFontType: .caption, secondaryFontType: .caption2, paddings: (9, 10), betsColFrameWidth: 80)
                    // 9 10 30 10
        
            case .small:
                self.inProgressContestViewStyleBag = InProgressContestViewStyleBag(boxScoreColHPaddings: (nil, nil, nil), mainFontType: .subheadline)
                self.inProgressContestGameViewStyleBag = InProgressContestGameViewStyleBag(mainFontType: .callout, secondaryFontType: .caption, paddings: (10, 15), betsColFrameWidth: 107) // 87
                self.completedContestViewStyleBag = CompletedContestViewStyleBag(boxScoreColHPaddings: (nil, nil, nil), mainFontType: .subheadline)
                self.completedContestGameViewStyleBag = CompletedContestGameViewStyleBag(mainFontType: .callout, secondaryFontType: .caption, paddings: (10, 15), betsColFrameWidth: 87)
                    // 10 15 30 10
            case .regular:
                self.inProgressContestViewStyleBag = InProgressContestViewStyleBag()
                self.inProgressContestGameViewStyleBag = InProgressContestGameViewStyleBag()
                self.completedContestViewStyleBag = CompletedContestViewStyleBag()
                self.completedContestGameViewStyleBag = CompletedContestGameViewStyleBag()
            
        }
    }
}

enum ScreenSizeType{
    case xsmall
    case small
    case regular
}

@main
struct BrokeBetsApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelagate
    
    
    var body: some Scene {
        WindowGroup {
                ContentView()
                    .environmentObject(UserService())
                    .environmentObject(UserScreenInfo(getScreenSizeType()))
                    .environment(\.colorScheme, .light)
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



class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("firebase connected")
        return true
    }
}
