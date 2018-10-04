//
//  Workout.swift
//  Week3
//
//  Created by Jason wang on 9/25/18.
//  Copyright © 2018 JasonWang. All rights reserved.
//

import Foundation

class Workout: Codable {
    let id: Int
    let name: String
    var exercises: [Exercise]
    var startTime: Date
    var endTime: Date?

    init(id: Int, name: String, startTime: Date, exercises: [Exercise] = [Exercise]()) {
        self.id = id
        self.name = name
        self.startTime = startTime
        self.exercises = exercises
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case exercises
        case startTime
        case endTime
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        exercises = try container.decode([Exercise].self, forKey: .exercises)
        startTime = try container.decode(Date.self, forKey: .startTime)
        endTime = try container.decode(Date?.self, forKey: .endTime)
    }


    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(exercises, forKey: .exercises)
        try container.encode(startTime, forKey: .startTime)
        try container.encode(endTime, forKey: .endTime)

    }


}
