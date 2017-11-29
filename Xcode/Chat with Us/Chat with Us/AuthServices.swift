//
//  File.swift
//  Chat with Us
//
//  Created by Tamas Sagi on 12/06/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthServices {
    
    private static let  firConstants = FirebaseConstants()
    static var authServices = AuthServices()
    
    func checkLoginStatus() -> Bool {
        return FIRAuth.auth()?.currentUser?.uid != nil ? true : false
    }
    
    func signInWithEmailAndPassword(email: String, password: String) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print("error logging in user \(error.debugDescription)")
            }
        }
    }
    
    func signInWithFacebook(){
        
    }
    
    var getUID = {
        return FIRAuth.auth()?.currentUser?.uid
    }
    
    //MARK: upload user to db
    
    func registerWithEmailAndPassword(email: String, password: String){
        FIRAuth.auth()?.createUser(withEmail: email, password: password){ (user, error) in
            if error != nil {
                print("error creating user with email and password\(error.debugDescription)")
            }
        }
    }
    
    func signOutCurrentUser(){
        do {
            try FIRAuth.auth()?.signOut()
        } catch let error {
            print("error signing out user \(error.localizedDescription)")
        }
    }
    
    
    
}
