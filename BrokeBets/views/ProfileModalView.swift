//
//  ProfileModalView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/1/21.
//

import SwiftUI

struct ProfileModalView: View {
    
    @Binding var isShowingProfileModal: Bool
    
    @EnvironmentObject var userService: UserService
    
    var body: some View {
        
        
        Color.gray.opacity(0.4)
            .edgesIgnoringSafeArea(.all)
            .animation(nil)
            .gesture(
                
                TapGesture().onEnded({ _ in
                    
                    print("here")
                    withAnimation{
                        self.isShowingProfileModal = false
                    }
                })
            )
        
        VStack(spacing: 0){
            
            ZStack(alignment: .top){
                
                Rectangle()
                    .fill(Color.white)
                    .frame(width: UIScreen.main.bounds.width, height: 30)
                
                VStack(spacing: 0){
                    
                    
                    HStack{
                        
                        Text("codyshowstoppa")
                            
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black.opacity(0.8))
                        
                    }
                    .padding(.top, 20)
                    .padding(.bottom)
                    
                    Rectangle().frame(width: nil, height: 1.5, alignment: .bottom).foregroundColor(Color.gray.opacity(0.5))
                        .padding(.horizontal)
                    
                    Button(action: {
                        print("user logged out")
                        userService.logout()
                        
                    }, label: {
                        Text("Sign out")
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                    })
                    .padding()
                }
                .padding(.top, 50)
                .frame(width: UIScreen.main.bounds.width)
                .background(Color.white)
                .clipShape(
                    RoundedRectangle(cornerRadius: 20)
                )
                .edgesIgnoringSafeArea(.top)
                
            }
            .edgesIgnoringSafeArea(.top)
            
            Color.gray.opacity(0)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.bottom)
            
        }
        .transition(.move(edge: .top))
        .animation(Animation.default.speed(2.0))
    }
}

struct ProfileModalView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileModalView(isShowingProfileModal: .constant(false))
            .environmentObject(UserService())
    }
}
