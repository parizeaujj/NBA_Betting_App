//
//  UserScreenInfoV2.current.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/14/21.
//

import Foundation
import SwiftUI

enum ScreenSizeType{
    case xsmall
    case small
    case regular
}


class UserScreenInfo: ObservableObject {
    
    let screenSizeType: ScreenSizeType
    
    let completedContestViewStyleBag: CompletedContestViewStyleBag
    let completedContestGameViewStyleBag: CompletedContestGameViewStyleBag
    
    let inProgressContestViewStyleBag: InProgressContestViewStyleBag
    let inProgressContestGameViewStyleBag: InProgressContestGameViewStyleBag
    
    let upcomingContestGameViewStyleBag: UpcomingContestGameViewStyleBag
    
    let gamesListViewFonts: (oppTitleFont: Font, numBetsTitleFont: Font, oppNameFont: Font, numBetsValueFont: Font)

    
    init(_ screenSizeType: ScreenSizeType){
        self.screenSizeType = screenSizeType
        
        switch(screenSizeType){
            case .xsmall:
                self.upcomingContestGameViewStyleBag = UpcomingContestGameViewStyleBag(mainFontType: .subheadline, secondaryFontType: .caption2, leadingTeamsBoxPadding: 9, betsColFrameWidth: 90)
                self.inProgressContestViewStyleBag = InProgressContestViewStyleBag(boxScoreColHPaddings: (5, 5, 10), mainFontType: .subheadline)
                self.inProgressContestGameViewStyleBag = InProgressContestGameViewStyleBag(mainFontType: .caption, secondaryFontType: .caption2, paddings: (9, 10), betsColFrameWidth: 90)
                self.completedContestViewStyleBag = CompletedContestViewStyleBag(boxScoreColHPaddings: (5, 5, 10), mainFontType: .subheadline)
                self.completedContestGameViewStyleBag = CompletedContestGameViewStyleBag(mainFontType: .caption, secondaryFontType: .caption2, paddings: (9, 10), betsColFrameWidth: 70, resultsColFrameWidth: 60)
                    // 9 10 30 10
                self.gamesListViewFonts = (oppTitleFont: .subheadline, numBetsTitleFont: .subheadline, oppNameFont: .subheadline, numBetsValueFont: .subheadline)
        
            case .small:
                self.upcomingContestGameViewStyleBag = UpcomingContestGameViewStyleBag(mainFontType: .subheadline, secondaryFontType: .caption2, leadingTeamsBoxPadding: 10, betsColFrameWidth: 107)
                self.inProgressContestViewStyleBag = InProgressContestViewStyleBag(boxScoreColHPaddings: (nil, nil, nil), mainFontType: .subheadline)
                self.inProgressContestGameViewStyleBag = InProgressContestGameViewStyleBag(mainFontType: .subheadline, secondaryFontType: .caption, paddings: (10, 15), betsColFrameWidth: 107) // 87
                self.completedContestViewStyleBag = CompletedContestViewStyleBag(boxScoreColHPaddings: (nil, nil, nil), mainFontType: .subheadline)
                self.completedContestGameViewStyleBag = CompletedContestGameViewStyleBag(mainFontType: .subheadline, secondaryFontType: .caption, paddings: (10, 15), betsColFrameWidth: 75, resultsColFrameWidth: 65)
                
                self.gamesListViewFonts = (oppTitleFont: .body, numBetsTitleFont: .body, oppNameFont: .headline, numBetsValueFont: .headline)                    // 10 15 30 10
            case .regular:
                self.upcomingContestGameViewStyleBag = UpcomingContestGameViewStyleBag()
                self.inProgressContestViewStyleBag = InProgressContestViewStyleBag()
                self.inProgressContestGameViewStyleBag = InProgressContestGameViewStyleBag()
                self.completedContestViewStyleBag = CompletedContestViewStyleBag()
                self.completedContestGameViewStyleBag = CompletedContestGameViewStyleBag()
                self.gamesListViewFonts = (oppTitleFont: .title3, numBetsTitleFont: .title3, oppNameFont: .title3, numBetsValueFont: .title3)
            
        }
    }
}


