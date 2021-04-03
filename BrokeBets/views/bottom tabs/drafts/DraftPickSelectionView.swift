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
    
    @State private var didSelectDraftPick: Bool = false
    @State private var selectedDraftPick: DraftPickSelection? = nil
    
    var body: some View {
        
        ZStack{
            
            Color.white
            
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
                        
                        
                        ForEach(viewModel.draft.stillAvailableDraftGames){ game in
                            
                            AvailableDraftGameView(game: game, round: viewModel.draft.currentRound, onDraftPickSelection: { pick in
                                
                                self.selectedDraftPick = pick
                                self.didSelectDraftPick = true
                            })
                            
                        }
                        .padding(.top, 1)
                    }
                    .padding(.horizontal, 8)
                }
              
                Spacer()
                
                
            }
        }
        .alert(isPresented: $didSelectDraftPick, content: {
            Alert(
               
               title: Text("Confirm Draft Selection"),
               message:
                Text("\n" + (self.selectedDraftPick!.draftedPick["betDisplayStr"] as! String)),
               primaryButton:
                   .default(
                   Text("Confirm").foregroundColor(.red),
                     action: {
                        self.viewModel.makeDraftPickSelection(draftPickSelection: self.selectedDraftPick!)
                     }
               )
               ,
               secondaryButton:
                    .destructive(
                       Text("Cancel"), action: {
                            self.selectedDraftPick = nil
                       }
               )
           )
        
        })
        .onReceive(viewModel.popToMainDraftsScreen, perform: { _ in
            presentationMode.wrappedValue.dismiss()
        })
        .colorScheme(.light)
    }
}

struct DraftPickSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        
        let user = User(uid: "testToddUid", username: "testTodd123")
        
        NavigationView{
            NavigationLink(
                destination: DraftPickSelectionView(viewModel: DraftPickSelectionVM(draft: Draft(data: MockDraftsRepository(user: user).mockData["draftid1"]!, playerUid: user.uid)!, draftsRepo: MockDraftsRepository(user: user)))
                    .navigationBarTitle("", displayMode: .inline),
                isActive: .constant(true),
                label: {
                    Text("")
                })
            
        }
   
    }
}
