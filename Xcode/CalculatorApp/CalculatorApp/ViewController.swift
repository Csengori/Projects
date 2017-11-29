//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Tamas Sagi on 11/07/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(button)
        setupConstraints()
    }
    
    func setupConstraints(){
        //NEED CONSTRAINTS: Y, X, WIDTH, HEIGHT
        
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
    }
    
    let testView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(colorLiteralRed: 240, green: 240, blue: 240, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        return view
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("hello", for: .normal)
        button.backgroundColor = UIColor(Red: 240, Green: 240, Blue: 240)
            button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
}
extension UIColor {
    convenience init(Red r: CGFloat, Green g: CGFloat, Blue b: CGFloat) {
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: 1)
    }
}