// PROPOSED - completedCGVSB:  small and regular (87,-  => 75,65), small mainFontType .callout => .subheadline
// xsmall (80,-) => (70, 60)


class UserScreenInfoV2 {
    
    
    static let current = UserScreenInfoV2()
    
     let screenSizeType: ScreenSizeType
    
     let completedContestViewStyleBag: CompletedContestViewStyleBag!
     let completedContestGameViewStyleBag: CompletedContestGameViewStyleBag!
    
     let inProgressContestViewStyleBag: InProgressContestViewStyleBag!
     let inProgressContestGameViewStyleBag: InProgressContestGameViewStyleBag!
    
     let upcomingContestGameViewStyleBag: UpcomingContestGameViewStyleBag!
    
     let gamesListViewFonts: (oppTitleFont: Font, numBetsTitleFont: Font, oppNameFont: Font, numBetsValueFont: Font)!
    
    
    
    private init(){
        
        let screenSizeType = UserScreenInfoV2.getScreenSizeType()
        
        self.screenSizeType = screenSizeType
        
        switch(screenSizeType){
            case .xsmall:
                self.upcomingContestGameViewStyleBag = UpcomingContestGameViewStyleBag(mainFontType: .subheadline, secondaryFontType: .caption2, leadingTeamsBoxPadding: 9, betsColFrameWidth: 90)
                self.inProgressContestViewStyleBag = InProgressContestViewStyleBag(boxScoreColHPaddings: (5, 5, 10), mainFontType: .subheadline)
                self.inProgressContestGameViewStyleBag = InProgressContestGameViewStyleBag(mainFontType: .caption, secondaryFontType: .caption2, paddings: (9, 10), betsColFrameWidth: 90)
                self.completedContestViewStyleBag = CompletedContestViewStyleBag(boxScoreColHPaddings: (5, 5, 10), mainFontType: .subheadline)
                self.completedContestGameViewStyleBag = CompletedContestGameViewStyleBag(mainFontType: .caption, secondaryFontType: .caption2, paddings: (9, 10), betsColFrameWidth: 70, resultsColFrameWidth: 60)
                    // 9 10 30 10
                self.gamesListViewFonts = (oppTitleFont: .subheadline, numBetsTitleFont: .subheadline, oppNameFont: .subheadline, numBetsValueFont: .subheadline)
        
            case .small:
                self.upcomingContestGameViewStyleBag = UpcomingContestGameViewStyleBag(mainFontType: .subheadline, secondaryFontType: .caption2, leadingTeamsBoxPadding: 10, betsColFrameWidth: 107)
                self.inProgressContestViewStyleBag = InProgressContestViewStyleBag(boxScoreColHPaddings: (nil, nil, nil), mainFontType: .subheadline)
                self.inProgressContestGameViewStyleBag = InProgressContestGameViewStyleBag(mainFontType: .subheadline, secondaryFontType: .caption, paddings: (10, 15), betsColFrameWidth: 107) // 87
                self.completedContestViewStyleBag = CompletedContestViewStyleBag(boxScoreColHPaddings: (nil, nil, nil), mainFontType: .subheadline)
                self.completedContestGameViewStyleBag = CompletedContestGameViewStyleBag(mainFontType: .subheadline, secondaryFontType: .caption, paddings: (10, 15), betsColFrameWidth: 75, resultsColFrameWidth: 65)
                
                self.gamesListViewFonts = (oppTitleFont: .body, numBetsTitleFont: .body, oppNameFont: .headline, numBetsValueFont: .headline)                    // 10 15 30 10
            case .regular:
                self.upcomingContestGameViewStyleBag = UpcomingContestGameViewStyleBag()
                self.inProgressContestViewStyleBag = InProgressContestViewStyleBag()
                self.inProgressContestGameViewStyleBag = InProgressContestGameViewStyleBag()
                self.completedContestViewStyleBag = CompletedContestViewStyleBag()
                self.completedContestGameViewStyleBag = CompletedContestGameViewStyleBag()
                self.gamesListViewFonts = (oppTitleFont: .title3, numBetsTitleFont: .title3, oppNameFont: .title3, numBetsValueFont: .title3)
        
        }
    }
    
    
    
     static func getScreenSizeType() -> ScreenSizeType {

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
