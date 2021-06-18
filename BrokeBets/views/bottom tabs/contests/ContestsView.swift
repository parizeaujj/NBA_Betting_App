//
//  ContestsView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/13/21.
//

import SwiftUI
import Combine

class ContestsVM<T: AppStateProtocol>: ObservableObject {
    
//    @Published var selectedTab: Int = 0
    
    var cancellables: [AnyCancellable] = []
    var appState: T
    
    init(appState: T){
        self.appState = appState
        
    }
}




struct ContestsView<T: AppStateProtocol>: View {
    
//    @EnvironmentObject var appState: T
    
    @StateObject var appState: T
    @ObservedObject var contestsVM: ContestsVM<T>
    
    
//    @State private var selectedTab = 0
    @State private var isCreateContestSheetPresented = false
    @Binding var isShowingProfileModal: Bool
    
    var body: some View {
        
        NavigationView {
            VStack{
                
                Tabs(tabs: .constant(["Upcoming", "In Progress", "Completed"]),
                     selection: self.$appState.selectedSubTabs[0],
                           underlineColor: .white) { title, isSelected in
                             Text(title)
                               .font(.headline)
                               .fontWeight(isSelected ? .semibold : .regular)
                               .foregroundColor(isSelected ? .white : .white)
                               .padding(.bottom, 10)
                               .frame(width: UIScreen.main.bounds.size.width / 3)
                                
                }
                .frame(maxWidth: .infinity).padding(.top, 15).background(Color(UIColor.systemBlue))
                
                
                // controls which tab is shown for the contests screen
                if(self.appState.selectedSubTabs[0] == 0){
                    
                    if let repo = contestsVM.appState.upcomingContestsRepo {
                        UpcomingContestsListView(viewModel: UpcomingContestsListVM(upcomingContestsRepo: repo))
                    }
                }
                else if(self.appState.selectedSubTabs[0] == 1){
                                        
                    if let repo = contestsVM.appState.inProgressContestsRepo {
                        InProgressContestsListView(viewModel: InProgressContestsListVM(inProgressContestsRepo: repo)
                        )
                    }
                }
                else if(self.appState.selectedSubTabs[0] == 2){
                    
                    if let repo = contestsVM.appState.completedContestsRepo {
                        
                        CompletedContestsListView(viewModel: CompletedContestsListVM(completedContestsRepo: repo))
                    }
                }

                Spacer()
                
            }
            .background(Color.gray.opacity(0.05))
            .navigationTitle("Contests")
            .navigationBarTitleDisplayMode(.inline)
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
                                    }
            )
            
        }
        .accentColor(.white)
        .fullScreenCover(isPresented: $isCreateContestSheetPresented, content: {CreateContestView(createContestVM: CreateContestVM(createContestInvitationService: contestsVM.appState.createContestInvitationService!, userService: contestsVM.appState.userService!)) })
        .preferredColorScheme(.light)
    }
}

struct ContestsView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let appState = MockAppState()
        appState.configure()
        
        return ContestsView<MockAppState>(appState: appState, contestsVM: ContestsVM(appState: appState), isShowingProfileModal: .constant(false))
//            .environmentObject(UserScreenInfo(.regular))
//            .environmentObject(appState)
    }
}
