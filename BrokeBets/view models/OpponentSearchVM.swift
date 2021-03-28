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
    
    var currentSelectedUser: User? = nil
    var setOpponentSelection: (User?) -> Void
    
    
    init(currentSelectedUser: User?, setOpponentSelection: @escaping (User?) -> Void, userService: UserServiceProtocol){
        self.currentSelectedUser = currentSelectedUser
        self.setOpponentSelection = setOpponentSelection
        self.userService = userService
    }
    
    func updateSearchResults(){
        
        userService.getUsers(startingWith: self.usernameText){ [weak self] users in
            
            if let users = users {
                self?.searchResults = users
            }
            else{
                // error searching for users, present alert
                print("error searching for users")
            }
        }
    }
}
