//
//  AnimatedSuccessHUD.swift
//  BrokeBets
//
//  Created by Todd Weidler on 3/19/21.
//

import SwiftUI

struct ParentView: View {
    
    @State var showingSuccessNotice = false
    @State var opVal: Double = 1.0
    
    var body: some View {
        
        
        ZStack{
            Color.white
        
            VStack{
                
                Spacer()
                
                Button(action: {
//                    withAnimation{
//                        self.showingSuccessNotice.toggle()
//                    }
                    
                    self.showingSuccessNotice.toggle()
                    
                }, label: {
                    Text("Show Notice")
                })
                .opacity(opVal)
                
                
            }

                if showingSuccessNotice {
                    AnimatedSuccessHUD(showingSuccessNotice: $showingSuccessNotice, onAnimationCompletion: {
                        self.opVal = 0
                    })
                        .zIndex(2)
                }
        }
    }
}

struct AnimatedSuccessHUD: View {
    
    @Binding var showingSuccessNotice: Bool
   
    var onAnimationCompletion: () -> Void
    
    var body: some View {
        
    
        VStack(spacing: 0){
            Image(systemName: "checkmark")
                .foregroundColor(Color.gray)
                .font(Font.system(.largeTitle))
            
            Text("Success")
                .foregroundColor(Color.gray)
                .fontWeight(.bold)
                .padding(.top, 10)
                
        }
        .padding()
        .background(Color(red: 240/255, green: 240/255, blue: 240/255))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .animation(.default)
        .transition(AnyTransition.asymmetric(insertion: AnyTransition.scale.animation(Animation.easeInOut(duration: 0.2)), removal: AnyTransition.move(edge: .bottom).combined(with: AnyTransition.opacity).animation(.easeInOut(duration: 0.3))
        ))
        .onAppear(perform: {

            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {

                withAnimation {
                    self.showingSuccessNotice = false
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            onAnimationCompletion()
                    }
                }
            })
        })
    }
}

struct AnimatedSuccessHUD_Previews: PreviewProvider {
    static var previews: some View {
        
        ParentView()
    }
}
