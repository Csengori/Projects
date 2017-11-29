//
//  RegisterViewController.swift
//  FriendlyChat
//
//  Created by Tamas Sagi on 07/06/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        
        usernameTextField.backgroundColor = UIColor.clear
        emailTextField.backgroundColor = UIColor.clear
        passwordTextField.backgroundColor = UIColor.clear
        
        let usernameBottomLayer = CALayer()
        let emailBottomLayer = CALayer()
        let passwordBottomLayer = CALayer()
        
        usernameBottomLayer.frame = CGRect(x: 0, y: emailTextField.frame.height - 1, width: view.frame.width, height: 1)
        emailBottomLayer.frame = CGRect(x: 0, y: emailTextField.frame.height - 1, width: view.frame.width, height: 1)
        passwordBottomLayer.frame = CGRect(x: 0, y: passwordTextField.frame.height - 1, width: view.frame.width , height: 1)
        
        usernameBottomLayer.backgroundColor = UIColor.black.withAlphaComponent(0.2).cgColor
        emailBottomLayer.backgroundColor = UIColor.black.withAlphaComponent(0.2).cgColor
        passwordBottomLayer.backgroundColor = UIColor.black.withAlphaComponent(0.2).cgColor
        
        //emailTextField.addBottomBorder()
        
        passwordTextField.layer.addSublayer(passwordBottomLayer)
        usernameTextField.layer.addSublayer(usernameBottomLayer)
        
    }
    
    func checkValidUserInput(testinput input1: String) -> Bool{
        if (usernameTextField.text?.isEmpty)! && (passwordTextField.text?.isEmpty)! {
            return false
        }
        else {
            return true
        }
    }
    
    @IBAction func signUpNewUser(_ sender: UIButton){
        
        if let username = usernameTextField.text, let password = passwordTextField.text, !(usernameTextField.text?.isEmpty)! ,!(passwordTextField.text?.isEmpty)! {
            
        }
        
        
        
        
        
        
        
        if checkValidUserInput() {
            FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                if error != nil {
                    print("ERROR creating new user with email and password\(error.debugDescription)")
                }
            })
            
        }
    }
    
    
    @IBAction func alreadyHaveAnAccount(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    
}
extension UITextView {
    func addBottomBorder() {
        let layer = CALayer()
        self.frame = CGRect(x: self.frame.minX, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
    }
}
