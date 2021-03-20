//
//  DraftPickSelectionVM.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/12/21.
//

import Combine


class DraftPickSelectionVM: ObservableObject {
    
    @Published var draft: Draft
//    @Published var didSelectDraftPick: Bool = false
    
    private let draftId: String
    private var draftsRepo: DraftsRepositoryProtocol
    
    var popToMainDraftsScreen = PassthroughSubject<Void, Never>()
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
            .sink { drafts in
                
                guard let draft = drafts[self.draftId] else {
                    print("draft is no longer in dataset")
                    
                    // pop them back to DraftsListView
                    self.popToMainDraftsScreen.send()
                    return
                }
                
                
                if(!draft.isUserTurn){
                    print("user drafted from another device, pop them back")
                    
                    // pop them back to DraftsListView because it is not their turn anymore
                    self.popToMainDraftsScreen.send()
                    return
                }
                
    
                self.draft = draft
            }
            .store(in: &cancellables)
        
    }
    
    func makeDraftPickSelection(draftPickSelection: DraftPickSelection){
        
        // tbd
        
        print("confirmed drafted pick")
        
        draftsRepo.makeDraftPickSelection(draftPickSelection: draftPickSelection, draft: self.draft){ result in
            
            switch(result){
                case .failure(let error): print(error.localizedDescription)
                case.success():
                    print("draft pick selection successful")
                    self.popToMainDraftsScreen.send()
            }
        }
        
     
        
    }
}
