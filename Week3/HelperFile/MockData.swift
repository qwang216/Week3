//
//  MockData.swift
//  Week3
//
//  Created by Jason wang on 9/25/18.
//  Copyright © 2018 JasonWang. All rights reserved.
//

import Foundation

class MockData {
    static func generateWorkoutDate() -> [Workout] {

        return generateworkout()
    }

    private static func generateworkout() -> [Workout] {

        // workout day 1

        let workout1Date = Date(timeInterval: 86400, since: Date())
        let workout1 = Workout(id: 10, name: "Chest Day", startTime: workout1Date)
        let exercise1 = Exercise(id: 1, startTime: Date(timeInterval: 60, since: workout1Date), name: "Bench Press")
        exercise1.sets = [
            Set(set: 1, id: 1, weight: 100, repetition: 100),
            Set(set: 2, id: 2, weight: 200, repetition: 200),
            Set(set: 3, id: 3, weight: 300, repetition: 300),
            Set(set: 4, id: 4, weight: 400, repetition: 400)
        ]

        let exercise2 = Exercise(id: 2, startTime: Date(timeInterval: 120, since: workout1Date), name: "Bench Press 2")
        exercise2.sets = [
            Set(set: 5, id: 5, weight: 110, repetition: 110),
            Set(set: 6, id: 6, weight: 220, repetition: 220),
            Set(set: 7, id: 7, weight: 330, repetition: 330),
            Set(set: 8, id: 8, weight: 440, repetition: 440),
            Set(set: 9, id: 9, weight: 550, repetition: 550)
        ]
        workout1.exercises = [exercise1, exercise2]


        // workout day 2
        let workout2Date = Date(timeInterval: 172800, since: Date())
        let workout2 = Workout(id: 10, name: "Chest Day2", startTime: workout2Date)

        let w2_exercise1 = Exercise(id: 2, startTime: Date(timeInterval: 60, since: workout1Date), name: "Bench Press 3")
        w2_exercise1.sets = [
            Set(set: 1, id: 1, weight: 100, repetition: 10),
            Set(set: 2, id: 2, weight: 200, repetition: 20),
            Set(set: 3, id: 3, weight: 300, repetition: 30)
        ]

        let w2_exercise2 = Exercise(id: 2, startTime: Date(timeInterval: 120, since: workout1Date), name: "Bench Press 4")
        w2_exercise2.sets = [
            Set(set: 5, id: 5, weight: 90, repetition: 110),
            Set(set: 6, id: 6, weight: 60, repetition: 220),
            Set(set: 7, id: 7, weight: 50, repetition: 330),
            Set(set: 8, id: 8, weight: 30, repetition: 440),
            Set(set: 9, id: 9, weight: 94, repetition: 550)
        ]
        workout2.exercises = [w2_exercise1, w2_exercise2]

        return [workout1, workout2]
    }
}
