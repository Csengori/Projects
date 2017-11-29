//
//  RegisterViewController.swift
//  Chat with Us
//
//  Created by Tamas Sagi on 12/06/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    private let authServices = AuthServices()
    private let databseServices = DatabaseServices()
    var selectedImageFromPicker: UIImage?
    
    //MARK: FIX DIS MESS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius =  profileImageView.frame.height / 2
        profileImageView.layer.masksToBounds = true
        profileImageView.clipsToBounds = true
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectProfileImage)))
        profileImageView.isUserInteractionEnabled = true
        
        usernameTextField.addBottomBorder(withHeight: 1)
        
        let testBottomBorderForPasswordField  = CALayer()
        testBottomBorderForPasswordField.frame = CGRect(x: passwordTextField.frame.minX, y: 29, width: passwordTextField.frame.width * 2, height: 1)
        testBottomBorderForPasswordField.backgroundColor = UIColor(red: 240, green: 240, blue: 240, alpha: 0.6).cgColor
        passwordTextField.tempLayerSetup()
        passwordTextField.layer.addSublayer(testBottomBorderForPasswordField)
        
        let testBottomBorderForEmailField  = CALayer()
        testBottomBorderForEmailField.frame = CGRect(x: emailTextField.frame.minX, y: 29, width: emailTextField.frame.width * 2, height: 1)
        testBottomBorderForEmailField.backgroundColor = UIColor(red: 240, green: 240, blue: 240, alpha: 0.6).cgColor
        emailTextField.tempLayerSetup()
        emailTextField.layer.addSublayer(testBottomBorderForEmailField)
        
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    func selectProfileImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func checkValidUserInput() -> Bool {
        if (emailTextField.text?.isEmpty)! && (passwordTextField.text?.isEmpty)! && (usernameTextField.text?.isEmpty)!{
            return false
        } else {
            return true
        }
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
    
    //MARK: clean up using authServices
    @IBAction func registerUserWithEmailAndPassword(_ sender: UIButton){
        if checkValidUserInput() {
            FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                if error != nil {
                    print("error creaing user with email and password\(error.debugDescription)")
                }
                self.databseServices.saveUserIntoDatabase(withUsername: self.usernameTextField.text!, email: self.emailTextField.text!, uid: (FIRAuth.auth()?.currentUser?.uid)!)
                self.performSegue(withIdentifier: "chatFeedSegues", sender: nil)
            }
        } else {
            return
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let uid = FIRAuth.auth()?.currentUser?.uid {
            let navigationController = segue.destination as! UINavigationController
            let destinationViewController = navigationController.viewControllers.first as! MessageViewController
            destinationViewController.senderId = uid
        }
    }
    
    @IBAction func alreadyHaveAnAccountButton(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
//MARK: HANDLE EDITED IMAGE PICKER
extension RegisterViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImageFromPicker = image
            profileImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
}
