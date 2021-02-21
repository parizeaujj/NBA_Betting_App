//
//  ContentView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/5/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var userService : UserService
    
    var body: some View {
        
        
        if userService.isLoggedIn {
            
            if(userService.doesHaveUsername){
                MainAppView()
                    .environmentObject(userService)
            }
            else{
                CreateUsernameView(viewModel: CreateUsernameVM(userService: userService))
            }
           
        }
        else {
            LoginView()
                .environmentObject(userService)
        }
    }
}





enum UsernameError {
    
    case InvalidLength
    case AlreadyTaken
    case None
    
}


class CreateUsernameVM: ObservableObject {
    
    private let userService: UserService
    
    @Published var usernameError: UsernameError = .None
    @Published var username: String = "" {
        
        didSet {
            if username.count > 16 && oldValue.count <= 16 {
                username = oldValue
            }
            
            // if there was previously an invalid length error, and the user has since fixed, then get rid of that as an error
            if usernameError == .InvalidLength && username.count >= 6 {
                usernameError = .None
            }
            
            // if there was previously a 'username already taken' error, and the user has since changed the text in the textfield, then stop showing that error message
            else if(usernameError == .AlreadyTaken && username != oldValue){
                usernameError = .None
            }
            
        }
    }
    
    
    init(userService: UserService){
        self.userService = userService
    }
    
    func submitButtonWasPressed(){
        
        if(isInvalidLength()){
            self.usernameError = .InvalidLength
            return
        }
        
        userService.doesHaveUsername = true
        print("username added to database")
    }
    
    func isInvalidLength() -> Bool {
        return self.username.count < 6
    }
}



struct CreateUsernameView: View {
    

    @ObservedObject var viewModel: CreateUsernameVM
    
    
    
    var body: some View {
        
        NavigationView{
            
            VStack(alignment: .center){
                
                Text("Create a Username")
                    .font(.title)
                    .fontWeight(.bold)
                    //                .padding(.leading, 35)
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
                    .padding(.horizontal, 35)
                    .padding(.top, 30)
                
               
                Text("Username must be at least 6 characters long")
                    .font(.subheadline)
                    .foregroundColor(.red)
                    .opacity(viewModel.usernameError == .InvalidLength ? 1 : 0)
                
                
                Button(action: {
                    viewModel.submitButtonWasPressed()
                }, label: {
                    Text("Continue")
                        .foregroundColor(Color.white)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        //                        .padding(.vertical)
                        //                        .frame(maxWidth: .infinity)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding([.vertical], 15)
                        .background(Color(UIColor.systemBlue).opacity(viewModel.username.isEmpty ? 0.4 : 1.0))
                        .cornerRadius(25)
                })
                .disabled(viewModel.username.isEmpty)
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserService())
    }
}

