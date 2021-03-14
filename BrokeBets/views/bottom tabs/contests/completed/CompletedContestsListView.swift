//
//  CompletedContestsListView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/27/21.
//

import SwiftUI



struct CompletedContestsListView: View {
    
    @ObservedObject var viewModel: CompletedContestsListVM
     
    init(viewModel: CompletedContestsListVM){
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        ScrollView {
            LazyVStack {
                
                ForEach(viewModel.completedContests) { contest in
                        
                    CompletedContestView(completedContest: contest)
                        
                    }
            }
        }
    }
}

struct CompletedContestsListView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedContestsListView(viewModel: CompletedContestsListVM(completedContestsRepo: MockCompletedContestsRepository(uid: "testToddUid"))
        ).environmentObject(UserScreenInfo(.regular))
    }
}
