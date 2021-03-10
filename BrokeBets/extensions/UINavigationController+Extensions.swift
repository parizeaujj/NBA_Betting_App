//
//  UINavigationController+Extensions.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/13/21.
//

import SwiftUI

extension UINavigationController {
    override open func viewDidLoad() {
        
        super.viewDidLoad()

//        let appearance = UINavigationBarAppearance()
//
//
//        appearance.titleTextAttributes = [.foregroundColor : UIColor.white]
//        appearance.backgroundColor = .systemBlue
//        appearance.shadowColor = .clear
//        navigationBar.standardAppearance = appearance
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.backgroundColor = .systemBlue
        standardAppearance.shadowColor = .clear
        standardAppearance.titleTextAttributes = [.foregroundColor : UIColor.white]
        standardAppearance.largeTitleTextAttributes = [.foregroundColor : UIColor.white]
        
        let compactAppearance = UINavigationBarAppearance()
        compactAppearance.backgroundColor = .systemBlue
        compactAppearance.shadowColor = .clear
        compactAppearance.titleTextAttributes = [.foregroundColor : UIColor.white]
        compactAppearance.largeTitleTextAttributes = [.foregroundColor : UIColor.white]
        
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.backgroundColor = .systemBlue
        scrollEdgeAppearance.shadowColor = .clear
        scrollEdgeAppearance.titleTextAttributes = [.foregroundColor : UIColor.white]
        scrollEdgeAppearance.largeTitleTextAttributes = [.foregroundColor : UIColor.white]
   
        navigationBar.standardAppearance = standardAppearance
        navigationBar.compactAppearance = compactAppearance
        navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
        
//        navigationBar.barTintColor = UIColor.white
//        navigationBar.isTranslucent = false
    }
}
