//
//  exercise.swift
//  Week3
//
//  Created by Jason wang on 9/25/18.
//  Copyright © 2018 JasonWang. All rights reserved.
//

import Foundation

class Exercise: Codable {
    let id: Int
    var name: String
    var isMachine: Bool
    var startTime: Date
    var sets: [Set]

    init(id: Int, startTime: Date, name: String, isMachine: Bool = false, sets: [Set] = [Set]()) {
        self.id = id
        self.startTime = startTime
        self.name = name
        self.isMachine = isMachine
        self.sets = sets
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case isMachine
        case startTime
        case sets
    }


    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        isMachine = try container.decode(Bool.self, forKey: .isMachine)
        startTime = try container.decode(Date.self, forKey: .startTime)
        sets = try container.decode([Set].self, forKey: .sets)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(isMachine, forKey: .isMachine)
        try container.encode(startTime, forKey: .startTime)
        try container.encode(sets, forKey: .sets)

    }

}
