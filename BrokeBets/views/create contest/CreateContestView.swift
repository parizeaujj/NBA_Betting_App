//
//  CreateContestView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/4/21.
//

import SwiftUI

struct CreateContestView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var userService: UserService
    
    @StateObject var createContestVM = CreateContestVM()
    
    @State private var selectedNumRounds = 5
    //    @State private var selectedHours = 12
    
    let numRoundsOptions = [Int](1...10)
    //    let options = ["1 hour", "4 hours", "8 hours", "12 hours", "1 day", "2 days", "3 days", "1 week", "Never"]
    
    @State var isDraftRoundsOpen = false
    //    @State var isExpirationOpen = false
    
    var body: some View {
        
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
                                destination: OpponentSearchView(opponentSearchVM: OpponentSearchVM(currentSelectedUsername: createContestVM.selectedOpponentUsername, setOpponentSelection: { username in
                                        createContestVM.setSelectedUsername(username: username)
                                }, userService: appState.userService
                                )
                                )
                                ,
                                isActive: $createContestVM.isSearchScreenActive,
                                label: {
                                    
                                    if let username = createContestVM.selectedOpponentUsername {
                                        
                                        ChosenOpponentChip(username: username)
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
                                    Text("\(selectedNumRounds)")
                                        .foregroundColor(isDraftRoundsOpen ? .blue : .black)
                                }
                            })
                        }
                        .padding(.vertical, 5)
                        
                        if(isDraftRoundsOpen){
                            Picker("", selection: $selectedNumRounds) {
                                ForEach(numRoundsOptions, id: \.self) {
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
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Send Contest Invitation")
                            .foregroundColor(Color.white)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding([.vertical], 15)
                            .background(Color(UIColor.systemBlue).opacity(createContestVM.selectedOpponentUsername == nil ? 0.4 : 1.0))
                            .cornerRadius(25)
                    })
                    .disabled(createContestVM.selectedOpponentUsername == nil)
                    .padding(.bottom, 50)
                    .padding(.horizontal, 45)
                    
                   
                }
               
            }
            .navigationBarTitle("New Contest", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Cancel")
                    .foregroundColor(.white)
            }))
           
        }
        .accentColor(.white)
//        .background(Color.white)
        .environment(\.colorScheme, .light)
    }
}


struct CreateContestView_Previews: PreviewProvider {
    static var previews: some View {
        CreateContestView()
            .preferredColorScheme(.dark)
            .environmentObject(UserService())
            .environmentObject(AppState())
    }
}
