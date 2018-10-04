//
//  WorkoutService.swift
//  Week3
//
//  Created by Jason wang on 10/2/18.
//  Copyright © 2018 JasonWang. All rights reserved.
//

import Foundation

class WorkoutService {

    func saveWorkouts(_ workouts: [Workout]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(workouts) {
            UserDefaults.standard.set(encoded, forKey: "workouts")
            UserDefaults.standard.synchronize()
        }
    }

    func getWorkouts() -> [Workout] {
        
        if let workoutData = UserDefaults.standard.data(forKey: "workouts") {
            do {
                let workouts = try JSONDecoder().decode([Workout].self, from: workoutData)
                return workouts
            } catch {
                print(error)
            }
        }
        return [Workout]()
    }
}
