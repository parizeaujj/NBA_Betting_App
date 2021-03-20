//
//  CreateContestView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/4/21.
//

import SwiftUI

struct CreateContestView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var createContestVM: CreateContestVM
    @State var isDraftRoundsOpen = false
    @State var showingSuccessNotice = false
    @State var showingSuccessNotic334 = false
    
    @State var showErrorMessage = false
    @State var errorMessage: String = ""
    @State var shouldDismissAfter = false
    
    var body: some View {
        
        ZStack{
            
        
        NavigationView{
            ZStack{
                Color.gray.opacity(0.2)
                    .edgesIgnoringSafeArea(.bottom)
                
                VStack{
                    VStack{
                        HStack{
                            Text("Opponent:")
                                .foregroundColor(.black)
                            Spacer()
                            NavigationLink(
                                destination: OpponentSearchView(opponentSearchVM:
                                                    OpponentSearchVM(currentSelectedUser:
                                                                        createContestVM.selectedOpponent,
                                                                        setOpponentSelection: { user in
                                                                            self.createContestVM.setSelectedUser(user: user)
                                                                        
                                                                        },
                                                                        userService: createContestVM.userService)),
                                isActive: $createContestVM.isSearchScreenActive,
                                label: {
                                    if let user = createContestVM.selectedOpponent {
                                        ChosenOpponentChip(username: user.username!)
                                    }
                                    else{
                                        Text("Choose Opponent")
                                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                    }
                                })
                        }
                        .padding(.vertical, 5)
                        
                        Divider()
                        
                        HStack{
                            Button(action: {
                                withAnimation(Animation.default.delay(0.2)){
                                    isDraftRoundsOpen.toggle()
                                }
                            }, label: {
                                HStack{
                                    Text("Draft Rounds:")
                                        .foregroundColor(.black)
                                    Spacer()
                                    Text("\(createContestVM.selectedNumRounds)")
                                        .foregroundColor(isDraftRoundsOpen ? .blue : .black)
                                }
                            })
                        }
                        .padding(.vertical, 5)
                        
                        if(isDraftRoundsOpen){
                            Picker("", selection: $createContestVM.selectedNumRounds) {
                                ForEach(createContestVM.numRoundsOptions, id: \.self) {
                                    Text(String($0))
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                    .padding(.top, 25)
                    
                    Spacer()
                    
                    Button(action: {
                        
                        createContestVM.sendContestInvitation()
                        
                    }, label: {
                        Text("Send Contest Invitation")
                            .foregroundColor(Color.white)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding([.vertical], 15)
                            .background(Color(UIColor.systemBlue).opacity(createContestVM.selectedOpponent == nil || createContestVM.isLoading ? 0.4 : 1.0))
                            .cornerRadius(25)
                    })
                    .disabled(createContestVM.selectedOpponent == nil || createContestVM.isLoading)
                    .padding(.bottom, 50)
                    .padding(.horizontal, 45)
                    
                }
                
                if(showingSuccessNotice){
                    
                    AnimatedSuccessHUD(showingSuccessNotice: $showingSuccessNotice, onAnimationCompletion: {
                        presentationMode.wrappedValue.dismiss()
                    })
                    .zIndex(2)
                   
                }
            }
            .navigationBarTitle("New Contest", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Cancel")
                    .foregroundColor(.white)
//                    .disabled(createContestVM.isLoading)
            }))
           
        }
        .accentColor(.white)
        .environment(\.colorScheme, .light)
//        .onReceive(createContestVM.showSuccessNotice, perform: { _ in
//
//                self.showingSuccessNotice = true
//
//
//
//        })
            
        .alert(isPresented: $showErrorMessage, content: {


            if let result = createContestVM.invitationCreationAttemptFinished.value {

            return Alert(title: Text("Error Creating Invitation"), message: Text("\(result.rawValue)"), dismissButton: .default(Text("Ok"), action: {

                // if there are no games left then pop them back to the main screen since they cant create a contest if there arent any games
                if result == .no_games_left {
                    presentationMode.wrappedValue.dismiss()
                }
                else if result == .not_enough_games_failure {
                    createContestVM.resetDraftRounds()
                }
            })
            )
            }
            else{
                return Alert(title: Text("hello"))
            }
        })
        .onReceive(createContestVM.invitationCreationAttemptFinished, perform: { result in
            
            if result == nil {
                return
            }
            
            switch(result){
            case .success:
                self.showingSuccessNotice = true
            default:
                self.showErrorMessage = true
            }
            
        })
     
            
            if(createContestVM.isLoading){

                Color.gray.opacity(0.2)
//                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .edgesIgnoringSafeArea(.all)

                ProgressView()
                    .scaleEffect(1.4, anchor: .center)
                    .progressViewStyle(CircularProgressViewStyle(tint: .black))


            }
        }

    }
}


struct CreateContestView_Previews: PreviewProvider {
    static var previews: some View {
        
        let appState = MockAppState()
        
        CreateContestView(createContestVM: CreateContestVM(createContestInvitationService: appState.createContestInvitationService!, userService: appState.userService))
            .preferredColorScheme(.dark)
    }
}
