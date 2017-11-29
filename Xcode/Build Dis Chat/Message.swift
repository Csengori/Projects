//
//  Message.swift
//  Build Dis Chat
//
//  Created by Tamas Sagi on 19/05/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import Foundation

class Message {
    var fromId: String?
    var text: String?
    var time: Date?
    var toId: String?
    var imageUrl: String?
    var videoUrl: String?
    var imageWidth: NSNumber?
    var imageHeight: NSNumber?
    
    init(dictionary: [String: Any]) {
        self.fromId = dictionary["fromId"] as? String
        self.text = dictionary["text"] as? String
        self.time = dictionary["time"] as? Date
        self.toId = dictionary["toId"] as? String
        self.imageUrl = dictionary["imageUrl"] as? String
        self.videoUrl = dictionary["videoUrl"] as? String
        self.imageWidth = dictionary["imageWidth"] as? NSNumber
        self.imageHeight = dictionary["imageHeight"] as? NSNumber
        
    }
    
    
    
}
