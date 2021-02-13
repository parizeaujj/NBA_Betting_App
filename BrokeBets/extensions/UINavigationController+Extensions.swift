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

        let appearance = UINavigationBarAppearance()
        
        appearance.titleTextAttributes = [.foregroundColor : UIColor.white]
        appearance.backgroundColor = .systemBlue
        appearance.shadowColor = .clear
        navigationBar.standardAppearance = appearance
    }
}
