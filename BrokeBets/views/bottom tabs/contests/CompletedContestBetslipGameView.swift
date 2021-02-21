//
//  CompletedContestBetslipGameView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/18/21.
//



import SwiftUI

struct CompletedContestBetslipGameView: View {
    
    private var opponent: String = "Cody1234"
    
    var body: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 5)
            .stroke(Color.black.opacity(0.65), lineWidth: 1.2)
            
            VStack(spacing: 0) {
            
                        HStack{
                            Text("Completed: Jan 13th, 2021")
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
                        
                        VStack(alignment: HorizontalAlignment.trailing) {
                            Text("101")
                                .fontWeight(.bold)
                                .padding(.vertical, 5)
                                
                            
                            Text("83")
                                .padding(.vertical, 5)
                        }

                        Spacer()
                
                    }
                    .padding(.leading, 5)
                    .padding(.top, 5)
                    
                
                    Spacer()
                                        
                    Rectangle().frame(width: 1.5, height: nil, alignment: .leading).foregroundColor(Color.gray)
                    
                    HStack(spacing: 0){
                        VStack(spacing: 0){
                            
                         
                            Text("Bets")
                                .font(.caption)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 4)
                                .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color.gray), alignment: .bottom)
                                    
                            Spacer()
                            VStack(spacing: 10){
                                Text("HOU -7")
                                    .font(.caption)
                                
                                Text("O 210.5")
                                    .font(.caption)
                                

                                
                            }.padding(.vertical, 5)
                            
                            Spacer()

                        }
                        .fixedSize(horizontal: true, vertical: false)
                        
                        
                       
                        Divider()
                            .background(Color.gray)
                    
                        VStack(spacing: 0){
                            
                         
                            Text("Results")
                                .font(.caption)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color.gray), alignment: .bottom)
                                    
                            Spacer()
                            VStack(spacing: 10){
                                Text("WON")
                                    .font(.caption)
                                    .foregroundColor(.green)
                                
                                Text("LOST")
                                    .font(.caption)
                                    .foregroundColor(.red)
                                

                                
                            }.padding(.vertical, 5)
                            
                            Spacer()
                            
                        }.padding(.bottom, 2)
                        
                        
                        
                    }
                    .padding(1)
                    
                }.background(Color.gray.opacity(0.08))
               
                

               
                
            }
            
        }.frame(width: UIScreen.main.bounds.width - 50, height: 120)
        
        

    }
}


struct CompletedContestBetslipGameView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedContestBetslipGameView()
    }
}

