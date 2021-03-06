//
//  CreateContestView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/4/21.
//

import SwiftUI




class CreateContestVM: ObservableObject {
    
    @Published var selectedOpponentUsername: String? = nil
    @Published var isSearchScreenActive = false
    
    
    
    init(){
        
        
    }
    
    func setSelectedUsername(username: String?){
        self.selectedOpponentUsername = username
        
        // if they simply deselected a username they previously selected then dont automatically pop them to root view
        if username != nil {
            // pops to root
            self.isSearchScreenActive = false
        }
    }
    
    
    func sendContestInvitation(){
        
        
        
        
    }
}


struct CreateContestView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
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
                            
                            Spacer()
                            
                            NavigationLink(
                                destination: OpponentSearchView(opponentSearchVM: OpponentSearchVM(currentSelectedUsername: createContestVM.selectedOpponentUsername, setOpponentSelection: { username in
                                        createContestVM.setSelectedUsername(username: username)
                                }, userService: userService
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
                            .background(Color(UIColor.systemBlue).opacity(false ? 0.4 : 1.0))
                            .cornerRadius(25)
                    })
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
           
        }.accentColor(.white)
    }
}



struct DetailTestView: View {
    
    @ObservedObject var opponentSearchVM: OpponentSearchVM
    
    
    var body: some View {
        
        VStack(spacing: 10){
            Text("\(opponentSearchVM.currentSelectedUsername ?? "No username selected")")
                        
            Button(action: {
                
                opponentSearchVM.setOpponentSelection("Toddw123")
                
            }, label: {
                Text("choose a username test")
//                    .foregroundColor(.black)
            })
            
            Button(action: {
                
                opponentSearchVM.setOpponentSelection("Cody123")
                
            }, label: {
                Text("choose a different username test")
//                    .foregroundColor(.black)
            })
            
            Button(action: {
                
                opponentSearchVM.setOpponentSelection(nil)
                
            }, label: {
                Text("deselect a username test")
            })
        }.accentColor(.blue)
    }
}

struct CreateContestView_Previews: PreviewProvider {
    static var previews: some View {
        CreateContestView()
            .environmentObject(UserService())
    }
}
