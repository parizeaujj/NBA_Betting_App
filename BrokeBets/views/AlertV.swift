//
//  SwiftUIView.swift
//  BrokeBets
//
//  Created by user191100 on 3/13/21.
//

import SwiftUI

struct SwiftUIView: View {
    
    @State private var showing = false;
    
    var alert: Alert{
         Alert(
            
            title: Text("Confirm selection"),
            message: Text("Are you want to select this bet?"),
            primaryButton: .default(
                  Text("Yes"),
                  action: {}
            ),
            secondaryButton: .destructive(
                 Text("No")
                
            )
        )
        
    }
    
    var body: some View {
        Button("Random") {
           showing = true
         }.alert(isPresented: $showing, content: {self.alert})
           
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
