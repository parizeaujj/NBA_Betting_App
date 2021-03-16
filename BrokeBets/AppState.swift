//
//  AppState.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/14/21.
//

import Foundation
import Combine
import Firebase

protocol AppStateProtocol: ObservableObject {
    
    var userService: UserServiceProtocol { get }
    var draftsRepo: DraftsRepositoryProtocol? { get }
    var receivedInvitationsRepo: ReceivedInvitationsRepositoryProtocol? { get }
    var sentInvitationsRepo: SentInvitationsRepositoryProtocol? { get }
    var upcomingContestsRepo: UpcomingContestsRepositoryProtocol? { get }
    var completedContestsRepo: CompletedContestsRepositoryProtocol? { get }
    var inProgressContestsRepo: InProgressContestsRepositoryProtocol? { get }
    
    func deinitializeAllRepos()
}


class MockAppState: AppStateProtocol {
    
    private(set) var userService: UserServiceProtocol
    private(set) var draftsRepo: DraftsRepositoryProtocol?
    private(set) var receivedInvitationsRepo: ReceivedInvitationsRepositoryProtocol?
    private(set) var sentInvitationsRepo: SentInvitationsRepositoryProtocol?
    private(set) var upcomingContestsRepo: UpcomingContestsRepositoryProtocol?
    private(set) var completedContestsRepo: CompletedContestsRepositoryProtocol?
    private(set) var inProgressContestsRepo: InProgressContestsRepositoryProtocol?
    
    
    init(){
        
        let uid = "testToddUid"
        self.userService = MockUserService()
        self.userService.user = User(uid: uid, username: "todd123")
        
        draftsRepo = MockDraftsRepository(uid: uid)
        receivedInvitationsRepo = MockReceivedInvitationsRepository(uid: uid)
        sentInvitationsRepo = MockSentInvitationsRepository(uid: uid)
        upcomingContestsRepo = MockUpcomingContestsRepository(uid: uid)
        completedContestsRepo = MockCompletedContestsRepository(uid: uid)
        inProgressContestsRepo = MockInProgressContestsRepository(uid: uid)
    }
    
    func deinitializeAllRepos(){
        self.draftsRepo = nil
        self.receivedInvitationsRepo = nil
        self.sentInvitationsRepo = nil
        self.upcomingContestsRepo = nil
        self.inProgressContestsRepo = nil
        self.completedContestsRepo = nil
    }
}

class AppState: AppStateProtocol {
    
    private(set) var userService: UserServiceProtocol
    private(set) var draftsRepo: DraftsRepositoryProtocol?
    private(set) var receivedInvitationsRepo: ReceivedInvitationsRepositoryProtocol?
    private(set) var sentInvitationsRepo: SentInvitationsRepositoryProtocol?
    private(set) var upcomingContestsRepo: UpcomingContestsRepositoryProtocol?
    private(set) var completedContestsRepo: CompletedContestsRepositoryProtocol?
    private(set) var inProgressContestsRepo: InProgressContestsRepositoryProtocol?
    
    
    private var cancellables: [AnyCancellable] = []
    

    init(shouldByPassLogin: Bool = false){
        
       
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        
        if(shouldByPassLogin){
            
            let uid = "hyW3nBBstdbQhsRcpoMHWyOActg1"
            self.userService = MockUserService()
            self.userService.user = User(uid: uid, username: "testTodd123")
            
            self.initializeAllRepos(uid: uid)
        }
        else{
            
            self.userService = UserService()
            
            userService.userPublisher.sink { user in
                
                guard let user = user, user.username != nil else {
                    self.deinitializeAllRepos()
                    return
                }
                
                self.initializeAllRepos(uid: user.uid)
                
            }
            .store(in: &cancellables)
            
        }
    }
    
    private func initializeAllRepos(uid: String){
        
        draftsRepo = DraftsRepository(uid: uid)
        receivedInvitationsRepo = ReceivedInvitationsRepository(uid: uid)
        sentInvitationsRepo = SentInvitationsRepository(uid: uid)
        upcomingContestsRepo = UpcomingContestsRepository(uid: uid)
        completedContestsRepo = CompletedContestsRepository(uid: uid)
        inProgressContestsRepo = InProgressContestsRepository(uid: uid)
    }
    
    
    func deinitializeAllRepos(){
        draftsRepo = nil
        receivedInvitationsRepo = nil
        sentInvitationsRepo = nil
        upcomingContestsRepo = nil
        completedContestsRepo = nil
        inProgressContestsRepo = nil
    }
}

