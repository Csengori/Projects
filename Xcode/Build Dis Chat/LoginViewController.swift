//
//  LoginViewController.swift
//  Build Dis Chat
//
//  Created by Tamas Sagi on 18/05/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 92, green: 107, blue: 115)
        
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(profileImageView)
        view.addSubview(loginRegisterSegmentedController)
        
        setupInputsContainerView()
        setupProfileImageView()
        setupLoginRegisterButton()
        setupLoginRegisterSegmentedControl()
    }
    
//    func handleRegister() {
//        guard let email = emailTextField.text,
//            let password = passwordTextField.text,
//            let name = nameTextField.text else {
//                return
//        }
        
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print(error.debugDescription)
                return
            }
            
            guard let uid = user?.uid else { return }
            let ref = FIRDatabase.database().reference(fromURL: "https://applechat-ed95a.firebaseio.com/")
            let userReference = ref.child("user").child(uid)
            
            let values = ["Name" : name,
                          "Email" : email,
                          ]
            
            userReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
                if error != nil {
                    print(error.debugDescription)
                    return
                }
            })
        })
        
    }
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 246, green: 247, blue: 248)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 157, green: 180, blue: 192)
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let nameTextFieldSeparator: UIView = {
        let separator  = UIView()
        separator.backgroundColor = UIColor(red: 220, green: 220, blue: 220)
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailTextFieldSeparator: UIView = {
        let separator  = UIView()
        separator.backgroundColor = UIColor(red: 220, green: 220, blue: 220)
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "********"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "AppleLogo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let loginRegisterSegmentedController: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.backgroundColor = UIColor(red: 246, green: 247, blue: 248)
        sc.tintColor = UIColor(red: 157, green: 180, blue: 192)
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    func setupInputsContainerView(){
        //NEED CONSTRAINTS FOR : X, Y, W, H
        
        //        //Subviews
        //
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameTextFieldSeparator)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailTextFieldSeparator)
        inputsContainerView.addSubview(passwordTextField)
        
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextField.heightAnchor.constraint(greaterThanOrEqualTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        nameTextFieldSeparator.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameTextFieldSeparator.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameTextFieldSeparator.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextFieldSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        emailTextFieldSeparator.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailTextFieldSeparator.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailTextFieldSeparator.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextFieldSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
    }
    
    func setupLoginRegisterButton(){
        //NEED CONSTRAINTS FOR : X, Y, W, H
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupProfileImageView(){
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: loginRegisterSegmentedController.topAnchor, constant: -36).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func setupLoginRegisterSegmentedControl() {
        loginRegisterSegmentedController.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedController.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        loginRegisterSegmentedController.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterSegmentedController.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension UIColor {
    
    convenience init(red r: CGFloat, green g: CGFloat, blue b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
