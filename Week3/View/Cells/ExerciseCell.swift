//
//  ExerciseCell.swift
//  Week3
//
//  Created by Jason wang on 9/25/18.
//  Copyright © 2018 JasonWang. All rights reserved.
//

import UIKit

class ExerciseCell: UICollectionViewCell {
    static let cellID = "ExerciseCellID"

    @IBOutlet weak var exerciseNameLabel: UILabel!

    @IBOutlet var setLabels: [UILabel]!
    @IBOutlet var oneRepMaxLabels: [UILabel]!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .purple
        resetLabelText()
    }

    static func initNib() -> UINib {
        return UINib(nibName: "ExerciseCell", bundle: nil)
    }

    override func prepareForReuse() {
        resetLabelText()
    }

    func resetLabelText() {
        _ = setLabels.map { $0.text = nil }
        _ = oneRepMaxLabels.map { $0.text = nil }
    }

    func set(_ exercise: Exercise) {
        exerciseNameLabel.text = exercise.name
        for (index, set) in exercise.sets.enumerated() {
            guard setLabels.count - 1 >= index else { return }
            let setString = "\(index + 1)) \(set.weight)Ibs x \(set.repetition)"
            setLabels[index].text = setString
            oneRepMaxLabels[index].text = "\(set.oneRepetitionMax)"
        }
    }

}
