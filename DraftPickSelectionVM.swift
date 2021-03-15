//
//  DraftPickSelectionVM.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/12/21.
//

import Combine

enum BetType: String {
    
    case spread = "spread"
    case overUnder = "overUnder"
}

struct DraftPickSelection {
    
    var draftedPick: [String: Any] = [:]
    var inversePick: [String: Any] = [:]
    

    init(gameId: String, round: Int, pick: String, inversePick: String, homeTeam: String, awayTeam: String, betType: BetType){
        
        
        self.draftedPick = ["gameId": gameId, "round": round, "betInfo": pick, "betType": betType.rawValue]
        self.inversePick = ["gameId": gameId, "round": round, "betInfo": inversePick, "betType": betType.rawValue]


        if(betType == .overUnder){
            
            let matchupStr = "(" + homeTeam.split(separator: " ")[0] + " vs " + awayTeam.split(separator: " ")[0] + ")"
            
            let draftedDisplayStr = pick + " " + matchupStr
            let inverseDisplayStr = inversePick + " " + matchupStr
            
            self.draftedPick["betDisplayStr"] = draftedDisplayStr
            self.inversePick["betDisplayStr"] = inverseDisplayStr
        }
        else if(betType == .spread){
            
            let draftedDisplayStr = pick + " (vs " + inversePick.split(separator: " ")[0] + ")"
            let inverseDisplayStr = inversePick + " (vs " + pick.split(separator: " ")[0] + ")"
            
            self.draftedPick["betDisplayStr"] = draftedDisplayStr
            self.inversePick["betDisplayStr"] = inverseDisplayStr
        }
    }
}



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
