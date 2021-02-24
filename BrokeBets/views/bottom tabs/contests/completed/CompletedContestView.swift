//
//  CompletedContestView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/23/21.
//

import SwiftUI

struct CompletedContestView: View {
    var body: some View {
        
        NavigationLink(destination: Text("hello")
                        .navigationBarTitle("Contest Betslip", displayMode: .inline))
        {
            
            VStack(alignment: .leading, spacing: 0){
                
                HStack(alignment: .bottom, spacing: 0) {
                    
                    VStack(alignment: .leading, spacing: 0){
                        
                        HStack{
                            Text("Result:")
                                .font(.caption)
                                .foregroundColor(Color.black)
                                .fontWeight(.semibold)
                                .padding(.bottom, 2)
                                .padding(.leading, 5)
                            
                            Text("Lost")
                                .font(.caption)
                                .foregroundColor(Color.red)
                                .fontWeight(.bold)
                                .padding(.bottom, 2)
                        }
                        
                        
                        Rectangle().frame(width: nil, height: 1.5, alignment: .bottom).foregroundColor(Color.gray)
                        
                        Text("You")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.black)
                            .padding(.vertical, 6)
                            .padding(.leading, 5)
                        
                        Text("Opponent")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.blue)
                            .padding(.vertical, 6)
                            .padding(.leading, 5)
                    }
                    
                  
                    
                    VStack(spacing: 0){
                        Text("Drafted Wins")
                            .foregroundColor(.black)
                            .font(.caption)
                            .padding(.bottom, 2)
                        
                        Rectangle().frame(width: nil, height: 1.5, alignment: .bottom).foregroundColor(Color.gray)
                        
                        Text("1")
                            .foregroundColor(.black)
                            .padding(.vertical, 6)

                        Text("2")
                            .foregroundColor(.black)
                            .padding(.vertical, 6)

                    }
                    VStack(spacing: 0){
                        Text("Forced Wins")
                            .foregroundColor(.black)
                            .font(.caption)
                            .padding(.bottom, 2)
                        
                        Rectangle().frame(width: nil, height: 1.5, alignment: .bottom).foregroundColor(Color.gray)
                        
                        Text("0")
                            .foregroundColor(.black)
                            .padding(.vertical, 6)

                        Text("1")
                            .foregroundColor(.black)
                            .padding(.vertical, 6)

                    }
                    VStack(spacing: 0){
                        Text("Total Wins")
                            .font(.caption)
                            .foregroundColor(.black)
                            .padding(.bottom, 2)

                        Rectangle().frame(width: nil, height: 1.5, alignment: .bottom).foregroundColor(Color.gray)
                        
                        Text("1")
                            .foregroundColor(.black)
                            .fontWeight(.black)
                            .padding(.vertical, 6)

                        Text("3")
                            .foregroundColor(.black)
//                            .fontWeight(.black)
                            .padding(.vertical, 6)

                    }
                }
                
                HStack {
                    HStack{
                        Text("Total Bets:")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .padding(.top, 5)
                            .padding(.leading, 10)
                        
                        Text("10")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .padding(.top, 5)
                            
                    }
                    
                    Spacer()
                    
                    HStack{
                        HStack{
                            Text("Completed:")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 0, green: 38/255, blue: 77/255))
                                .padding(.top, 5)
                            
                            Text("Feb 6th, 2021")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 0, green: 38/255, blue: 77/255))
                                .padding(.top, 5)
                                .padding(.trailing, 10)
                        }
                    
                    }
                }
             

            }
            
        }
        .padding(.vertical, 8)
        .padding(.leading, 10)
        .frame(width: .infinity)
        .overlay(CustomRoundedRect(tabColor: .red))
        .padding(.horizontal, 10)
    }
    
    
}

struct CompletedContestView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedContestView()
    }
}
