//
//  AvailableDraftGameView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/8/21.
//

import SwiftUI

struct AvailableDraftGameView: View {
    var body: some View {
  
        HStack(spacing: 0){
                
                VStack(alignment: .leading, spacing: 0){
                    
                    Text("Today at 8:00pm")
                        .font(.caption)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.top, 8)
                        .padding(.bottom, 2)
                        .padding(.leading)
                    
                    Rectangle().frame(width: nil, height: 1.5, alignment: .bottom).foregroundColor(Color.gray)
                    
                    HStack{
                        
                        
                        VStack(alignment: .leading, spacing: 0){
                            Text("HOU Rockets")
                                .font(.subheadline)
                                .padding(.leading)
                                .padding(.top, 14)
                                .padding(.bottom, 11)
                            
                            Text("MIN Timberwolves")
                                .font(.subheadline)
                                .padding(.leading)
                                .padding(.top, 11)
                                .padding(.bottom, 14)
                        }
                        .padding(.trailing)
                        
                  
                        Rectangle().frame(width: 1.5, height: nil, alignment: .leading).foregroundColor(Color.gray)
                    }
                    .background(Color.gray.opacity(0.15))
                   
                }
                .fixedSize()
                
                VStack(spacing: 0){
                    
                    Text("Spread")
                        
                        .font(.caption)
                        .padding(.top, 8)
                        .padding(.bottom, 2)
                        .padding(.trailing, 1.5)
                    
                    Rectangle().frame(width: nil, height: 1.5, alignment: .bottom).foregroundColor(Color.gray)
                    
                    HStack(spacing:0){
                        
                        
                        VStack(spacing: 0){
                            
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                
                                DraftBetCapsule(label: "HOU +7", isDisabled: false)
                                    .padding(.top, 10)
                                    .padding(.bottom, 7)
                                
                            })
                            .disabled(false)
                        
                            
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                
                                DraftBetCapsule(label: "MIN -7", isDisabled: false)
                                    .padding(.top, 7)
                                    .padding(.bottom, 10)
                                
                            }).disabled(false)
                            
                        }
                        
                        Rectangle().frame(width: 1.5, height: nil, alignment: .leading).foregroundColor(Color.gray)
                    }
                    .background(Color.gray.opacity(0.15))
                   
                }
                .fixedSize()
                
                
                VStack(spacing: 0){
                    
                    Text("O/U")
                        .font(.caption)
                        .padding(.bottom, 2)
                        .padding(.top, 8)
                    Rectangle().frame(width: nil, height: 1.5, alignment: .bottom).foregroundColor(Color.gray)
                    
                    HStack(spacing: 0){
                         
                        VStack(spacing: 0){

                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                
                                DraftBetCapsule(label: "o 225.5", isDisabled: false)
                                    .padding(.top, 10)
                                    .padding(.bottom, 7)
                                
                            }).disabled(false)
                            
                        
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                
                                DraftBetCapsule(label: "u 225.5", isDisabled: true)
                                    .padding(.top, 7)
                                    .padding(.bottom, 10)
                                
                            })
                            .disabled(true)

                        }
                        
                    }
                    .background(Color.gray.opacity(0.15))
                    
                }
                .fixedSize()
                
        }
        .accentColor(.black)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/))
      
    }
}





struct AvailableDraftGameView_Previews: PreviewProvider {
    static var previews: some View {
        AvailableDraftGameView()
    }
}
