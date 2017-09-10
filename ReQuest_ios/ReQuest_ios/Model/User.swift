//
//  User.swift
//  ReQuest_ios
//
//  Created by Leon Mak on 10/9/17.
//  Copyright © 2017 Leon Mak. All rights reserved.
//

import Foundation

class User {
    var name: String
    var profilePicUrl: String?
    
    init(name: String, profilePicUrl: String?) {
        self.name = name
        self.profilePicUrl = profilePicUrl
    }
    
}
