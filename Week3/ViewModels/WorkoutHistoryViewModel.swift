//
//  WorkoutHistoryViewModel.swift
//  Week3
//
//  Created by Jason wang on 9/27/18.
//  Copyright © 2018 JasonWang. All rights reserved.
//

import Foundation

class WorkoutHistoryViewModel {
    var exerciseViewModels: Obserable<[ExerciseViewModel]>
    var dateString: Obserable<String>
    var nameString: Obserable<String>

    init(_ workout: Workout) {
        let exerciseViewModel = workout.exercises.map ( ExerciseViewModel.init )
        self.exerciseViewModels = Obserable<[ExerciseViewModel]>(exerciseViewModel)
        let dateString = workout.startTime.toString(dateFormat: .dMY)
        self.dateString = Obserable<String>(dateString)
        self.nameString = Obserable<String>(workout.name)
    }
}
