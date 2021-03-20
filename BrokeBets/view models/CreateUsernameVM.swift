//
//  CreateUsernameVM.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/24/21.
//
import Foundation

enum UsernameError: String {
    
    case InvalidLength = "Username must be at least 6 characters"
    case AlreadyTaken = "Username already taken"
    case None = ""
}

class CreateUsernameVM: ObservableObject {
    
    private var userService: UserServiceProtocol
   
    @Published var shouldBeDisabled = true
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
            
            // enables the button if no network call is happening, the input is not nil, and the button is currently disabled
            if(!isSubmitting && username != "" && shouldBeDisabled){
                shouldBeDisabled = false
            }
        }
    }
    @Published var isSubmitting = false {
        didSet {
            
            // if isSubmitting was changed to true then disable the button
            if isSubmitting {
                shouldBeDisabled = true
            }
        }
    }
    
    
    init(userService: UserServiceProtocol){
        self.userService = userService
    }
    
    func submitButtonWasPressed(){
        
        if(isInvalidLength()){
            self.usernameError = .InvalidLength
            return
        }
        
        // disable button until database call is complete
        isSubmitting = true
        
        userService.setUsernameIfNotTaken(username: self.username){ resultType in
            switch(resultType){
            
                case .Success:
                    
                    guard let uid = self.userService.currentUserUid() else {
                        fatalError("something is really wrong, the user is in the process of creating a username for their account but they are not logged in")
                    }
                    
                    self.userService.user = User(uid: uid, username: self.username)
                    
//                    self.userService.doesHaveUsername = true
                    print("username added to database")
                    return
                    
                case .UsernameTaken:
                    self.usernameError = .AlreadyTaken
                    self.isSubmitting = false
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
