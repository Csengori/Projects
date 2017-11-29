//
//  \.swift
//  Chat with Us
//
//  Created by Tamas Sagi on 12/06/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import Foundation

struct FirebaseConstants {
    var storageRef = "gs://friendlychat-ee80c.appspot.com/"
    var userRef = "users"
    var profile_picture_ref = ""
    var messageRef = "messages"
}

enum uploadLocationToogle {
    case profilePicture
    case message
}
    
