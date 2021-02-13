//
// code via https://swiftuirecipes.com/blog/top-tabs-in-swiftui
//

import SwiftUI

struct Tabs<Label: View>: View {
    
    @Binding var tabs: [String] // The tab titles
    @Binding var selection: Int // Currently selected tab
    
    let underlineColor: Color // Color of the underline of the selected tab
    
    
    // Tab label rendering closure - provides the current title and if it's the currently selected tab
    let label: (String, Bool) -> Label
    
    var body: some View {

            HStack(alignment: .center, spacing: 0) {
                
              
                    ForEach(tabs, id: \.self) {
                        self.tab(title: $0)
                    }
                
            }.frame(maxWidth: .infinity)
    }
    
    private func tab(title: String) -> some View {
        
        let index = self.tabs.firstIndex(of: title)!
        let isSelected = index == selection
        
        return Button(action: {
            withAnimation {
                self.selection = index
            }
        }) {
            label(title, isSelected)
                .overlay(Rectangle()
                            .frame(height: 4).padding(.bottom, 1)
                         
                // The underline is visible only for the currently selected tab
                .foregroundColor(isSelected ? underlineColor : .clear)
                .padding(.top, 2)
                // Animates the tab selection
                .transition(.move(edge: .bottom)) ,alignment: .bottomLeading)
        }
    }
}

