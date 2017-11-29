//
//  ViewController.swift
//  TestApplication
//
//  Created by Tamas Sagi on 02/07/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var FuckThatLbl: UILabel!
    @IBOutlet weak var textField: UITextField!

    @IBAction func fuckThisButton(_ sender: UIButton) {
        FuckThatLbl.text = "no fuck this"
    }

    @IBAction func changeLblButton(_ sender: UIButton) {
        FuckThatLbl.text = textField.text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

