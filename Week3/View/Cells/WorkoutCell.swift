//
//  WorkoutRoutineCell.swift
//  Week3
//
//  Created by Jason wang on 9/25/18.
//  Copyright © 2018 JasonWang. All rights reserved.
//

import UIKit

class WorkoutCell: UITableViewCell {
    static let cellID = "WorkoutCellID"
    @IBOutlet weak var collectionView: UICollectionView!
    let flowLayout = UICollectionViewFlowLayout()
    var workoutHistoryViewModel: WorkoutHistoryViewModel?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()

    }
    static func instanceFromNib() -> UINib {
        return UINib(nibName: "WorkoutCell", bundle: nil)
    }

    func setupCollectionView() {
        flowLayout.estimatedItemSize = CGSize(width: 200, height: 200)
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 180, height: 180)
        collectionView.collectionViewLayout = flowLayout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ExerciseCell.initNib(), forCellWithReuseIdentifier: ExerciseCell.cellID)
    }


}

extension WorkoutCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return workoutHistoryViewModel?.exerciseViewModels.value.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExerciseCell.cellID, for: indexPath) as! ExerciseCell
        let currentExercise = workoutHistoryViewModel?.exerciseViewModels.value[indexPath.item].exercise.value
            cell.set(currentExercise!)
        return cell
    }





}
