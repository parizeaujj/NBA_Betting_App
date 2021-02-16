//
//  ContentView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/5/21.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        
        
        ZStack {
            
            Color(red: 240/255, green: 243/255, blue: 248/255, opacity: 1)
            VStack {
                
                Text("Hello World")
                VStack {
                    Text("Broke Bets")
                        .font(.largeTitle)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color(red: 43/255, green: 43/255, blue: 43/255, opacity: 1))
                }
                .padding(20)
                .background(Color(red: 254/255, green: 255/255, blue: 255/255, opacity: 1))
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(red: 210/255, green: 215/255, blue: 222/255, opacity: 1), lineWidth: 1)
                )
                
            }
     
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

