//
//  WorkoutViewModel.swift
//  Week3
//
//  Created by Jason wang on 9/28/18.
//  Copyright © 2018 JasonWang. All rights reserved.
//

import Foundation

enum NotificationName: String {
    case showAddExerciseAlertView = "showAddExerciseAlertView"
    case addNewExercise = "addNewExercise"
    case handleDismissView = "handleDismissView"
}

class WorkoutViewModel {
    var exercises: Obserable<[ExerciseViewModel]>
    var workoutTitle: Obserable<String>
    let workoutService = WorkoutService()
    var timeTracker = Obserable<String>("00:00")
    var timeCounter = 0
    lazy var timer: Timer = Timer.scheduledTimer(timeInterval: 1.00, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    var startTime: Date

    init(workout: Workout) {
        let exerciseVM = workout.exercises.map(ExerciseViewModel.init)
        self.exercises = Obserable<[ExerciseViewModel]>(exerciseVM)
        self.startTime = workout.startTime
        workoutTitle = Obserable<String>(workout.startTime.convertToAMorPMString())
        NotificationCenter.default.addObserver(self, selector: #selector(addNewExercise), name: Notification.Name(NotificationName.addNewExercise.rawValue), object: nil)
        timer.fire()
    }

    @objc func updateTimer() {
        timeCounter += 1
        timeTracker.value = converTimeCounterToString(counter: timeCounter)
    }

    private func converTimeCounterToString(counter: Int) -> String {
        let sec = counter % 60

        let min = (counter / 60) < 1 ? 0 : counter / 60
        return "\(shouldAddPrefixZero(min)):\(shouldAddPrefixZero(sec))"
    }

    private func shouldAddPrefixZero(_ time: Int) -> String {
        return time < 10 ? "0\(time)" : "\(time)"
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func addNewExercise(notification: Notification) {
        if let exercise = notification.userInfo?["exerciseObject"] as? Exercise {
            exercises.value.insert(ExerciseViewModel(exercise), at: 0)
            exercises.value = exercises.value
        }
    }

    func addExecise() {
        // tell the view to show alert and get back data
        // add excercise to workout (make sure workout obserable will fire other wise find a solution)
        NotificationCenter.default.post(name: Notification.Name(NotificationName.showAddExerciseAlertView.rawValue), object: nil)
    }

    func deleteSet(at index: IndexPath) {
        exercises.value[index.section].exercise.value.sets.remove(at: index.row)
        exercises.value = exercises.value
    }

    func updateSet(_ set: Set, at index: IndexPath) {
        exercises.value[index.section].exercise.value.sets[index.row] = set
    }

    func addSet(section: Int) {
        var sets = exercises.value[section].exercise.value.sets
        let setID = Int(Date().timeIntervalSince1970)
        let newSet = Set(set: sets.count + 1, id: setID)
        sets.append(newSet)

        exercises.value[section].exercise.value.sets = sets
        exercises.value = exercises.value
    }

    func finishWorkout() {
        // saving data to workoutService
        var workouts = workoutService.getWorkouts()
        let newWorkout = Workout(id: Int(startTime.timeIntervalSince1970), name: workoutTitle.value, startTime: startTime)
        newWorkout.exercises = exercises.value.map { $0.exercise.value }
        workouts.append(newWorkout)
        workoutService.saveWorkouts(workouts)
        timer.invalidate()
        postDismissNotification()
    }


    func cancelWorkout() {
        postDismissNotification()
        timer.invalidate()
    }

    private func postDismissNotification() {
        NotificationCenter.default.post(name: NSNotification.Name(NotificationName.handleDismissView.rawValue), object: nil)
    }

}
