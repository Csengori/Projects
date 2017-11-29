//
//  ViewController.swift
//  Chat with Us
//
//  Created by Tamas Sagi on 12/06/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var authServices = AuthServices.authServices
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: rewrite dis is bad practice
        
        let testbottomBorderForEmailField = CALayer()
        testbottomBorderForEmailField.frame = CGRect(x: emailTextField.frame.minX, y: 29, width: emailTextField.frame.width * 2, height: 1)
        testbottomBorderForEmailField.backgroundColor = UIColor(red: 240, green: 240, blue: 240, alpha: 0.6).cgColor
        emailTextField.tempLayerSetup()
        emailTextField.layer.addSublayer(testbottomBorderForEmailField)
        
        let testBottomBorderForPasswordField  = CALayer()
        testBottomBorderForPasswordField.frame = CGRect(x: passwordTextField.frame.minX, y: 29, width: passwordTextField.frame.width * 2, height: 1)
        testBottomBorderForPasswordField.backgroundColor = UIColor(red: 240, green: 240, blue: 240, alpha: 0.6).cgColor
        passwordTextField.tempLayerSetup()
        passwordTextField.layer.addSublayer(testBottomBorderForPasswordField)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        print("login Status: \(authServices.checkLoginStatus())")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        loginUser()
    }
    
    func loginUser() {
        if authServices.checkLoginStatus() {
            performSegue(withIdentifier: "chatFeedSegues", sender: nil)
        }
    }
    
    func checkValidUserInput() -> Bool {
        if (emailTextField.text?.isEmpty)! && (passwordTextField.text?.isEmpty)!{
            return false
        } else {
            return true
        }
    }
    
    @IBAction func signInWithEmailAndPassword(_ sender: UIButton) {
        if checkValidUserInput() {
            FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!)  { (user, error) in
                if error != nil {
                    print("Error signing in user\(error.debugDescription)")
                }
                self.performSegue(withIdentifier: "chatFeedSegues", sender: nil)
            }
        }
    }
    
    @IBAction func singInWithFacebook(_ sender: UIButton){
        
    }
    
    //MARK: USE AUTHSERVICES
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chatFeedSegues" {
            let navigationController = segue.destination as! UINavigationController
            let destinationViewcontroller = navigationController.viewControllers.first as! MessageViewController
            destinationViewcontroller.senderId = FIRAuth.auth()?.currentUser?.uid
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            return true
        }
        return false
    }
}
extension UITextField {
    func addBottomBorder(withHeight height: CGFloat){
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: self.frame.minX, y: self.frame.maxY - height, width: self.frame.width * 2, height: height)
        bottomLayer.backgroundColor = UIColor(red: 21, green: 21, blue: 21, alpha: 0.6).cgColor
        self.backgroundColor = UIColor.clear
        self.textColor = UIColor(red: 240, green: 240, blue: 240, alpha: 1)
        self.layer.addSublayer(bottomLayer)
    }
    
    func tempLayerSetup(){
        self.backgroundColor = UIColor.clear
        self.textColor = UIColor(red: 240, green: 240, blue: 240, alpha: 1)
    }
}

extension UIColor {
    convenience init(red r: CGFloat, green g: CGFloat, blue b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

