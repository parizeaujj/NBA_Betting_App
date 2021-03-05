//
//  CreateContestView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/4/21.
//

import SwiftUI


class CreateContestViewModel: ObservableObject {
    
    
    
    
}
// [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

struct CreateContestView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedNumRounds = 5
    @State private var selectedHours = 12
    
    let numRoundsOptions = [Int](1...10)
//    let options = ["1 hour", "4 hours", "8 hours", "12 hours", "1 day", "2 days", "3 days", "1 week", "Never"]
    
    @State var isDraftRoundsOpen = false
    @State var isExpirationOpen = false
    
    var body: some View {
    
        NavigationView{
            VStack{
                Form {
                    Section {
                        HStack{
                            Text("Opponent:")
                            Spacer()
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Text("Choose Opponent")
                            })
                        }
                        
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
                        
                        if(isDraftRoundsOpen){
                            Picker("", selection: $selectedNumRounds) {
                                ForEach(numRoundsOptions, id: \.self) {
                                    Text(String($0))
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                        }
//
//                        HStack{
//                            Button(action: {
//                                withAnimation{
//                                    isExpirationOpen.toggle()
//                                }
//                            }, label: {
//                                HStack{
//                                    Text("Invitation Experation:")
//                                        .foregroundColor(.black)
//                                    Spacer()
//                                    Text("\(selectedHours) hours")
//                                        .foregroundColor(isExpirationOpen ? .blue : .black)
//                                }
//                            })
//                        }
//
//                        if(isExpirationOpen){
//                            Picker("", selection: $selectedHours) {
//                                ForEach(options, id: \.self) {
//                                    Text(String($0))
//                                }
//                            }
//                            .pickerStyle(WheelPickerStyle())
//                        }
                        
                    }
                }
                
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
                
                Spacer()
            }
            .navigationBarTitle("New Contest", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Cancel")
                    .foregroundColor(.white)
            }))
        }
    }
}



struct CreateContestView2: View {
    

    @State var shouldDisableCancel = false

    @State private var selectedNumRounds = 5
    @State private var selectedHours = 12
    
    let strengths = [Int](1...10)
    let hours = [Int](1...24)

    @State var isDraftRoundsOpen = false
    @State var isExpirationOpen = false
    
    
    var body: some View {
        
        VStack(alignment: .leading){

            Text("Create New Contest")
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            
//            HStack(){
//                Text("Draft Rounds:")
//                    .font(.title2)
//                Text("\(selectedNumRounds)")
//                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
//                    .font(.title2)
//                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                Spacer()
//                Stepper("", value: $selectedNumRounds, in: 1...10)
//                    .fixedSize()
//
//            }
//            .padding(.top, 50)
//
//
            
            
            HStack{
                Text("Opponent:")
//                            .font(.title2)
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Choose Opponent")
//                                .font(.title3)
                })
            }
            
            
            VStack{
            HStack{
                Button(action: {
                     
                    withAnimation{
                        isDraftRoundsOpen.toggle()
//                                isExpirationOpen = false
                    }
                    
                }, label: {
                    HStack{
                        Text("Draft Rounds:")
                        Spacer()
                        Text("\(selectedNumRounds)")
                            .foregroundColor(isDraftRoundsOpen ? .blue : .black)
                    }
                }).buttonStyle(PlainButtonStyle())
                
            }
            
            if(isDraftRoundsOpen){
                Picker("", selection: $selectedNumRounds) {
                    ForEach(strengths, id: \.self) {
                        Text(String($0))
                    }
                }
                .pickerStyle(WheelPickerStyle())
            }
        }
            .padding(.top, 25)
               
            VStack{
                HStack{
                    Button(action: {
                        
                        
                        withAnimation{
                            
//                                    isDraftRoundsOpen = false
                            isExpirationOpen.toggle()
                            
                
                        }
                    }, label: {
                        HStack{
                            Text("Invitation Experation:")
                            Spacer()
                            Text("\(selectedNumRounds) hours")
                                .foregroundColor(isExpirationOpen ? .blue : .black)
                        }
                    }).buttonStyle(PlainButtonStyle())
                    
                }
                
                if(isExpirationOpen){
                    Picker("", selection: $selectedHours) {
                        ForEach(hours, id: \.self) {
                            Text(String($0))
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
            }.padding(.top, 25)
                
            
            
            
            
            
            HStack{
                Text("Opponent:")
                    .font(.title2)
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Choose Opponent")
                        .font(.title3)
                })
            }
            .padding(.top, 25)
            
            Spacer()
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Send Contest Invitation")
                .foregroundColor(Color.white)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding([.vertical], 15)
                .background(Color(UIColor.systemBlue).opacity(true ? 0.4 : 1.0))
                .cornerRadius(25)
            })
            .padding(.bottom, 30)
        }
        .padding(.top, 50)
        .padding(.horizontal)
    }
}

struct CreateContestView_Previews: PreviewProvider {
    static var previews: some View {
        CreateContestView()
//        ContentView2()
    }
}
