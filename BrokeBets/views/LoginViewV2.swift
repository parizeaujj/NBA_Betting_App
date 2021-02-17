//
//  LoginView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/16/21.
//


import SwiftUI

struct LoginViewV2: View {
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        ZStack {
            VStack{
                
                Image("brokeBetsLoginLogo")
                    .resizable()
                    .scaledToFit()
                    
                    .frame(width: 250, height: 250)
                    //                    .clipped()
//                    .padding(.top, 50)
//                    .padding(.bottom, 50)
                
                
                //
                
                
                Text("Login")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                
                
                
                
              
              
                
                TextField("Email", text: $email)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(self.email != "" ? Color(UIColor.systemBlue) : Color.black.opacity(0.7), lineWidth: 2))
                    .padding(.top, 25)
                
                VStack{
                    
                    TextField("Password", text: $password)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).stroke(self.password != "" ? Color(UIColor.systemBlue) : Color.black.opacity(0.7), lineWidth: 2))
                        .padding(.top, 25)
                    
                    HStack{
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Forgot Password?")
                                .foregroundColor(Color.blue)
                                .font(.subheadline)
                        }).padding(.leading, 5)
                        Spacer()
                    }
                }
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Login")
                        .foregroundColor(Color.white)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 50)
                        .background(Color(UIColor.systemBlue))
                        .cornerRadius(10)
                })
                .padding(.top, 25)
                
                
                HStack{
                    Text("Don't have an account?")
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Sign Up")
                            .foregroundColor(Color.blue)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    })
                }
                .padding(.top, 10)
                
                
                Text("OR")
                    .font(.headline)
                    .padding(.top, 25)
//
//                SignInWithAppleButton()
//                    .frame(width: 280, height: 44)
//                    .padding(.top, 25)
//
//                Spacer()
                
            }
            .padding(.horizontal, 25)
        }
    }
}


struct LoginViewV2_Previews: PreviewProvider {
    static var previews: some View {
        LoginViewV2()
            
    }
}

