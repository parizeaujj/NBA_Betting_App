//
//  InProgressContestListView.swift
//  BrokeBets
//
//  Created by JJ on 3/6/21.
//

import Foundation
import SwiftUI


struct InProgressContestsListView: View {
    
    @ObservedObject var viewModel: InProgressContestsListVM
     
    init(viewModel: InProgressContestsListVM = InProgressContestsListVM()){
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        ScrollView {
            LazyVStack {
                
                let keys = viewModel.inProgressContests.map{$0.key}
                let values = viewModel.inProgressContests.map{$0.value}
                
                ForEach(keys.indices) { index in
                    
                    InProgressContestView(inProgressContest: values[index])
                }
            }
        }
    }
}

struct InProgressContestsListView_Previews: PreviewProvider {
    static var previews: some View {
        InProgressContestsListView(viewModel: InProgressContestsListVM(inProgressContestsRepo: MockInProgressContestsRepository())
        ).environmentObject(UserScreenInfo(.regular))
    }
}
