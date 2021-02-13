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
                                    .navigationBarTitle("Second View", displayMode: .inline)
                    )
                    {
                        HStack{
                            Text("Row \(value)").frame(maxWidth: .infinity, alignment: .leading)
                        }.padding(4)
                        
                    }.buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}
