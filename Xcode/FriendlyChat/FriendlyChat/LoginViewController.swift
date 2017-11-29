//
//  ViewController.swift
//  FriendlyChat
//
//  Created by Tamas Sagi on 07/06/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var buttons: UIButton!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.layer.cornerRadius = 15
        buttons.layer.cornerRadius = 15
        button.clipsToBounds = true
        buttons.clipsToBounds = true
        
        emailTextField.backgroundColor = UIColor.clear
        passwordTextField.backgroundColor = UIColor.clear
        
        let emailBottomLayer = CALayer()
        let passwordBottomLayer = CALayer()
        
        emailBottomLayer.frame = CGRect(x: 0, y: emailTextField.frame.height - 1, width: view.frame.width, height: 1)
        passwordBottomLayer.frame = CGRect(x: 0, y: passwordTextField.frame.height - 1, width: view.frame.width , height: 1)
        
        emailBottomLayer.backgroundColor = UIColor.black.withAlphaComponent(0.22).cgColor
        passwordBottomLayer.backgroundColor = UIColor.black.withAlphaComponent(0.2).cgColor
        
        emailTextField.layer.addSublayer(emailBottomLayer)
        passwordTextField.layer.addSublayer(passwordBottomLayer)
        
    }
    
    @IBAction func loginUserWithEmailAndPassword(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print("ERROR signing in user with email and password")
                return
            }
            self.performSegue(withIdentifier: "signInSegue", sender: nil)
        })
    }
    
    @IBAction func loginUserAnonymously(_ sender: UIButton){
        FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in
            if error != nil {
                print("ERROR signing in user anonymously \(error.debugDescription)")
                return
            }
            self.performSegue(withIdentifier: "anonymousSegue", sender: nil)
        })
    }
    
    
}

