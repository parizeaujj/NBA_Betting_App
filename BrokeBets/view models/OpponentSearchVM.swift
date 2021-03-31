//
//  OpponentSearchVM.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/6/21.
//

import Foundation

class OpponentSearchVM: ObservableObject {
    
    private var userService: UserServiceProtocol
    
    private var searchCounter = 0
    private var searchResultsCache: [String: [User]] = [:]
    
    private var lastEmptySearch: String = ""
    private var wasLastSearchEmpty: Bool = false
    
    @Published var usernameText: String = "" {
        didSet {
            
            if usernameText != "" {
            
                let sanitizedText = usernameText.filter { $0.isLetter || $0.isNumber }
                
                if usernameText == sanitizedText {
                    
                    if let results = searchResultsCache[usernameText] {
                        searchResults = results
                    }
                    else{
                        updateSearchResults()
                    }
                }
                else{
                    searchResults = []
                }
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
        
        print("searching for users")
        
        userService.getUsers(startingWith: self.usernameText.lowercased()){ [weak self] (users: [User]?, lookupText: String) in
            
            if let users = users {
                
                if let cacheSize = self?.searchResultsCache.count, cacheSize > 20 {
                    self?.searchResultsCache.removeAll()
                }
                
                self?.searchResultsCache[lookupText] = users
                self?.searchResults = users
            }
            else{
                // error searching for users, present alert
                print("error searching for users")
            }
        }
    }
}
