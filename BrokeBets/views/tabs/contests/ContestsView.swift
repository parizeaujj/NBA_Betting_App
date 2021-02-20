//
//  ContestsView.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/13/21.
//

import SwiftUI

struct ContestsView: View {
    
    
    @EnvironmentObject var userService: UserService
    
    @State private var selectedTab = 0
    
    var body: some View {
        
        NavigationView {
            VStack{
                
                Tabs(tabs: .constant(["Upcoming", "In Progress", "Completed"]),
                           selection: $selectedTab,
                           underlineColor: .white) { title, isSelected in
                             Text(title)
                               .font(.headline)
                               .fontWeight(.semibold)
                               .foregroundColor(isSelected ? .white : .white)
                               .padding(.bottom, 10)
                               .frame(width: UIScreen.main.bounds.size.width / 3)
                                
                }.frame(maxWidth: .infinity).padding(.top, 15).background(Color(UIColor.systemBlue))
                
                
                if(selectedTab == 0){
                    UpcomingContestsListView()
                }
                else if(selectedTab == 1){
                    Text("In Progress")
                }
                else if(selectedTab == 2){
                    Text("Completed")
                }
                else{
                    UpcomingContestsListView()
                }
                
                Spacer()
                
            }
            .background(Color.gray.opacity(0.05))
//            .background(Color(red: 240/255, green: 243/255, blue: 248/255, opacity: 1))
            
           
            .navigationBarTitle("Contests", displayMode: .inline)
            .navigationBarItems(trailing:
                                    
                                    HStack{
                                        Button(action: {
                                            print("pressed")
                                        }, label: {
                                            Image(systemName: "plus.square")
                                                .font(Font.system(.title).bold())
                                        })
                                        .padding(.trailing, 10)
                                        
                                        Button(action: {
                                           
                                            userService.logout()
                                            
                                        }, label: {
                                            Image(systemName: "person.circle")
                                                .font(Font.system(.title).bold())
                                        })
                                    }
            )
            
        }.accentColor(.white)
        
    }
}

struct ContestsView_Previews: PreviewProvider {
    static var previews: some View {
        ContestsView()
    }
}
