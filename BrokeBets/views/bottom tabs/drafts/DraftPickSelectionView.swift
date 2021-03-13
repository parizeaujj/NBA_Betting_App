//
//  DraftPickSelectionView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/10/21.
//

import SwiftUI


struct DraftPickSelectionView: View {
    
    @StateObject var viewModel: DraftPickSelectionVM
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack{
            
            Color.white
            
//            Color.gray.opacity(0.1)
//                .edgesIgnoringSafeArea(.bottom)
            
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
                            Text("\(viewModel.draft.totalRounds)")
                                .fontWeight(.bold)
                            
                            Spacer()
                        }
                    }
                    .padding(.horizontal)
                    
                    Rectangle().frame(width: nil, height: 1.5, alignment: .bottom).foregroundColor(Color.gray)
                }
                .background(Color.white)
                
                ScrollView {
                    
                    LazyVStack(spacing: 15){
                        
                        
                        ForEach(viewModel.draft.gamesPool){ game in
                            
                            AvailableDraftGameView(game: game)
                            
                        }
                        
                    }
                    .padding(.horizontal, 8)
                }
              
                Spacer()
                
                
            }
        }
        .onReceive(viewModel.draftDoesNotExistAnymore, perform: { _ in
            presentationMode.wrappedValue.dismiss()
        })
    }
}

struct DraftPickSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            NavigationLink(
                destination: DraftPickSelectionView(viewModel: DraftPickSelectionVM(draft: Draft(data: MockDraftsRepository().mockData["draftid1"]!, playerUid: "testToddUid")!, draftsRepo: MockDraftsRepository()))
                    .navigationBarTitle("", displayMode: .inline),
                isActive: .constant(true),
                label: {
                    Text("")
                })
            
        }
   
    }
}
