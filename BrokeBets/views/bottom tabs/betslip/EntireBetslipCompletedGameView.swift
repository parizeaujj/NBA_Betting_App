//
//  EntireBetslipCompletedGameView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/18/21.
//


import SwiftUI

struct EntireBetslipCompletedGameView: View {
    
    private var opponent: String = "Cody1234"
    
    var body: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 5)
            .stroke(Color.black.opacity(0.65), lineWidth: 1.2)
            
            VStack(spacing: 0) {
            
                        HStack{
                            Text("Completed: Jan 11th, 2021")
                                .font(.caption2)
                                .foregroundColor(Color(red: 0, green: 38/255, blue: 77/255))
                                .fontWeight(.semibold)
                                .padding(.leading)
                                .padding(.bottom, 5)
                            Spacer()
                            
                            Text("Betslip")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .padding(.trailing, 55)
                                .padding(.bottom, 5)
                        }.padding(.top, 5)
                        
                            
                Rectangle().frame(width: nil, height: 1.5, alignment: .bottom).foregroundColor(Color.gray)

                HStack(spacing: 0){
                    HStack{
                        VStack {
                            Text("HOU Rockets")
//                                .font(.subheadline)
                                .padding(.vertical, 5)
                            Text("CLE Cavaliers")
//                                .font(.subheadline)
                                .padding(.vertical, 5)
                        }
                        .padding(.leading, 10)
                        
                        Spacer()
                        
                        VStack(alignment: HorizontalAlignment.trailing) {
                            Text("50")
//                                .fontWeight(.light)
//                                .font(.subheadline)
                                .padding(.vertical, 5)



                            Text("150")
//                                .fontWeight(.mediu)
//                                .font(.subheadline)
                                .padding(.vertical, 5)
                        }
//                        .padding(.leading, 4)
                        Spacer()
                
                    }
                    .padding(.leading, 5)
                    .padding(.top, 5)
                    
                
                    Spacer()
                    
//                    Divider()
//                        .background(Color.gray)
                    
                    Rectangle().frame(width: 1.5, height: nil, alignment: .leading).foregroundColor(Color.gray)
                    
                    HStack(spacing: 0){
                        VStack(spacing: 0){
                            
                         
                            Text("Bets")
                                .font(.caption)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 3)
                                .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color.gray), alignment: .bottom)
                                    
//                                Divider()
//                                    .background(Color.gray)
                                
//                                Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color.gray)
                            Group{
                                Text("HOU -7")
                                    .font(.caption2)
                                Text("CLE +7")
                                    .font(.caption2)
                                Text("O 45.5")
                                    .font(.caption2)
                                Text("U 45.5")
                                    .font(.caption2)
                                
                            }.padding(.vertical, 2)
//                            .padding(.horizontal)

                            
//                            Spacer()
                        }
                        .padding(.bottom, 2)
                        .fixedSize(horizontal: true, vertical: false)
                        
                        Divider()
                            .background(Color.gray)
                    
                        VStack(spacing: 0){
                            
                            Text("Contests")
                                .font(.caption)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 3)
                                .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color.gray), alignment: .bottom)
                                    
                            Group{
                                Text("1")
                                    .font(.caption2)
                                Text("2")
                                    .font(.caption2)
                                Text("2")
                                    .font(.caption2)
                                Text("1")
                                    .font(.caption2)
                                
                            }.padding(.vertical, 2)
                            
                        }
                        .padding(.bottom, 2)
                        .fixedSize(horizontal: true, vertical: false)
                        
                        Divider()
                            .background(Color.gray)
                    
                        VStack(spacing: 0){
                            
                            Text("Result")
                                .font(.caption)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 3)
                                .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color.gray), alignment: .bottom)
                                    
                            Group{
                                Text("WON")
                                    .font(.caption2)
//                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.green)
                                Text("LOST")
                                    .font(.caption2)
//                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.red)
                                Text("PUSH")
                                    .font(.caption2)
//                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.black)
                                Text("PUSH")
                                    .font(.caption2)
//                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.black)
                                
                            }.padding(.vertical, 2)
                            
                            
                        }.padding(.bottom, 2)
                      
                        .fixedSize(horizontal: true, vertical: false)
                        
                        
                        
                        
                    }
                    .padding(1)
                    
                }.background(Color.gray.opacity(0.08))
               
                

               
                
            }
            
        }.frame(width: .infinity, height: 120)
        
        
//            HStack{
//                VStack {
//
//                    HStack {
//                        Text("Opponent:")
//
//                        Text("\(self.opponent)")
//                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
//
//                        Spacer()
//
//                        Text("Number of bets:")
//                            .font(.subheadline)
//
//                        Text("10")
//                            .font(.subheadline)
//                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                            .padding(.trailing, 15)
//
//                    }
//                    .padding(.bottom, 15)
//
//
//                    HStack {
//                        Text("First game start: ")
//                            .font(.subheadline)
//                        Text("Today at 4pm EST")
//                            .fontWeight(.bold)
//                            .font(.subheadline)
//                        Spacer()
//                    }
//                }
//
//
//                Image(systemName: "chevron.right")
//                    .font(.system(.footnote))
//
//            }
//            .padding(8)
//            .background(Color.white)
//            .cornerRadius(5)
//            .overlay(
//                RoundedRectangle(cornerRadius: 5)
//                    .stroke(Color.black.opacity(0.65), lineWidth: 1.2)
//            )
//            .padding(.horizontal, 10)
//            .padding(.vertical, 5)
    }
}


struct EntireBetslipCompletedGameView_Previews: PreviewProvider {
    static var previews: some View {
        EntireBetslipCompletedGameView()
    }
}


