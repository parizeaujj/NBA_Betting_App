//
//  SearchBar.swift
//  BrokeBets
//
//  Created by Fabrizio Herrera on 3/4/21.
//

import Foundation
import SwiftUI
import Firebase

struct SearchBarView: View {
    
    @ObservedObject var data = getData()
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            GeometryReader {_ in
                
                
            }.background(Color("Color"))
            .edgesIgnoringSafeArea(.all)
            
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        SearchBarView()
    }
}

class getData: ObservableObject {
    
    @Published var data = [dataType]()
    
    init() {
        let db = Firestore.firestore()
        
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
