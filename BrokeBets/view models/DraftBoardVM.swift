//
//  DraftBoardVM.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/13/21.
//

import Combine

class DraftBoardVM: ObservableObject {
    
    @Published var draft: Draft
    
    private let draftId: String
    private var draftsRepo: DraftsRepositoryProtocol
    
    var draftDoesNotExistAnymore = PassthroughSubject<Void, Never>()
    var cancellables: [AnyCancellable] = []
    
    init(draft: Draft, draftsRepo: DraftsRepositoryProtocol){
        
        let draftId = draft.draftId
        self.draftId = draftId
        self.draft = draft
        self.draftsRepo = draftsRepo
        
        listenForDraftChanges()
    }
    
    func listenForDraftChanges(){
        
        self.draftsRepo.draftsPublisher
            .sink { [weak self] drafts in
                
                guard let draft = drafts[self!.draftId] else {
                    print("draft is no longer in dataset")
                    
                    // pop them back to DraftsListView
                    self?.draftDoesNotExistAnymore.send()
                    return
                }
                
                self?.draft = draft
            }
            .store(in: &cancellables)
    }
}
