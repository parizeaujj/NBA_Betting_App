//
//  UITabBarController+Extensions.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/13/21.
//

import SwiftUI

extension UITabBarController {
    override open func viewDidLoad() {
        
        super.viewDidLoad()
        
        let standardAppearance = UITabBarAppearance()
        
        standardAppearance.backgroundColor = .white
    
        standardAppearance.backgroundEffect = .none
        
        standardAppearance.stackedLayoutAppearance.normal.iconColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        standardAppearance.stackedLayoutAppearance.selected.iconColor = .black
        standardAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [ .foregroundColor : UIColor(red: 0, green: 0, blue: 0, alpha: 0.7) ]
        standardAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [ .foregroundColor : UIColor.black ]


        tabBar.standardAppearance = standardAppearance
    }
}
