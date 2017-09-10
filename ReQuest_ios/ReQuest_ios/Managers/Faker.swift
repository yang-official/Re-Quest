//
//  Faker.swift
//  ReQuest_ios
//
//  Created by Leon Mak on 10/9/17.
//  Copyright © 2017 Leon Mak. All rights reserved.
//

import Foundation

public class Faker {
    // Mock data generator
    static let instance = Faker()
    
    var users = [
        User(name: "Leon", profilePicUrl: "avartar_1"),
        User(name: "Alice", profilePicUrl: "avartar_2"),
        User(name: "Ben", profilePicUrl: "avartar_3"),
        User(name: "Charlie", profilePicUrl: "avartar_4"),
        User(name: "Ezra", profilePicUrl: "avartar_5"),
    ]
    
    lazy var quests = [
        Quest(title: "Need a screwdriver to fix some furniture.",
              description: "If possible, I would like a Phillips screwdriver size 0.5 inches. Much appreciated. ",
              category: QuestCategory.Housing, creator: users[0], lat: 37.773590, lng: -122.415737),
        Quest(title: "Need a tuner to tune my guitar.",
              description: "I will play you any song you want if you help me.",
              category: QuestCategory.Housing, creator: users[1], lat: 37.7763415, lng: -122.4218081),
        Quest(title: "Some diapers for my 2-year-old kid.",
              description: "Would really appreciate any amount that you can spare, the stores have run out.",
              category: QuestCategory.Housing, creator: users[2], lat: 37.773123, lng: -122.415188),
        Quest(title: "Need potable water.",
              description: "My pipe is broken and the stream has been contaminated.",
              category: QuestCategory.Housing, creator: users[3], lat: 37.773237, lng: -122.416292),
        Quest(title: "Need a ride to the evacuation zone.",
              description: "My car is damaged and I have no way to get out of this place!",
              category: QuestCategory.Housing, creator: users[4], lat: 37.773237, lng: -122.416292),
    ]
    
    
}
