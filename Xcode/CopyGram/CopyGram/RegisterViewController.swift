//
//  RegisterViewController.swift
//  CopyGram
//
//  Created by Tamas Sagi on 02/06/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    var selectedImageFromPicker: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.layer.cornerRadius = 40
        profileImageView.clipsToBounds = true
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.selectProfileImageView)))
        profileImageView.isUserInteractionEnabled = true
    }
    
    func selectProfileImageView() {
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func loginUser(){
        performSegue(withIdentifier: "signInSegue", sender: nil)
    }
    
    func checkValidUserInput() -> Bool {
        if (emailTextField.text?.isEmpty)! && (passwordTextField.text?.isEmpty)! && (usernameTextField.text?.isEmpty)!{
            return false
        } else {
            return true
        }
    }
    
    @IBAction func signUpUser(_ sender: UIButton){
        
        if let profileImage = self.selectedImageFromPicker, let imageData = UIImageJPEGRepresentation(profileImage, 0.5){
            
            AuthServices.shared.signUpUserWithEmailAndPassword(with: emailTextField.text!,
                                                               email: emailTextField.text!,
                                                               password: usernameTextField.text!,
                                                               imageData: imageData,
                                                               onSuccess: loginUser,
                                                               onError: {error in print(error!)})
        } else {
            AuthServices.shared.signUpUserWithEmailAndPassword(with: emailTextField.text!,
                                                               email: emailTextField.text!,
                                                               password: usernameTextField.text!,
                                                               imageData: nil,
                                                               onSuccess: loginUser,
                                                               onError: {error in print(error!)})
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func alreadyHaveAnAccount(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as?  UIImage{
            selectedImageFromPicker = image
            profileImageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}
