//
//  OpponentSearchVM.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/6/21.
//

import Foundation

class OpponentSearchVM: ObservableObject {
    
    private var userService: UserServiceProtocol
    
    @Published var usernameText: String = "" {
        didSet {
            if usernameText != "" {
                updateSearchResults()
            }
            else{
                searchResults = []
            }
        }
    }
    
    @Published var searchResults: [User] = []
    
    var currentSelectedUsername: String? = nil
    var setOpponentSelection: (String?) -> Void
    
    init(currentSelectedUsername: String?, setOpponentSelection: @escaping (String?) -> Void, userService: UserServiceProtocol){
        self.currentSelectedUsername = currentSelectedUsername
        self.setOpponentSelection = setOpponentSelection
        self.userService = userService
    }
    
    func updateSearchResults(){
        
        userService.getUsernames(startingWith: self.usernameText){ users in
            
            if let users = users {
                self.searchResults = users
            }
            else{
                // error searching for users, present alert
                print("error searching for users")
            }
        }
    }
}
