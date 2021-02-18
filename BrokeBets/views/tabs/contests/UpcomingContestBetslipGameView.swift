//
//  ContestBetslipGameView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/17/21.
//

import SwiftUI

struct UpcomingContestBetslipGameView: View {
    
    private var opponent: String = "Cody1234"
    
    var body: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 5)
            .stroke(Color.black.opacity(0.65), lineWidth: 1.2)
            
            VStack(spacing: 0) {
            
                        HStack{
                            Text("Today at 4pm EST")
                                .font(.subheadline)
                                .foregroundColor(Color(red: 0, green: 38/255, blue: 77/255))
                                .fontWeight(.semibold)
                                .padding(.leading)
                                .padding(.bottom, 5)
                            Spacer()
                            
                        }.padding(.top, 5)
                        
                            
                Rectangle().frame(width: nil, height: 1.5, alignment: .bottom).foregroundColor(Color.gray)

                HStack(spacing: 0){
                    HStack{
                        VStack {
                            Text("HOU Rockets")
                                .padding(.vertical, 5)
                            Text("CLE Cavaliers")
                                .padding(.vertical, 5)
                        }
                        .padding(.leading, 15)
                        
                        Spacer()
                        
                   
                
                    }
                    .padding(.leading, 5)
                    .padding(.top, 5)
                    
                
                    Spacer()
                    
                    Rectangle().frame(width: 1.5, height: nil, alignment: .leading).foregroundColor(Color.gray)
                    
                    HStack(spacing: 0){
                        VStack(spacing: 0){
                            
                         
                            Text("Bets")
                                .font(.subheadline)
                            
                                .padding(.horizontal, 45)
                                .padding(.vertical, 4)
                                .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color.gray), alignment: .bottom)
                                    
                            Spacer()
                            VStack(spacing: 8){
                                Text("HOU -7")
                                    .font(.subheadline)
                                
                                Text("O 45.5")
                                    .font(.subheadline)
                                

                                
                            }.padding(.vertical, 5)
                            
                            Spacer()

                        }
                        .fixedSize(horizontal: true, vertical: false)
                        
                        
                       
                        
                        
                        
                        
                    }
                    .padding(1)
                    
                }.background(Color.gray.opacity(0.08))
               
                

               
                
            }
            
        }.frame(width: UIScreen.main.bounds.width - 50, height: 120)
        
        

    }
}


struct UpcomingContestBetslipGameView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingContestBetslipGameView()
    }
}

