//
//  ViewController.swift
//  Build Dis Chat
//
//  Created by Tamas Sagi on 18/05/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class MessagesViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(handleNewMessage))
        
        checkIfUserIsLoggedIn()
        
    }
    
    func handleNewMessage(){
        let newMessageController = NewMessageTableViewController()
        let navigationController = UINavigationController(rootViewController: newMessageController)
        present(navigationController, animated: true, completion: nil)
    }
    
    func checkIfUserIsLoggedIn(){
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }else {
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("user").child(uid!).observe(.value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String : AnyObject] {
                    self.navigationItem.title = dictionary["Name"] as? String
                }
                
            }, withCancel: nil
            )}
    }
    
    func handleLogout(){
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginController = LoginViewController()
        present(loginController, animated: true, completion: nil)
    }
    
}

