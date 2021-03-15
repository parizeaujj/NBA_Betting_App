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
            
            title: Text("Confirm Draft Selection"),
            message:
                Text("\n" + selectedbet),
            primaryButton:
                .default(
                Text("Confirm").foregroundColor(.red),
                  action: {}
            )
            ,
            secondaryButton:
                
                .destructive(
                    Text("Cancel"), action: {
                    
                    }
            )
            
        )
        
    }
    
    var body: some View {
        Button("RandomBet") {
           showing = true
           selectedbet = "HOU -7 (vs CLE)";
         }
        
        .alert(isPresented: $showing, content: {self.alert}) //view modifier
           
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
