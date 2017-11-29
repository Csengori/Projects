//
//  ViewController.swift
//  CopyGram
//
//  Created by Tamas Sagi on 21/05/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let authServices = AuthServices.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.backgroundColor = UIColor.clear
        passwordTextField.backgroundColor = UIColor.clear
        
        let emailBottomLayer = CALayer()
        let passwordBottomLayer = CALayer()
        
        emailBottomLayer.frame = CGRect(x: 0, y: emailTextField.frame.height - 1, width: 100000, height: 1)
        passwordBottomLayer.frame = CGRect(x: 0, y: passwordTextField.frame.height - 1, width: 10000, height: 1)
        
        emailBottomLayer.backgroundColor = UIColor.black.withAlphaComponent(0.4).cgColor
        passwordBottomLayer.backgroundColor = UIColor.black.withAlphaComponent(0.4).cgColor
        
        emailTextField.layer.addSublayer(emailBottomLayer)
        passwordTextField.layer.addSublayer(passwordBottomLayer)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        checkUserStatus()
    }
    
    func checkUserStatus(){
        if (FIRAuth.auth()?.currentUser?.uid) != nil {
            loginUser()
        }
    }
    
    func loginUser(){
        performSegue(withIdentifier: "signInSegue", sender: nil)
    }
    
    func checkValidUserInput() -> Bool {
        if (emailTextField.text?.isEmpty)! && (passwordTextField.text?.isEmpty)!{
            return false
        } else {
            return true
        }
    }
    
    @IBAction func signInWithEmailAndPasswordButton(_ sender: UIButton){
        if checkValidUserInput() {
            authServices.signInUserWithEmailAndPassword(email: emailTextField.text!,
                                                        password: passwordTextField.text!,
                                                        onSuccess: loginUser,
                                                        onError: { error in print(error!)})
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @IBAction func singInWithFacebook(_ sender: UIButton){
        
    }
    
}


