//
//  CreateUsernameVM.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/24/21.
//
import Foundation

enum UsernameError {
    
    case InvalidLength
    case AlreadyTaken
    case None
}

class CreateUsernameVM: ObservableObject {
    
    private let userService: UserService
   
    @Published var usernameError: UsernameError = .None
    @Published var username: String = "" {
        
        didSet {
            if username.count > 16 && oldValue.count <= 16 {
                username = oldValue
            }
            
            // if there was previously an invalid length error, and the user has since fixed, then get rid of that as an error
            if usernameError == .InvalidLength && username.count >= 6 {
                usernameError = .None
            }
            
            // if there was previously a 'username already taken' error, and the user has since changed the text in the textfield, then stop showing that error message
            else if(usernameError == .AlreadyTaken && username != oldValue){
                usernameError = .None
            }
            
        }
    }
    
    
    init(userService: UserService){
        self.userService = userService
    }
    
    func submitButtonWasPressed(){
        
        if(isInvalidLength()){
            self.usernameError = .InvalidLength
            return
        }
        
        
        userService.setUsernameIfNotTaken(username: self.username){ resultType in
            switch(resultType){
            
                case .Success:
                    self.userService.doesHaveUsername = true
                    print("username added to database")
                    return
                    
                case .UsernameTaken:
                    self.usernameError = .AlreadyTaken
                    print("username already taken")
                    return
                    
                case .UserHasUsernameAlready:
                    print("user has username already")
                    return
                    
                default:
                    print("something went wrong")
                    return
            }
        }
    }
    
    func isInvalidLength() -> Bool {
        return self.username.count < 6
    }
    
}
