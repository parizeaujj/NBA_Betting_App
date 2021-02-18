//
//  UpcomingContestsListView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/13/21.
//

import SwiftUI

struct UpcomingContestsListView : View {
    
    var body: some View {
        
        ScrollView {
            LazyVStack {
                

                    ForEach(1...30, id: \.self) { value in
                        
                        NavigationLink(destination: Text("Detail view")
                                        .navigationBarTitle("Second View", displayMode: .inline))
                        {
                            UpcomingContestView()
                            
                        }
                        
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
