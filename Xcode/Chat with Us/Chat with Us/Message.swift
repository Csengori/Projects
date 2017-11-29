//
//  Message.swift
//  Chat with Us
//
//  Created by Tamas Sagi on 13/06/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import Foundation

class Message {
    var senderId: String!
    var senderUsername: String!
    var message:String!
    
    init(withUsername username: String, userIdentification: String, message: String) {
        self.senderId = userIdentification
        self.senderUsername = username
        self.message = message
    }
}
