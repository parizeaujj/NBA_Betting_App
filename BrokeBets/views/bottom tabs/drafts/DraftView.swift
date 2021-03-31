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
    var draftsRepo: DraftsRepositoryProtocol
    
    init(draft: Draft, draftsRepo: DraftsRepositoryProtocol){
        self.draft = draft
        self.draftsRepo = draftsRepo
        
        if(draft.isUserTurn){
            turnText = "Your Turn"
            turnTextColor = Color.red
        }
        else{
            turnText = "Opponent's Turn"
            turnTextColor = Color(.darkGray)
        }
    }
    
    var body: some View {
        VStack(spacing: 0){
            
            HStack{
                
                Text("\(turnText)")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(turnTextColor)
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
                            .fontWeight(.bold)
                    }
                    
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
                }
                
                Spacer()
                
                VStack(spacing: 12){
                    
                    NavigationLink(
                        destination: DraftBoardView(viewModel: DraftBoardVM(draft: draft, draftsRepo: draftsRepo)),
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
                        destination: DraftPickSelectionView(viewModel: DraftPickSelectionVM(draft: draft, draftsRepo: draftsRepo)),
                        label: {
                            
                            Text("Select Pick")
                                .font(.subheadline)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                                .foregroundColor(Color.white.opacity(draft.isUserTurn ? 1 : 0.8))
                                .background(Color.black.opacity(draft.isUserTurn ? 1 : 0.08))
                                .clipShape(Capsule())
                                .overlay(Capsule().strokeBorder(draft.isUserTurn ? Color.black: Color.clear, lineWidth: 1.0))
                            
                            
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
        
        let user = User(uid: "testToddUid", username: "testTodd123")
        DraftView(draft: Draft(data: MockDraftsRepository(user: user).mockData["draftid1"]!, playerUid: user.uid)!, draftsRepo: MockDraftsRepository(user: user))
    }
}
