//
//  AuthServices.swift
//  CopyGram
//
//  Created by Tamas Sagi on 08/06/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class AuthServices {
    
    enum uploadLocationType {
        case profilePicture
        case postPicture
    }
    
    static var shared = AuthServices()
    private let ref = FirebaseReferences.self
    
    func signInUserWithEmailAndPassword(email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping(_ message: String?) -> Void) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                onError(error?.localizedDescription)
                return
            }
            onSuccess()
        })
    }
    
    private  func signInUserWithFacebook(){
        
    }
    
    func signUpUserWithEmailAndPassword(with username: String, email: String,password: String,imageData: Data?, onSuccess: @escaping () -> Void, onError: @escaping(_ message: String?) -> Void){
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                onError(error?.localizedDescription)
                return
            }
            onSuccess()
            self.setUserInformation(username: username, email: email , uid: (FIRAuth.auth()?.currentUser?.uid)!)
            if (imageData != nil) {
                self.uploadPictureToStorage(withImageData: imageData!, location: "Profile_pictures/\((FIRAuth.auth()?.currentUser?.uid)!)", uid: (FIRAuth.auth()?.currentUser?.uid)!, imageType: .profilePicture, imageDescription: nil)
            }
        })
    }
    
    func uploadPictureToStorage(withImageData imageData: Data, location: String, uid: String, imageType: uploadLocationType, imageDescription: String?)  {
        let uploadImageToStorageReference = FIRStorage.storage().reference(forURL: ref.storage_url_reference).child(location)
        
        uploadImageToStorageReference.put(imageData, metadata: nil) { (metadata, error) in
            if error != nil { print("ERROR uploading image\(error.debugDescription)") }
            if let uploadedImageUrl = metadata?.downloadURL()?.absoluteString {
                switch  imageType {
                    
                case .profilePicture :
                    self.updateUserInformationWithImage(withURL: uploadedImageUrl, uid: uid)
                case .postPicture :
                    self.updateDatabaseEntries(uploadedImageUrl: uploadedImageUrl, description: imageDescription!)
                }
            }
        }
    }
    
    func logoutCurrentUser(){
        do {
            try FIRAuth.auth()?.signOut()
        } catch let error {
            print("ERROR signing out user\(error.localizedDescription)")
        }
    }
    
    
    private func updateDatabaseEntries(uploadedImageUrl: String, description: String){
        let databaseReference = FIRDatabase.database().reference().child(ref.posts).childByAutoId()
        databaseReference.updateChildValues([ref.image : uploadedImageUrl,
                                             ref.description : description
            ])
        
    }
    
    private func updateUserInformationWithImage(withURL profileImageUrl: String, uid: String){
        FIRDatabase.database().reference().child(ref.user).child(uid).updateChildValues([ref.profile_picture_url : profileImageUrl])
    }
    
    private func setUserInformation(username: String, email: String, uid: String){
        FIRDatabase.database().reference().child(FirebaseReferences.user).child(uid).setValue([ref.username : username,
                                                                                               ref.email : email])
    }
    
}
