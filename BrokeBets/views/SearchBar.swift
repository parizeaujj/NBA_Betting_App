//
//  SearchBar.swift
//  BrokeBets
//
//  Created by Fabrizio Herrera on 3/3/21.
//

import Foundation
import SwiftUI
import Firebase

struct SearchBarView: View {
    
    @StateObject var data = getData()
    
    var body: some View {
        
            ZStack(alignment: .top) {
               
                GeometryReader {_ in
                    
                    SearchBar(data: self.$data.data)
                        .padding(.top)
                    
                }
                
            }.background(Color.gray.opacity(0.2)).edgesIgnoringSafeArea(.all)
    }
}

struct SearchBar: View {
    
    @State var text = ""
    @Binding var data: [dataType]
    
    var body: some View {
        
        VStack(spacing: 0){
            
            HStack {
                
                TextField("Enter a username", text: self.$text)
                    .autocapitalization(.none)
                    .keyboardType(.asciiCapable)
                    .disableAutocorrection(true)
                    
                if self.text != "" {
                    Button(action: {
                        
                        self.text = ""
                        
                    }) {
                        
                        Text("Cancel")
                        
                    }
                    .foregroundColor(.black)
                }
            }.padding()
            
            if self.text != "" {
                
                if
                    self.data.filter({
                                        $0.username.lowercased().contains(self.text.lowercased())
                        
                    }).count == 0 {
                    
                    Text("Username not found").foregroundColor(Color.black.opacity(0.5)).padding()
                }
                else {
                    
                    List(self.data.filter{
                            $0.username.lowercased().contains(self.text.lowercased())
                        
                    }){document in
                        
                        Text(document.username)
                        
                    }.frame(height: UIScreen.main.bounds.height / 5)
                }
            }
            
        }.background(Color.white)
        .padding()
        
    }
}

class getData: ObservableObject {
    
    @Published var data = [dataType]()
    
    let db = Firestore.firestore()
    
    init() {
        
        db.collection("users").getDocuments { (querySnapshot, error) in
            
            if error != nil {
                
                print((error?.localizedDescription)!)
                return
            }
            
            for document in querySnapshot!.documents {
                
                let userID = document.documentID
                let username = document.get("username") as! String
                
                self.data.append(dataType(id: userID, username: username))
            }
        }
    }
}

struct dataType: Identifiable {
    var id: String
    var username: String
}

struct SearchBarView_Previews: PreviewProvider {
    
    static var previews: some View {
   
        SearchBarView().environmentObject(UserScreenInfo(.regular))
    }
}
