//
//  Quest.swift
//  ReQuest_ios
//
//  Created by Leon Mak on 10/9/17.
//  Copyright © 2017 Leon Mak. All rights reserved.
//

import Foundation
import MapKit
import ARCL

class Quest {
    var id: UUID
    var title: String
    var detail: String
    var description: String
    var category: QuestCategory
    var creator: User
    var fulfiller: User
    var lat: Double
    var lng: Double
    var annotation: LocationAnnotationNode?
    var mapAnnotation: MKPointAnnotation?
    
    init(title: String, detail: String, description: String, 
         category: QuestCategory = .Uncategorized, creator: User, fulfiller: User, lat: Double, lng: Double) {
        self.id = UUID()
        self.title = title
        self.detail = detail
        self.description = description
        self.category = category
        self.fulfiller = fulfiller
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
