//
//  UiViewExtensions.swift
//  WrittenMyRecipes
//
//  Created by Tamas Sagi on 25/05/2018.
//  Copyright © 2018 Tamas Sagi. All rights reserved.
//

import Foundation
import UIKit

//        self.navigationController?.navigationBar.barTintColor = .white


extension UIViewController{
    public func customAnimation(from direction: String) -> CAAnimation {
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        transition.subtype = direction
        return transition
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
