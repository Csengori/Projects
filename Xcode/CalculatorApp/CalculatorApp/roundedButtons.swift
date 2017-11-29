//
//  roundedButtons.swift
//  CalculatorApp
//
//  Created by Tamas Sagi on 11/07/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import UIKit

@IBDesignable class roundedButtons: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }

}
