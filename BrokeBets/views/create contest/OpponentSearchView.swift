//
//  SearchBar.swift
//  BrokeBets
//
//  Created by Fabrizio Herrera on 3/3/21.
//

import SwiftUI

struct OpponentSearchView: View {
        
    @ObservedObject var opponentSearchVM: OpponentSearchVM
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            Color.gray.opacity(0.2)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0){
                
                VStack(spacing: 0){
                    
                    HStack {
                        
                        TextField("Enter a username", text: self.$opponentSearchVM.usernameText)
                            .foregroundColor(.black)
                            .autocapitalization(.none)
                            .keyboardType(.asciiCapable)
                            .disableAutocorrection(true)
                        
                        if self.opponentSearchVM.usernameText != "" {
                            Button(action: {
                                
                                self.opponentSearchVM.usernameText = ""
                                
                            }) {
                                
                                 Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(Color.black.opacity(0.7))
                                    .imageScale(.large)
                            }
                            .foregroundColor(.black)
                        }
                    }.padding()
                    
                  
                    VStack(alignment: .leading, spacing: 0){
                    
                        
                        if opponentSearchVM.searchResults.count > 0 {
                            
                            ForEach(opponentSearchVM.searchResults){ user in
                                
                                Button(action: {
                                    
                                    self.opponentSearchVM.setOpponentSelection(user)
                                    
                                }, label: {
                                    
                                    VStack(spacing: 0){
                                        Divider()
                                            .padding(.bottom, 15)
                                        
                                        HStack{
                                            
                                            Text("\(user.username ?? "none")")
                                                .font(.headline)
                                                
                                            Spacer()
                                        }
                                        .padding(.bottom, 15)
                                        .padding(.horizontal, 23)
                                       
                                    }
                                })
                            }
                        }
                        else if opponentSearchVM.usernameText != "" {
                            
                            Text("No users found")
                            .font(.subheadline)
                            .padding(.horizontal, 20)
                            .padding(.vertical)
                        }
                        
                        
                        
//                        Text("Suggested")
//                            .font(.headline)
//                            .fontWeight(.bold)
//                            .padding(.horizontal, 20)
//                            .padding(.vertical)
//
//
//                        // TODO: Implement this lol
//                        ForEach(1..<4){ user in
//
//
//                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
//
//                                VStack(spacing: 0){
//                                    Divider()
//                                        .padding(.bottom, 15)
//
//                                    HStack{
//
//                                        Text("Suggested user")
//                                            .font(.headline)
//
//
//                                        Spacer()
//                                    }
//                                    .padding(.bottom, 15)
//                                    .padding(.horizontal, 23)
//
//                                }
//                            })
//                        }
                        
                        
                    }
                    .frame(maxWidth: .infinity)
                }
                .accentColor(.blue)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.vertical)
                .padding(.horizontal, 20)
                
             
            }
        }
    }
}



struct SearchBarView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let appState = AppState(shouldByPassLogin: true)
   
        OpponentSearchView(opponentSearchVM: OpponentSearchVM(currentSelectedUser: nil, setOpponentSelection: { _ in }, userService: appState.userService))
            .environmentObject(UserScreenInfo(.regular))
            .environment(\.colorScheme, .light)
            .preferredColorScheme(.light)
    }
}
