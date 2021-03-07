//
//  CreateContestVM.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/7/21.
//

import Foundation

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
    
    // To be implemented...
    func sendContestInvitation(){
        print("send contest invitation button pressed")
    }
}
