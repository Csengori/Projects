//
//  ViewController.swift
//  TweetClone
//
//  Created by Tamas Sagi on 17/05/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        
        
    }
    
    func handleLogout(){
        let loginController = LoginViewController()
        present(loginController, animated: true, completion: nil)
    }
    
}

