//
//  MessageViewController.swift
//  FriendlyChat
//
//  Created by Tamas Sagi on 07/06/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import UIKit
import FirebaseAuth

class MessageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButton(_ sender: UIButton){
        do {
            try FIRAuth.auth()?.signOut()
        } catch let error as NSError {
            print("ERROR signing out\(error)")
        }
        performSegue(withIdentifier: "logoutSegue", sender: nil)
    }
    
    
    
}
