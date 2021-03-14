//
//  AppState.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/14/21.
//

import Foundation
import Combine

protocol AppStateProtocol {
    
    var userService: UserServiceProtocol { get }
    var draftsRepo: DraftsRepositoryProtocol? { get }
    var upcomingContestsRepo: UpcomingContestsRepositoryProtocol? { get }
    var completedContestsRepo: CompletedContestsRepositoryProtocol? { get }
    var inProgressContestsRepo: InProgressContestsRepositoryProtocol? { get }
    func deinitializeAllRepos()
}


class MockAppState: ObservableObject, AppStateProtocol {
    
    private(set) var userService: UserServiceProtocol
    private(set) var draftsRepo: DraftsRepositoryProtocol?
    private(set) var upcomingContestsRepo: UpcomingContestsRepositoryProtocol?
    private(set) var completedContestsRepo: CompletedContestsRepositoryProtocol?
    private(set) var inProgressContestsRepo: InProgressContestsRepositoryProtocol?
    
    init(){
        
        let uid = "testToddUid"
        self.userService = MockUserService()
        self.userService.user = User(uid: uid, username: "todd123")
        
        draftsRepo = MockDraftsRepository(uid: uid)
        upcomingContestsRepo = MockUpcomingContestsRepository(uid: uid)
        completedContestsRepo = MockCompletedContestsRepository(uid: uid)
        inProgressContestsRepo = MockInProgressContestsRepository(uid: uid)
    }
    
    func deinitializeAllRepos(){
        self.draftsRepo = nil
        self.upcomingContestsRepo = nil
        self.inProgressContestsRepo = nil
        self.completedContestsRepo = nil
    }
}

class AppState: ObservableObject, AppStateProtocol {
    
    private(set) var userService: UserServiceProtocol
    private(set) var draftsRepo: DraftsRepositoryProtocol?
    private(set) var upcomingContestsRepo: UpcomingContestsRepositoryProtocol?
    private(set) var completedContestsRepo: CompletedContestsRepositoryProtocol?
    private(set) var inProgressContestsRepo: InProgressContestsRepositoryProtocol?
    
    
    private var cancellables: [AnyCancellable] = []
    
    init(){
        
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
    
    private func initializeAllRepos(uid: String){
        
        draftsRepo = DraftsRepository(uid: uid)
        upcomingContestsRepo = UpcomingContestsRepository(uid: uid)
        completedContestsRepo = CompletedContestsRepository(uid: uid)
        inProgressContestsRepo = InProgressContestsRepository(uid: uid)
    }
    
    
    func deinitializeAllRepos(){
        draftsRepo = nil
        upcomingContestsRepo = nil
        completedContestsRepo = nil
        inProgressContestsRepo = nil
    }
}

