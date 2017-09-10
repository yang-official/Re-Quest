//
//  User.swift
//  ReQuest_ios
//
//  Created by Leon Mak on 10/9/17.
//  Copyright © 2017 Leon Mak. All rights reserved.
//

import Foundation

class User {
    var id: Int
    var name: String
    var profilePicUrl: String?
    
    init(name: String, profilePicUrl: String?, seed: Int? = nil) {
        if seed != nil  {
            self.id = seed!
        } else {
            self.id = 0
        }
        self.name = name
        self.profilePicUrl = profilePicUrl
    }
    
}
