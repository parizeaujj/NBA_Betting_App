//
//  TestBottomSheet.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/1/21.
//

import SwiftUI

struct TestBottomSheet: View {
    
    @State var isShowingSheet = false
    
    var body: some View {
        Button(action: {
            isShowingSheet.toggle()
        }) {
            Text("Show License Agreement")
        }
        .sheet(isPresented: $isShowingSheet,
               onDismiss: didDismiss) {
            VStack {
                
                Text("License Agreement")
                    .frame(width: 300, height: 100)
                   
//                Button("Dismiss",
//                       action: { isShowingSheet.toggle() })
            }.frame(maxHeight: 300)
        }
        
        
    }
    
    func didDismiss() {
        // Handle the dismissing action.
    }
}

struct TestBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        TestBottomSheet()
    }
}
