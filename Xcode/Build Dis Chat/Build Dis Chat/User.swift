//
//  File.swift
//  Build Dis Chat
//
//  Created by Tamas Sagi on 18/05/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import Foundation

class User {
//    var id: String
    var name: String?
    var email: String?
  //  var profileImageUrl: String?
    
    init(dictionary: [String : AnyObject]) {
        self.name = dictionary["Name"] as? String
        self.email = dictionary["Email"] as? String
    }
    
}
