//
//  ViewController.swift
//  Counter
//
//  Created by Tamas Sagi on 25/05/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.text = ""
    }
    
    @IBAction func pressMe(_ sender: UIButton) {
        counter += 1
        textLabel.text = String(counter)
    }
    
}

