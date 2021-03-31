//
//  CreateUsernameView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/24/21.
//

import SwiftUI

struct CreateUsernameView: View {
    
    @ObservedObject var viewModel: CreateUsernameVM
    
    var body: some View {
        
        NavigationView{
            
            VStack(alignment: .center){
                
                Text("Create a Username")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 45)
                
           
                
                TextField("Enter a username", text: $viewModel.username)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding([.trailing, .leading], 20)
                    .padding([.vertical], 20)
                    .lineLimit(1)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    
                    .keyboardType(.asciiCapable)
//                    .textCase(.uppercase)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding(.horizontal, 35)
                    .padding(.top, 25) // was 30
                    
                
                HStack{
                    
                    Text(viewModel.usernameError.rawValue)
                        .font(.subheadline)
                        .foregroundColor(.red)
                        .opacity(viewModel.usernameError == .None ? 0 : 1)
                        
                        .padding(.leading, 45)
                    
                    Spacer()
                }
                
    
                Button(action: {
                    viewModel.submitButtonWasPressed()
                }, label: {
                    Text("Continue")
                        .foregroundColor(Color.white)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding([.vertical], 15)
                        .background(Color(UIColor.systemBlue).opacity(viewModel.shouldBeDisabled ? 0.4 : 1.0))
                        .cornerRadius(25)
                })
                .disabled(viewModel.shouldBeDisabled)
                .padding(.horizontal, 35)
                .padding(.top, 40)
                
                Spacer()
            }
            .padding(.top, 160)
            .navigationBarTitle(Text(""), displayMode: .inline)
            .navigationBarItems(trailing:   Image("brokeBetsLoginLogo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    //                                    .padding(.top, 40)
                                    .padding(.trailing, (UIScreen.main.bounds.width / 2.0) - 50)
            )
        }
    }
}

struct CreateUsernameView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUsernameView(viewModel: CreateUsernameVM(userService: UserService()))
    }
}
