//
//  QuestCategory.swift
//  ReQuest_ios
//
//  Created by Leon Mak on 10/9/17.
//  Copyright © 2017 Leon Mak. All rights reserved.
//

import Foundation

enum QuestCategory {
    case Food
    case Labour
    case Tourist
    case Transportation
    case Housing
    case Water
    case Uncategorized
    
    func getMarkerPin() -> String {
        switch self {
        case .Food:
            return "supplies_pin"
        case .Transportation:
            return "car_pin"
        case .Water:
            return "water_pin"
        case .Housing:
            return "health_pin"
        case .Labour, .Tourist, .Uncategorized:
            return "user_pin"
        }
    }
}
