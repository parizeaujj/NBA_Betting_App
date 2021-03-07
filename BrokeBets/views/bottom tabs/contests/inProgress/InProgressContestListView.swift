//
//  InProgressContestListView.swift
//  BrokeBets
//
//  Created by JJ on 3/6/21.
//

import SwiftUI

 struct InProgressContestsListView: View {
     
     @ObservedObject var viewModel: InProgressContestsListVM
      
     init(viewModel: InProgressContestsListVM = InProgressContestsListVM()){
         self.viewModel = viewModel
     }
     
     var body: some View {
         
         ScrollView {
             LazyVStack {
                
                ForEach(viewModel.inProgressContests) { contest in
                     
                    InProgressContestView(inProgressContest: contest, inProgressContestsRepo: viewModel.inProgressContestsRepo)
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
 
