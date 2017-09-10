//
//  Quest.swift
//  ReQuest_ios
//
//  Created by Leon Mak on 10/9/17.
//  Copyright © 2017 Leon Mak. All rights reserved.
//

import Foundation

class Quest {
    var id: UUID
    var title: String
    var description: String
    var category: QuestCategory
    var creator: User
    var lat: Double
    var lng: Double
    
    init(title: String, description: String, category: QuestCategory = .Uncategorized, creator: User, lat: Double, lng: Double) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.category = category
        self.creator = creator
        self.lat = lat
        self.lng = lng
    }
    
    var location: (lat: Double, lng: Double) {
        get {
            return (lat: lat, lng: lng)
        }
    }
    
}
