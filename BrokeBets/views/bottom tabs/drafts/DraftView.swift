//
//  DraftView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/9/21.
//

import SwiftUI

struct DraftView: View {
    
    var draft: Draft
    var turnText: String
    var turnTextColor: Color
    
    init(draft: Draft){
        self.draft = draft
        
        if(draft.isUserTurn){
            turnText = "Your Turn"
            turnTextColor = Color.red
        }
        else{
            turnText = "Opponent's Turn"
            turnTextColor = Color.gray
        }
    }
    
    var body: some View {
        VStack(spacing: 0){
            
            HStack{
                
                Text("\(turnText)")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(.red)
                Spacer()
                Text("Expires: \(draft.draftExpirationDateTimeStr)")
                    .font(.caption)
                
            }
            .padding(.top, 6)
            .padding(.bottom, 2)
            .padding(.horizontal, 8)
            
            Rectangle().frame(width: nil, height: 1.5, alignment: .bottom).foregroundColor(Color.gray)
            
            HStack{
                
                VStack(alignment: .leading, spacing: 20){
                    
                    HStack{
                        Text("Opponent:")
                            .font(.callout)
                        Text("\(draft.opponent)")
                            .foregroundColor(.blue)
                            .font(.callout)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
//                    .padding(.vertical, 8)
                    
                    HStack(spacing: 0){
                        Text("Round:")
                            .font(.callout)
                            .padding(.trailing, 4)
                            
                        Text("\(draft.currentRound)")
                            .font(.callout)
                            .fontWeight(.black)
                            .padding(.horizontal, 4)
                        Text(" of ")
                            .font(.subheadline)
                        Text("\(draft.totalRounds)")
    
                            .font(.callout)
                            .fontWeight(.black)
                            .padding(.horizontal, 4)
                    }
//                    .padding(.vertical, 8)
                    
                }
                
                Spacer()
                
                VStack(spacing: 12){
                    
                    NavigationLink(
                        destination: DraftBoardView(viewModel: DraftBoardVM(draft: draft, draftsRepo: MockDraftsRepository())),
                        label: {
                           
                            Text("View board")
                                .font(.subheadline)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                                .foregroundColor(Color.white)
                                .background(Color.blue)
                                .clipShape(Capsule())
                                .overlay(Capsule().strokeBorder(Color.blue, lineWidth: 1.0))
                            
                            
                        })
                    
                    NavigationLink(
                        destination: DraftPickSelectionView(viewModel: DraftPickSelectionVM(draft: draft, draftsRepo: MockDraftsRepository())),
                        label: {
                            
                            Text("Select Pick")
                                .font(.subheadline)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                                .foregroundColor(Color.white.opacity(draft.isUserTurn ? 1 : 0.8))
                                .background(Color.black.opacity(draft.isUserTurn ? 1 : 0.08))
                                .clipShape(Capsule())
                                .overlay(Capsule().strokeBorder(Color.black, lineWidth: 1.0))
                            
                            
                        })
                        .disabled(!draft.isUserTurn)
                    
                }
                .accentColor(.blue)
                .padding(.vertical, 12)
                
            }
            .padding(.horizontal, 8)
            
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(Color.gray, lineWidth: 1))
                
    }
}

struct DraftView_Previews: PreviewProvider {
    static var previews: some View {
        DraftView(draft: Draft(data: MockDraftsRepository().mockData["draftid1"]!, playerUid: "testToddUid")!)
    }
}
