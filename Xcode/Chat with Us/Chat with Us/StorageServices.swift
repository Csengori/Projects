//
//  StorageServices.swift
//  Chat with Us
//
//  Created by Tamas Sagi on 12/06/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import Foundation
import FirebaseStorage

class StorageServices {
    private let storageRef = FIRStorage.storage().reference(forURL: "gs://friendlychat-ee80c.appspot.com/")
    
    func uploadPicture(picture: Data, location: uploadLocationToogle) {
        
    }
    
    
}
