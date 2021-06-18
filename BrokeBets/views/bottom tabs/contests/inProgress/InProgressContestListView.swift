//
//  InProgressContestListView.swift
//  BrokeBets
//
//  Created by JJ on 3/6/21.
//

import SwiftUI

struct InProgressContestsListView: View {
     
     @ObservedObject var viewModel: InProgressContestsListVM
      
     init(viewModel: InProgressContestsListVM){
         self.viewModel = viewModel
     }
     
     var body: some View {
         
        if viewModel.inProgressContests.count > 0 {
            
            ScrollView {
                LazyVStack {
                   
                   ForEach(viewModel.inProgressContests) { contest in
                        
                       InProgressContestView(inProgressContest: contest, inProgressContestsRepo: viewModel.inProgressContestsRepo)
                    }
                }
            }
            
            
        }
        else {
            
            Text("You have no In Progress contests")
                .font(.title3)
                .padding(.top, 100)
            
        }
     }
 }

 struct InProgressContestsListView_Previews: PreviewProvider {
     static var previews: some View {
         InProgressContestsListView(viewModel: InProgressContestsListVM(inProgressContestsRepo: MockInProgressContestsRepository(uid: "testToddUid"))
         )
//         .environmentObject(UserScreenInfo(.regular))
         .environmentObject(MockAppState())
     }
 }
 
