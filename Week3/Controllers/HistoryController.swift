//
//  ViewController.swift
//  Week3
//
//  Created by Jason wang on 9/17/18.
//  Copyright © 2018 JasonWang. All rights reserved.
//

import UIKit

class HistoryController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var startWorkoutButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var welcomeMessageLabel: UILabel!

    var historyViewModel: HistoryViewModel?

    static let storyBoardID = "HistoryControllerSBID"

    override func viewDidLoad() {
        super.viewDidLoad()
        startWorkoutButton.addTarget(self, action: #selector(handleStartWorkoutButton), for: .touchUpInside)
        setupTableView()
        setupViewModelBindProperty()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        historyViewModel?.refreshData()
    }

    func setupViewModelBindProperty() {
        historyViewModel?.workouts.bind { [unowned self] _ in
            self.tableView.reloadData()
        }
        historyViewModel?.message.bind { [unowned self] in
            self.welcomeMessageLabel.text = $0
        }
    }

    func setupTableView() {
        tableView.backgroundColor = .purple
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WorkoutCell.instanceFromNib(), forCellReuseIdentifier: WorkoutCell.cellID)
    }

    @objc func handleStartWorkoutButton() {
        performSegue(withIdentifier: "WorkoutControllerSegueID", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WorkoutControllerSegueID" {
            let destinationVC = segue.destination as! WorkoutController
            let date = Date()
            destinationVC.workoutViewModel = WorkoutViewModel(workout: Workout(id: Int(date.timeIntervalSince1970), name: "New Workout", startTime: date))
        }
    }
}

extension HistoryController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return historyViewModel?.workouts.value.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WorkoutCell.cellID, for: indexPath) as! WorkoutCell
        cell.workoutHistoryViewModel = historyViewModel?.workouts.value[indexPath.section]
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HistorySectionHeaderView.initializeViewFromNib()
        let workout = historyViewModel?.workouts.value[section]
        headerView.dateLabel.text = workout?.dateString.value
        headerView.workoutTitleLabel.text = (workout?.nameString.value ?? "") + " Exercise"

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(70)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }


}
