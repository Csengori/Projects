//
//  CameraViewController.swift
//  CopyGram
//
//  Created by Tamas Sagi on 02/06/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import UIKit
import Firebase

class CameraViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectedPhoto)))
        image.isUserInteractionEnabled = true
        
    }
    
    func handleSelectedPhoto(){
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func checkCaptioForValidEntry() -> Bool {
        return captionTextView.text.isEmpty ? false : true
    }
    
    @IBAction func sharePost(_ sender: UIButton) {
        
        if let imageForUpload = selectedImage, let imageData = UIImageJPEGRepresentation(imageForUpload, 0.7) {
            let imageUID = NSUUID()
            if checkCaptioForValidEntry() {
                AuthServices.shared.uploadPictureToStorage(withImageData: imageData,
                                                           location: "Post_pictures/\(imageUID)",
                    uid: (FIRAuth.auth()?.currentUser?.uid)!,
                    imageType: AuthServices.uploadLocationType.postPicture, imageDescription: captionTextView.text)
            }
            image.image = UIImage(named: "dummy-profile-pic")
            captionTextView.text = ""
            Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(changeScreen), userInfo: nil, repeats: false)
            
        }
    }
    
    func changeScreen() {
        self.tabBarController?.selectedIndex = 0
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension CameraViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            image.image = pickedImage
            selectedImage = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
}
