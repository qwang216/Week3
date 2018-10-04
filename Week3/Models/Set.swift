//
//  Set.swift
//  Week3
//
//  Created by Jason wang on 9/25/18.
//  Copyright © 2018 JasonWang. All rights reserved.
//

import Foundation

class Set: Codable {
    let id: Int
    let set: Int
    var weight: Double
    var repetition: Int
    var oneRepetitionMax: String {
        if repetition > 1 {
            return (weight * (1 + Double(repetition) / 30.0)).formatNumberToStringAndRoundTo(0)
        } else {
            return weight.formatNumberToStringAndRoundTo(1)
        }
    }

    init(set: Int, id: Int, weight: Double = 0, repetition: Int = 0) {
        self.set = set
        self.id = id
        self.weight = weight
        self.repetition = repetition
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        set = try container.decode(Int.self, forKey: .set)
        weight = try container.decode(Double.self, forKey: .weight)
        repetition = try container.decode(Int.self, forKey: .repetition)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case set
        case weight
        case repetition
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(set, forKey: .set)
        try container.encode(weight, forKey: .weight)
        try container.encode(repetition, forKey: .repetition)

    }

}
