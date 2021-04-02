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
    var createContestInvitationService: CreateContestInvitationServiceProtocol? { get }
    var draftsRepo: DraftsRepositoryProtocol? { get }
    var receivedInvitationsRepo: ReceivedInvitationsRepositoryProtocol? { get }
    var sentInvitationsRepo: SentInvitationsRepositoryProtocol? { get }
    var upcomingContestsRepo: UpcomingContestsRepositoryProtocol? { get }
    var completedContestsRepo: CompletedContestsRepositoryProtocol? { get }
    var inProgressContestsRepo: InProgressContestsRepositoryProtocol? { get }
    var doesHavePermissionForAppIconBadge: Bool { get }
    func deinitializeAllRepos()
    func askPermissionToShowBadgeValueOnAppIcon()
}


class MockAppState: AppStateProtocol {
    
    private(set) var doesHavePermissionForAppIconBadge: Bool = false
    private(set) var userService: UserServiceProtocol
    private(set) var createContestInvitationService: CreateContestInvitationServiceProtocol?
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
        
        createContestInvitationService = MockCreateContestInvitationService(user: self.userService.user!)
        draftsRepo = MockDraftsRepository(user: self.userService.user!)
        receivedInvitationsRepo = MockReceivedInvitationsRepository(user: self.userService.user!)
        sentInvitationsRepo = MockSentInvitationsRepository(uid: uid)
        upcomingContestsRepo = MockUpcomingContestsRepository(uid: uid)
        completedContestsRepo = MockCompletedContestsRepository(uid: uid)
        inProgressContestsRepo = MockInProgressContestsRepository(uid: uid)
        
        askPermissionToShowBadgeValueOnAppIcon()
    }
    
    func deinitializeAllRepos(){
        self.draftsRepo = nil
        self.receivedInvitationsRepo = nil
        self.sentInvitationsRepo = nil
        self.upcomingContestsRepo = nil
        self.inProgressContestsRepo = nil
        self.completedContestsRepo = nil
    }
    
    func askPermissionToShowBadgeValueOnAppIcon() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge]){ success, error in
            
            if success {
                print("Successfully got permission")
                self.doesHavePermissionForAppIconBadge = true
            }
            else if let error = error {
                print(error.localizedDescription)
                self.doesHavePermissionForAppIconBadge = false
            }
        }
    }
}

class AppState: AppStateProtocol {
    
    private(set) var doesHavePermissionForAppIconBadge: Bool = false
    private(set) var userService: UserServiceProtocol
    private(set) var createContestInvitationService: CreateContestInvitationServiceProtocol?
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
            self.userService = UserService(shouldByPassLogin: shouldByPassLogin)
            let user = User(uid: uid, username: "testTodd123")
            self.userService.user = user
            self.createContestInvitationService = CreateContestInvitationService(user: user)
            self.initializeAllRepos(user: user)
        }
        else{
            
            self.userService = UserService()
           
            userService.userPublisher.sink { user in
                
                guard let user = user, user.username != nil else {
                    print("deinitializing repos")
                    self.deinitializeAllRepos()
                    return
                }
                
                print("right hereeeeeeee \(user.username ?? "none" )")
                self.createContestInvitationService = CreateContestInvitationService(user: user)
                self.initializeAllRepos(user: user)
                
            }
            .store(in: &cancellables)
            
        }
        
        askPermissionToShowBadgeValueOnAppIcon()
    }
    
    private func initializeAllRepos(user: User){
        
        print("initializing repos")
        draftsRepo = DraftsRepository(user: user)
        receivedInvitationsRepo = ReceivedInvitationsRepository(user: user)
        sentInvitationsRepo = SentInvitationsRepository(uid: user.uid)
        upcomingContestsRepo = UpcomingContestsRepository(uid: user.uid)
        completedContestsRepo = CompletedContestsRepository(uid: user.uid)
        inProgressContestsRepo = InProgressContestsRepository(uid: user.uid)
    }
    
    
    func deinitializeAllRepos(){
        draftsRepo = nil
        receivedInvitationsRepo = nil
        sentInvitationsRepo = nil
        upcomingContestsRepo = nil
        completedContestsRepo = nil
        inProgressContestsRepo = nil
    }
    
    func askPermissionToShowBadgeValueOnAppIcon() {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge]){ success, error in
            
            if success {
                print("Successfully got permission")
                self.doesHavePermissionForAppIconBadge = true
            }
            else if let error = error {
                print(error.localizedDescription)
                self.doesHavePermissionForAppIconBadge = false
            }
        }
        
        
    }
}

