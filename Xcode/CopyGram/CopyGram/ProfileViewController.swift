//
//  ProfileViewController.swift
//  CopyGram
//
//  Created by Tamas Sagi on 02/06/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.init(red: 72/255, green: 72/255, blue: 72/255, alpha: 0.3).cgColor
        button.backgroundColor = UIColor.clear
    }
    
    //TODO get profile picture
    
    @IBAction func logoutButton(_ sender: UIButton) {
        AuthServices.shared.logoutCurrentUser()
        present(UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInViewController"), animated: true, completion: nil)
    }
}
