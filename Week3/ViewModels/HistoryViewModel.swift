//
//  HistoryViewModel.swift
//  Week3
//
//  Created by Jason wang on 9/25/18.
//  Copyright © 2018 JasonWang. All rights reserved.
//

import Foundation
class HistoryViewModel {

    var workouts: Obserable<[WorkoutHistoryViewModel]>
    var message: Obserable<String>

    init(workouts: [Workout], message: String) {
        let workoutViewModels = workouts.map( WorkoutHistoryViewModel.init )
        self.workouts = Obserable<[WorkoutHistoryViewModel]>(workoutViewModels)
        self.message = Obserable<String>(message)
    }

    func startWorkout() {
        // if today has workout already append excercise in workoutViewModel
        // otherwise create a new workoutViewModel
    }
}
