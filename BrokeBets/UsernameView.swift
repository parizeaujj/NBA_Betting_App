//
//  UsernameView.swift
//  Test
//
//  Created by Aland Nguyen on 2/16/21.
//

import SwiftUI

struct UsernameView: View
{
    @State var username: String = ""
    @State var isActive : Bool = false
    @State private var action: Int? = 0
    @State private var showingAlert = false
    //let characterset = CharacterSet(charactersIn: "!@#$%^&*()")
    let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, Color("Teal")]),startPoint: .topLeading,
                    endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)

                VStack(alignment: .leading) {
                    //Image(systemName: "arrowshape.turn.up.left.fill")
                    Text("Username")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.title2)
                    TextField("Enter username...", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Text("Continue")
                        .fontWeight(.semibold)
                        .font(.title)
                        .onTapGesture
                        {
                        //perform some tasks if needed before opening Destination view
                            if username.rangeOfCharacter(from: characterset.inverted) != nil
                            {
                                showingAlert = true
                            }
                            else if username.count >= 10
                            {
                                showingAlert = true
                            }
                            else if username.count <= 3
                            {
                                showingAlert = true
                            }
                            else if username.count > 3 && username.count < 10
                            {
                                showingAlert = false
                                action = 1
                            }
                        }
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(40)
                        .alert(isPresented: $showingAlert, content: {
                                    Alert(title: Text("Username Error"),
                                    message: Text("You have entered an invalid username, please chose another"),
                                    dismissButton: .default(Text("Ok")) )
                                })
                    // Making the navigation link, link to the
                    // home page of broke bets
                    NavigationLink(destination: Text("This would be home page"), tag: 1, selection: $action) {EmptyView()}
                    
                    
                }.padding()
            }
            .navigationTitle("Username Selection Page")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View {
        UsernameView()
    }
}
