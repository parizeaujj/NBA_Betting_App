//
//  DraftsListView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/9/21.
//

import SwiftUI


struct DraftsListView<T: AppStateProtocol>: View {
    
    @EnvironmentObject var appState: T
    @StateObject var draftsListVM: DraftsListVM
    @State private var isCreateContestSheetPresented = false
    @Binding var isShowingProfileModal: Bool
    
    var body: some View {
        
        NavigationView{
            
            ZStack{
                
                Color.gray.opacity(0.0)
            
            VStack(spacing: 0){
                
                Rectangle().fill(Color(UIColor.systemBlue))
                    .frame(width: nil, height: 10)
                
                if(draftsListVM.drafts.count > 0){
                    
                    
                    ScrollView {
                        LazyVStack {
                            ForEach(draftsListVM.drafts) { draft in
                                DraftView(draft: draft, draftsRepo: draftsListVM.draftsRepo)
                                
                            }
                        }
                    }
                    .padding(.top, 30)
                    .padding(.horizontal, 10)
                }
                else{
                    Text("You have no active drafts")
                        .font(.title3)
                        .padding(.top, 100)
                    
                }
                
                Spacer()
            }
                
            }
            .navigationBarTitle("Drafts", displayMode: .inline)
            .navigationBarItems(trailing:
                                    
                                    HStack{
                                        Button(action: {
                                            print("pressed")
                                            isCreateContestSheetPresented = true
                                        }, label: {
                                            Image(systemName: "plus.square")
                                                .font(Font.system(.title).bold())
                                        })
                                        .padding(.trailing, 10)
                                        
                                        Button(action: {
                                        
                                            withAnimation{
                                                isShowingProfileModal = true
                                            }
                                          
                                        }, label: {
                                            Image(systemName: "person.circle")
                                                .font(Font.system(.title).bold())
                                        })
                                    }.padding(.vertical)
            )
            
        }
        .accentColor(.white)
        .fullScreenCover(isPresented: $isCreateContestSheetPresented, content: {CreateContestView(createContestVM: CreateContestVM(createContestInvitationService: appState.createContestInvitationService!, userService: appState.userService!)) })
        .preferredColorScheme(.light)
    }
}

struct DraftsListView_Previews: PreviewProvider {
    static var previews: some View {
        
        DraftsListView<MockAppState>(draftsListVM: DraftsListVM(draftsRepo: MockDraftsRepository(user: User(uid: "testToddUid", username: "testTodd123"))), isShowingProfileModal: .constant(false))
            .environmentObject(MockAppState())
        
    }
}
