//
//  WorkoutController.swift
//  Week3
//
//  Created by Jason wang on 9/28/18.
//  Copyright © 2018 JasonWang. All rights reserved.
//

import UIKit

class WorkoutController: UIViewController {

    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var finishBarButton: UIBarButtonItem!
    @IBOutlet weak var addExerciseButton: UIButton!

    @IBOutlet weak var currentWorkoutNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var workoutViewModel: WorkoutViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCells()
        let date = Date()
        let workoutID = Int(date.timeIntervalSince1970)
        let workout =  Workout(id: workoutID, name: "", startTime: date)
        workoutViewModel = WorkoutViewModel(workout: workout)
        cancelBarButton.addTarget(target: self, action: #selector(handleCancelButton))
        finishBarButton.addTarget(target: self, action: #selector(handleFinishButton))
        addExerciseButton.addTarget(self, action: #selector(handleAddExerciseButton), for: .touchUpInside)
        navigationController?.navigationBar.isHidden = false
        viewModelBinding()
        addNotificationObserver()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func handleAddExerciseButton() {
        workoutViewModel?.addExecise()
        scrollToLastItem()
    }

    private func viewModelBinding() {
        workoutViewModel?.workoutTitle.bind { [unowned self] in
            self.currentWorkoutNameLabel.text = "\($0) Execise"
        }
        workoutViewModel?.exercises.bind { [unowned self] _ in
            self.tableView.reloadData()
        }
        workoutViewModel?.timeTracker.bind { [unowned self] in
            self.title = $0
        }
    }

    private func registerTableViewCells() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SetCell.initNib(), forCellReuseIdentifier: SetCell.cellID)
    }

    @objc func handleCancelButton() {
        workoutViewModel?.cancelWorkout()
    }

    @objc func handleFinishButton() {
        workoutViewModel?.finishWorkout()
    }
    
}

extension WorkoutController {

    func addNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(showAddExerciseAlertView), name: Notification.Name(NotificationName.showAddExerciseAlertView.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleDismissView), name: Notification.Name(NotificationName.handleDismissView.rawValue), object: nil)
    }

    @objc func handleDismissView() {
        navigationController?.popViewController(animated: true)
    }

    @objc func showAddExerciseAlertView() {
        let alertView = UIAlertController(title: "Add Exercise", message: "Enter an exercise name", preferredStyle: .alert)
        alertView.addTextField { (textField) in
            textField.placeholder = "Exercise Name"
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        let addButton = UIAlertAction(title: "Add", style: .default) { (_) in
            if let textField = alertView.textFields?.first {
                if let exerciseName = textField.text {
                    let date = Date()
                    let exerciseID = Int(date.timeIntervalSince1970)
                    let exercise = Exercise(id: exerciseID, startTime: date, name: exerciseName)
                    NotificationCenter.default.post(name: Notification.Name(NotificationName.addNewExercise.rawValue), object: self, userInfo: ["exerciseObject": exercise])
                }
            }
        }
        alertView.addAction(cancelButton)
        alertView.addAction(addButton)
        present(alertView, animated: true, completion: nil)
    }

}

extension WorkoutController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return workoutViewModel?.exercises.value.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutViewModel?.exercises.value[section].exercise.value.sets.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SetCell.cellID, for: indexPath) as! SetCell
        cell.textFieldHandler = { [weak self] set in
            self?.workoutViewModel?.updateSet(set, at: indexPath)
        }
        if let set = workoutViewModel?.exercises.value[indexPath.section].exercise.value.sets[indexPath.row] {
            cell.setWorkoutSet(set)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            // Not sure if this is proper MVVM.
            workoutViewModel?.deleteSet(at: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let workoutHeaderView = WorkoutHeaderView.initFromNib().instantiate(withOwner: nil, options: nil).first as! WorkoutHeaderView
        let workout = workoutViewModel?.exercises.value[section].exercise.value.name
        workoutHeaderView.exerciseNameLabel.text = workout
        workoutHeaderView.backgroundColor = .red
        return workoutHeaderView
    }



    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let workoutFooterView = WorkoutFooterView.initFromNib().instantiate(withOwner: nil, options: nil).first as! WorkoutFooterView
        if let setNumber = workoutViewModel?.exercises.value.count {
            workoutFooterView.nextSet = Set(set: setNumber + 1, id: Int(Date().timeIntervalSince1970))
        }
        workoutFooterView.addSetSelector = { [weak self] set in
            self?.workoutViewModel?.addSet(section: section)
            self?.scrollToLastItem()
        }
        return workoutFooterView
    }

    func scrollToLastItem() {
        self.tableView.reloadData()
        if let exercises = self.workoutViewModel?.exercises.value {
            if let lastItem = exercises.last?.exercise.value.sets.count {
                let lastExercise = exercises.count - 1
                let indexPath = IndexPath(item: lastItem - 1, section: lastExercise )
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(50)
    }

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }

}
