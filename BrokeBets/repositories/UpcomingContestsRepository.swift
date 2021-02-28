//
//  File.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/20/21.
//
import Foundation
import FirebaseFirestore

protocol UpcomingContestsRepositoryProtocol {

    var upcomingContests: [UpcomingContest] { get }
    var upcomingContestsPublisher: Published<[UpcomingContest]>.Publisher { get }
    var upcomingContestsPublished: Published<[UpcomingContest]> { get }
    
    
    func getUpcomingContests() -> Void
    
}

class MockUpcomingContestsRepository: UpcomingContestsRepositoryProtocol, ObservableObject {
    
    @Published var upcomingContests: [UpcomingContest] = []
    var upcomingContestsPublished: Published<[UpcomingContest]> { _upcomingContests }
    var upcomingContestsPublisher: Published<[UpcomingContest]>.Publisher { $upcomingContests }
    
    var dateFormatter: DateFormatter
    
    private var db = Firestore.firestore()
    
    init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yyyy h:mm a"
        
        getUpcomingContests()
    }
    
    func getUpcomingContests() {
        
        db.collection("contests")
            .whereField("contestStatus", isEqualTo: "upcoming")
            .whereField("players", arrayContains: "hyW3nBBstdbQhsRcpoMHWyOActg1")
            .addSnapshotListener { (querySnapshot, error) in
                
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            var contests: [UpcomingContest] = []
            
            // Loops through each upcoming contest from firebase
            for document in documents{
                guard let contest = UpcomingContest(data: document.data(), playerUid: "hyW3nBBstdbQhsRcpoMHWyOActg1") else {
                    print("Issue getting contest")
                    return
                }
                
                contests.append(contest)
            }
            
            // Updates the publisher to the new values
            self.upcomingContests = contests
        }
    }
}

