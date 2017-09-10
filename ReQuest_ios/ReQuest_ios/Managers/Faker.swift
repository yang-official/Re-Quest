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
    func getUsers() -> [User] {
        return [
            User(name: "Leon", profilePicUrl: "avatar_1", seed: 0),
            User(name: "Alice", profilePicUrl: "avatar_2", seed: 1),
            User(name: "Ben", profilePicUrl: "avatar_3", seed: 2),
            User(name: "Charlie", profilePicUrl: "avatar_4", seed: 3),
            User(name: "Ezra", profilePicUrl: "avatar_5", seed: 4),
        ]
    }

    func getQuests() -> [Quest] {
        let users = getUsers()
        return [
            Quest(title: "Need a screwdriver to fix some furniture.", detail: "1",
                  description: "If possible, I would like a Phillips screwdriver size 0.5 inches. Much appreciated. ",
                  category: QuestCategory.Housing, creator: users[0], fulfiller: users[0], lat: 37.773590, lng: -122.415737),
            Quest(title: "Need a tuner to tune my guitar.", detail: "Use just once",
                  description: "I will play you any song you want if you help me.",
                  category: QuestCategory.Food, creator: users[1], fulfiller: users[1], lat: 37.7763415, lng: -122.4218081),
            Quest(title: "Some diapers for my 2-year-old kid.", detail: "Any amount",
                  description: "Would really appreciate any amount that you can spare, the stores have run out.",
                  category: QuestCategory.Housing, creator: users[2], fulfiller: users[2],  lat: 37.773123, lng: -122.415188),
            Quest(title: "Need potable water.", detail: "40 bottles.",
                  description: "My pipe is broken and the stream has been contaminated.",
                  category: QuestCategory.Transportation, creator: users[3], fulfiller: users[3], lat: 37.773237, lng: -122.416292),
            
        ]
    } 
    
    func getRequests() -> [Quest] {
        let users = getUsers()
        let request = Quest(title: "Need a ride to the evacuation zone.", detail: "to mexico",
                            description: "My car is damaged and I have no way to get out of this place!",
                            category: QuestCategory.Housing, creator: users[4], fulfiller: users[4], lat: 37.773237, lng: 122.416292)
        return [ request ]
    }
    
}
