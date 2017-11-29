//
//  Channel.swift
//  FireChat
//
//  Created by Tamas Sagi on 17/05/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import Foundation

internal class Channel {
    internal let id: String
    internal let name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
