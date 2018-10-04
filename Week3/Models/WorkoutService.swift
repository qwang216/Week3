//
//  WorkoutService.swift
//  Week3
//
//  Created by Jason wang on 10/2/18.
//  Copyright © 2018 JasonWang. All rights reserved.
//

import Foundation

class WorkoutService {

    private var userDefaults = UserDefaults.standard

    func saveWorkouts(_ workouts: [Workout]) {
        let encoder = JSONEncoder()
        let mockData = MockData.generateWorkoutDate()
        if let encoded = try? encoder.encode(mockData) {
            userDefaults.set(encoded, forKey: "workouts")
            userDefaults.synchronize()
        }
    }

    func getWorkouts() -> [Workout] {
        let workouts = userDefaults.object(forKey: "workouts") as? [Workout] ?? [Workout]()
        return workouts
    }
}
