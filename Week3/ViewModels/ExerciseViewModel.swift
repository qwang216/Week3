//
//  ExerciseViewModel.swift
//  Week3
//
//  Created by Jason wang on 9/27/18.
//  Copyright © 2018 JasonWang. All rights reserved.
//

import Foundation

class ExerciseViewModel {
    var exercise: Obserable<Exercise>

    init(_ exercise: Exercise) {
        self.exercise = Obserable<Exercise>(exercise)
    }

//    func addSet() {
//        var sets = exercise.value.sets
//        let setID = Int(Date().timeIntervalSince1970)
//        let newSet = Set(set: sets.count + 1, id: setID)
//        sets.append(newSet)
//
//        exercise.value.sets = sets
//        exercise.value = exercise.value
//    }

    func removeSet(at index: Int) {
        exercise.value.sets.remove(at: index)
        exercise.value = exercise.value
    }

    func exerciseDidSelect() {
        // tells the view to segue
        // notification center
        // pass self in the notification center
    }

}
