//
//  UserScreenInfo.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/14/21.
//

import Foundation


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

    
    init(_ screenSizeType: ScreenSizeType){
        self.screenSizeType = screenSizeType
        
        switch(screenSizeType){
            case .xsmall:
                self.upcomingContestGameViewStyleBag = UpcomingContestGameViewStyleBag(mainFontType: .subheadline, secondaryFontType: .caption2, leadingTeamsBoxPadding: 9, betsColFrameWidth: 90)
                self.inProgressContestViewStyleBag = InProgressContestViewStyleBag(boxScoreColHPaddings: (5, 5, 10), mainFontType: .subheadline)
                self.inProgressContestGameViewStyleBag = InProgressContestGameViewStyleBag(mainFontType: .caption, secondaryFontType: .caption2, paddings: (9, 10), betsColFrameWidth: 90)
                self.completedContestViewStyleBag = CompletedContestViewStyleBag(boxScoreColHPaddings: (5, 5, 10), mainFontType: .subheadline)
                self.completedContestGameViewStyleBag = CompletedContestGameViewStyleBag(mainFontType: .caption, secondaryFontType: .caption2, paddings: (9, 10), betsColFrameWidth: 80)
                    // 9 10 30 10
        
            case .small:
                self.upcomingContestGameViewStyleBag = UpcomingContestGameViewStyleBag(mainFontType: .subheadline, secondaryFontType: .caption2, leadingTeamsBoxPadding: 10, betsColFrameWidth: 107)
                self.inProgressContestViewStyleBag = InProgressContestViewStyleBag(boxScoreColHPaddings: (nil, nil, nil), mainFontType: .subheadline)
                self.inProgressContestGameViewStyleBag = InProgressContestGameViewStyleBag(mainFontType: .callout, secondaryFontType: .caption, paddings: (10, 15), betsColFrameWidth: 107) // 87
                self.completedContestViewStyleBag = CompletedContestViewStyleBag(boxScoreColHPaddings: (nil, nil, nil), mainFontType: .subheadline)
                self.completedContestGameViewStyleBag = CompletedContestGameViewStyleBag(mainFontType: .callout, secondaryFontType: .caption, paddings: (10, 15), betsColFrameWidth: 87)
                    // 10 15 30 10
            case .regular:
                self.upcomingContestGameViewStyleBag = UpcomingContestGameViewStyleBag()
                self.inProgressContestViewStyleBag = InProgressContestViewStyleBag()
                self.inProgressContestGameViewStyleBag = InProgressContestGameViewStyleBag()
                self.completedContestViewStyleBag = CompletedContestViewStyleBag()
                self.completedContestGameViewStyleBag = CompletedContestGameViewStyleBag()
            
        }
    }
}


