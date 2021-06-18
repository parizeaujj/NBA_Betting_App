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
        
        
        if(viewModel.completedContests.count > 0){
            
            ScrollView {
                LazyVStack {
                    
                    ForEach(viewModel.completedContests) { contest in
                            
                        CompletedContestView(completedContest: contest)
                            
                        }
                }
            }
            
            
        }
        else{
            
            Text("You have no Completed contests yet")
                .font(.title3)
                .padding(.top, 100)
            
        }
        
        
        
        
        
    }
}

struct CompletedContestsListView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedContestsListView(viewModel: CompletedContestsListVM(completedContestsRepo: MockCompletedContestsRepository(uid: "testToddUid"))
        )
//        .environmentObject(UserScreenInfo(.regular))
    }
}
