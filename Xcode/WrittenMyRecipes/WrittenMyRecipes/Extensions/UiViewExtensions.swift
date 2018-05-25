//
//  UiViewExtensions.swift
//  WrittenMyRecipes
//
//  Created by Tamas Sagi on 25/05/2018.
//  Copyright © 2018 Tamas Sagi. All rights reserved.
//

import Foundation
import UIKit

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
