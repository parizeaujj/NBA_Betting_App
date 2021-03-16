//
//  RootAppVM.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/14/21.
//

import Combine

class RootAppVM<T: ObservableObject & AppStateProtocol>: ObservableObject {
    
    @Published var isLoggedIn: Bool = false {
        didSet {
            if oldValue && !isLoggedIn {
                self.appState.deinitializeAllRepos()
            }
        }
    }
    
    @Published var doesHaveUsername: Bool = false
    
    private var cancellables: [AnyCancellable] = []
    
    private(set) var appState: T
    
    init(appState: T){
        
        self.appState = appState
        
        listenForAuthChanges()
    }
    
    private func listenForAuthChanges(){
        
        self.appState.userService.userPublisher
            .sink { user in
                
                if user != nil {
                    
                    if(user!.username != nil ){
                        self.doesHaveUsername = true
                        self.isLoggedIn = true
                    }
                    else{
                        self.isLoggedIn = true
                    }
                    
                }
                else{
                    self.doesHaveUsername = false
                    self.isLoggedIn = false
                }
            }
            .store(in: &cancellables)
    }
}
