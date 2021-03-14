//
//  SwiftUIView.swift
//  BrokeBets
//
//  Created by user191100 on 3/13/21.
//

import SwiftUI

struct ContentView2: View {
    
    @State private var showing = false;
    @State private var selectedbet = "";
    var alert: Alert{
         Alert(
            
            title: Text("Confirm selection"),
            message: Text("Are you want to select the following bet: " + selectedbet),
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
        Button("RandomBet") {
           showing = true
           selectedbet = "Fillerbet";
         }
        
        .alert(isPresented: $showing, content: {self.alert}) //view modifier
           
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
