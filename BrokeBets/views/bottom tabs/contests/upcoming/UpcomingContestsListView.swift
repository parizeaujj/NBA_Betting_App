//
//  UpcomingContestsListView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/13/21.
//

import SwiftUI

struct UpcomingContestsListView : View {
    
    
    @ObservedObject var viewModel: UpcomingContestsListVM
    
    init(viewModel: UpcomingContestsListVM = UpcomingContestsListVM()){
        self.viewModel = viewModel
    }
    
    
    var body: some View {
        
        ScrollView {
            LazyVStack {
                
                ForEach(viewModel.upcomingContests) { contest in
                        
                    UpcomingContestView(upcomingContest: contest)
                        
                    }
                    .buttonStyle(PlainButtonStyle())
            }
        }
    }
}


struct UpcomingContestsListView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingContestsListView()
    }
}
