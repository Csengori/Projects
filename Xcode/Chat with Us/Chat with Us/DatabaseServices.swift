//
//  DatabaseServices.swift
//  Chat with Us
//
//  Created by Tamas Sagi on 12/06/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DatabaseServices {
    
    private var databaseRef = FIRDatabase.database().reference()
    private let constants = FirebaseConstants()
    
    func saveUserIntoDatabase(withUsername username: String, email: String, uid: String) {
        let updateData = ["username":username,
                          "email":email]
        databaseRef.child(constants.userRef).child(uid).updateChildValues(updateData) { (error, ref) in
            if error != nil {
                print("error saving user into DB")
            }
        }
    }
    
    func updateDatabaseEntries(withUID uid: String?, values: [String:String], location: uploadLocationToogle) {
        switch location {
        case .message:
            databaseRef.child(constants.messageRef).childByAutoId().updateChildValues(values) { (error, databaseReference) in
                if error != nil { print("error updating database entries\(error.debugDescription)") }
            }
        case .profilePicture:
            databaseRef.child(constants.userRef).child(uid!).child(constants.messageRef).updateChildValues(values) { (error, databaseReference) in
                if error != nil { print("error updating database entries\(error.debugDescription)") }
            }
        }
        
    }
}
