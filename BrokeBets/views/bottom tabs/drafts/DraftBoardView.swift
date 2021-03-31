//
//  DraftBoardView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/8/21.
//

import SwiftUI

struct DraftBoardView: View {
    
    @StateObject var viewModel: DraftBoardVM
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack{
            
            VStack{
                VStack(spacing: 20){
                    
                    Group{
                        HStack{
                            
                            Text("VS")
                                .fontWeight(.bold)
                                .font(.subheadline)
                            
                            Text("\(viewModel.draft.opponent)")
                                .foregroundColor(.blue)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            
                            Text("Expires: \(viewModel.draft.draftExpirationDateTimeStr)")
                                .font(.footnote)
                        }
                        .padding(.top)
                        
                        HStack{
                            
                            
                            Text("Round")
                                .font(.subheadline)
                            
                            
                            Text("\(viewModel.draft.currentRound)")
                                .fontWeight(.bold)
                            
                            Text("of")
                                .font(.subheadline)
                            
                            
                            Text("\(viewModel.draft.totalRounds)")
                                .fontWeight(.bold)
                            
                            Spacer()
                        }
                    }
                    .padding(.horizontal)
                    
                    Rectangle().frame(width: nil, height: 1.5, alignment: .bottom).foregroundColor(Color.gray)
                }
                .background(Color.white)
                
                
                
                ScrollView{
                    
                    if let draftRounds = viewModel.draft.userDraftRoundsResults, draftRounds.count > 0 {
                        
                        LazyVStack(alignment: .leading, spacing: 0){
                            
                            
                            ForEach(draftRounds){ draftRound in
                                
                                HStack{
                                    Text("Round \(draftRound.round)")
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                .padding(.leading)
                                .padding(.top, 10)
                                
                                VStack(alignment: .leading, spacing: 5){
                                    
                                    if let drafted = draftRound.draftedBetStr {
                                        Text("Drafted: \(drafted)")
                                    }
                                    else{
                                        Text("Drafted: TBD")
                                    }
                                    if let forced = draftRound.forcedBetStr {
                                        Text("Forced: \(forced)")
                                    }
                                    else{
                                        Text("Forced: TBD")
                                    }
                                }
                                .padding(.vertical, 10)
                                .padding(.leading)
                                
                                Rectangle().frame(width: nil, height: 1.5, alignment: .bottom).foregroundColor(Color.gray)
                                
                            }
                        }
                    }
                    else{
                        
                        Text("No completed draft rounds yet")
                            .padding()
                        
                    }
                }
            }
        }
        .onReceive(viewModel.draftDoesNotExistAnymore, perform: { _ in
            presentationMode.wrappedValue.dismiss()
        })
        
    }
}

struct DraftBoardView_Previews: PreviewProvider {
    static var previews: some View {
        
        let user = User(uid: "testToddUid", username: "testTodd123")
        
        NavigationView{
            NavigationLink(
                destination: DraftBoardView(viewModel: DraftBoardVM(draft: Draft(data: MockDraftsRepository(user: user) .mockData["draftid1"]!, playerUid: user.uid)!, draftsRepo: MockDraftsRepository(user: user)))
                    .navigationBarTitle("", displayMode: .inline),
                isActive: .constant(true),
                label: {
                    Text("")
                })
            
        }
        
        
    }
}
