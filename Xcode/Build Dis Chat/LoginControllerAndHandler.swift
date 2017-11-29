//
//  LoginControllerAndHandler.swift
//  Build Dis Chat
//
//  Created by Tamas Sagi on 18/05/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

extension LoginViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //    TODO : UPLOAD IMAGE DATA INTO FIREBASE STORAGAE AND STORE REFERENCE IN DB
    
    func handleRegister() {
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            let name = nameTextField.text else { return }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print("Error creating user: \(error.debugDescription)")
                return }
    
            guard let uid = user?.uid else { return }
            let ref = FIRDatabase.database().reference(fromURL: "https://applechat-ed95a.firebaseio.com/")
            let storageRef = FIRStorage.storage().reference().child("testImage.png")
            let userReference = ref.child("user").child(uid)
            if let uploadData = UIImagePNGRepresentation(self.profileImageView.image!) {
                storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        print("Error uploading image to storage: \(error.debugDescription)")
                        return
                    }
                    print("Metadata: \(metadata)")
                })
            }
            
            let values = ["Name" : name,
                          "Email" : email,
                          ]
            
            userReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
                if error != nil {
                    print("Error uploading user into DB: \(error.debugDescription)")
                    return
                }
            })
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    func handleSelectProfileImageView()  {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            selectedImageFromPicker = editedImage
            
        } else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            profileImageView.image = selectedImage
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
