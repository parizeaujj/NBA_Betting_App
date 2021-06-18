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
    
    var selectedMainTab: Int { get set }
    var selectedMainTabPublisher: Published<Int>.Publisher { get }
    var selectedMainTabPublished: Published<Int> { get }
    
    var selectedSubTab: Int { get set }
    var selectedSubTabPublisher: Published<Int>.Publisher { get }
    var selectedSubTabPublished: Published<Int> { get }
    
    var selectedSubTabs: [Int] { get set }
    var selectedSubTabsPublisher: Published<[Int]>.Publisher { get }
    var selectedSubTabsPublished: Published<[Int]> { get }
    
    var userService: UserServiceProtocol? { get }
    var createContestInvitationService: CreateContestInvitationServiceProtocol? { get }
    var draftsRepo: DraftsRepositoryProtocol? { get }
    var receivedInvitationsRepo: ReceivedInvitationsRepositoryProtocol? { get }
    var sentInvitationsRepo: SentInvitationsRepositoryProtocol? { get }
    var upcomingContestsRepo: UpcomingContestsRepositoryProtocol? { get }
    var completedContestsRepo: CompletedContestsRepositoryProtocol? { get }
    var inProgressContestsRepo: InProgressContestsRepositoryProtocol? { get }
    var doesHavePermissionForAppIconBadge: Bool { get }
    func deepLink(to appLocation: (mainTabInd: Int, subTabInd: Int))
    func currentAppLocation() -> (mainTabInd: Int, subTabInd: Int)
    
    func deinitializeAllRepos()
}


class MockAppState: AppStateProtocol {
    
    @Published var selectedMainTab: Int = 0
    var selectedMainTabPublisher: Published<Int>.Publisher { $selectedMainTab }
    var selectedMainTabPublished: Published<Int> { _selectedMainTab }
    
    
    @Published var selectedSubTab: Int = 0
    var selectedSubTabPublisher: Published<Int>.Publisher { $selectedSubTab }
    var selectedSubTabPublished: Published<Int> { _selectedSubTab }
    
    @Published var selectedSubTabs: [Int] = [0, 0, 0]
    var selectedSubTabsPublisher: Published<[Int]>.Publisher { $selectedSubTabs }
    var selectedSubTabsPublished: Published<[Int]> { _selectedSubTabs }
    
    
    private(set) var doesHavePermissionForAppIconBadge: Bool = false
    private(set) var userService: UserServiceProtocol?
    private(set) var createContestInvitationService: CreateContestInvitationServiceProtocol?
    private(set) var draftsRepo: DraftsRepositoryProtocol?
    private(set) var receivedInvitationsRepo: ReceivedInvitationsRepositoryProtocol?
    private(set) var sentInvitationsRepo: SentInvitationsRepositoryProtocol?
    private(set) var upcomingContestsRepo: UpcomingContestsRepositoryProtocol?
    private(set) var completedContestsRepo: CompletedContestsRepositoryProtocol?
    private(set) var inProgressContestsRepo: InProgressContestsRepositoryProtocol?
    
    init(){
//        self.configure()
    }
    
    func configure(){
        
        let uid = "testToddUid"
        
        let userService = MockUserService()
        userService.user = User(uid: uid, username: "todd123")
        self.userService = userService
        
        createContestInvitationService = MockCreateContestInvitationService(user: self.userService!.user!)
        draftsRepo = MockDraftsRepository(user: self.userService!.user!)
        receivedInvitationsRepo = MockReceivedInvitationsRepository(user: self.userService!.user!)
        sentInvitationsRepo = MockSentInvitationsRepository(uid: uid)
        upcomingContestsRepo = MockUpcomingContestsRepository(uid: uid)
        completedContestsRepo = MockCompletedContestsRepository(uid: uid)
        inProgressContestsRepo = MockInProgressContestsRepository(uid: uid)
                
    }
    
    func deepLink(to appLocation: (mainTabInd: Int, subTabInd: Int)) {
        self.selectedMainTab = appLocation.mainTabInd
        self.selectedSubTabs[appLocation.mainTabInd] = appLocation.subTabInd
    }
    
    func currentAppLocation() -> (mainTabInd: Int, subTabInd: Int) {
        return (self.selectedMainTab, self.selectedSubTabs[self.selectedMainTab])
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
    
    
    @Published var selectedMainTab: Int = 0
    var selectedMainTabPublisher: Published<Int>.Publisher { $selectedMainTab }
    var selectedMainTabPublished: Published<Int> { _selectedMainTab }
    
    @Published var selectedSubTab: Int = 0
    var selectedSubTabPublisher: Published<Int>.Publisher { $selectedSubTab }
    var selectedSubTabPublished: Published<Int> { _selectedSubTab }
//
//    @Published var selectedInvitationsSubTab: Int = 0
//    var selectedSubTabPublisher: Published<Int>.Publisher { $selectedInvitationsSubTab }
//    var selectedSubTabPublished: Published<Int> { _selectedInvitationsSubTab }
//
    @Published var selectedSubTabs: [Int] = [0, 0, 0]
    var selectedSubTabsPublisher: Published<[Int]>.Publisher { $selectedSubTabs }
    var selectedSubTabsPublished: Published<[Int]> { _selectedSubTabs }
    
    
    
    private(set) var doesHavePermissionForAppIconBadge: Bool = false
    private(set) var userService: UserServiceProtocol?
    private(set) var createContestInvitationService: CreateContestInvitationServiceProtocol?
    private(set) var draftsRepo: DraftsRepositoryProtocol?
    private(set) var receivedInvitationsRepo: ReceivedInvitationsRepositoryProtocol?
    private(set) var sentInvitationsRepo: SentInvitationsRepositoryProtocol?
    private(set) var upcomingContestsRepo: UpcomingContestsRepositoryProtocol?
    private(set) var completedContestsRepo: CompletedContestsRepositoryProtocol?
    private(set) var inProgressContestsRepo: InProgressContestsRepositoryProtocol?
    

    private var shouldByPassLogin: Bool
    private var cancellables: [AnyCancellable] = []
    
    
    init(shouldByPassLogin: Bool = false){
        
        self.shouldByPassLogin = shouldByPassLogin
        
    }
    
    func deepLink(to appLocation: (mainTabInd: Int, subTabInd: Int)){
        
        self.selectedMainTab = appLocation.mainTabInd
        self.selectedSubTabs[appLocation.mainTabInd] = appLocation.subTabInd
    }
    
    func currentAppLocation() -> (mainTabInd: Int, subTabInd: Int){
        return (self.selectedMainTab, self.selectedSubTabs[self.selectedMainTab])
    }
    
    func configure(){
        
        if(shouldByPassLogin){
            
            let uid = "hyW3nBBstdbQhsRcpoMHWyOActg1"
            let userService = UserService(shouldByPassLogin: self.shouldByPassLogin)
            let user = User(uid: uid, username: "testTodd123")
            userService.user = user
            self.userService = userService
            self.createContestInvitationService = CreateContestInvitationService(user: user)
            self.initializeAllRepos(user: user)
        }
        else{
            
            self.userService = UserService()
           
            userService!.userPublisher.sink { user in
                
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
}
