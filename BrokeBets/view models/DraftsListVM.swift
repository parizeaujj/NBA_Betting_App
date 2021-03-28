//
//  DraftsListVM.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/10/21.
//

import Combine

class DraftsListVM: ObservableObject {
    
    @Published var drafts: [Draft] = []
    
    let draftsRepo: DraftsRepositoryProtocol
    
    private var cancellables: [AnyCancellable] = []
    
    init(draftsRepo: DraftsRepositoryProtocol){
        
        self.draftsRepo = draftsRepo
        
        self.draftsRepo.draftsPublisher
            .sink { [weak self] draftsDict in
                
                let drafts = Array(draftsDict.values)
                
                self?.drafts = drafts.sorted {
                    
                    if($0.isUserTurn != $1.isUserTurn){
                        return $0.isUserTurn && !$1.isUserTurn
                    }
                    
                    return $0.draftExpirationDateTime < $1.draftExpirationDateTime
                }
            }
            .store(in: &cancellables)
        
    }
}
