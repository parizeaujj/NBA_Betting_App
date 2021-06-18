//
//  UpcomingContestsListView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/13/21.
//

import SwiftUI

struct UpcomingContestsListView : View {
    
    
    @ObservedObject var viewModel: UpcomingContestsListVM
    
    
    init(viewModel: UpcomingContestsListVM){
        self.viewModel = viewModel
    }
    
    
    var body: some View {
        
        if viewModel.upcomingContests.count > 0 {
            ScrollView {
                LazyVStack {
                    
                    ForEach(viewModel.upcomingContests) { contest in
                            
                        UpcomingContestView(upcomingContest: contest)
                            
                        }
                        .buttonStyle(PlainButtonStyle())
                }
            }
            
        }
        else {
            
            Text("You have no Upcoming contests")
                .font(.title3)
                .padding(.top, 100)
            
        }
        
        
    }
}


struct UpcomingContestsListView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingContestsListView(viewModel: UpcomingContestsListVM(upcomingContestsRepo: MockUpcomingContestsRepository(uid: "testToddUid")
        )
        )
//        .environmentObject(UserScreenInfo(.regular))
    }
}
