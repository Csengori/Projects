//
//  ViewController.swift
//  FireChat
//
//  Created by Tamas Sagi on 16/05/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var bottomLayoutGuideConstraint: NSLayoutConstraint!
    
    @IBAction func loginDidTouch(_ sender: UIButton){
        if nameField?.text != "" {
            FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in
                if let err = error {
                    print(err.localizedDescription)
                    return
                }
                self.performSegue(withIdentifier: "LogInChat", sender: nil)
            })
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let navigationViewController = segue.destination as! UINavigationController
        let channelViewController = navigationViewController.viewControllers.first as! ChannelListUITableViewController
        channelViewController.senderDisplayName = nameField?.text
    }
    
    
}

