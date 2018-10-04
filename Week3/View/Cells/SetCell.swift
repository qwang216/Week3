//
//  SetCell.swift
//  Week3
//
//  Created by Jason wang on 9/30/18.
//  Copyright © 2018 JasonWang. All rights reserved.
//

import UIKit

class SetCell: UITableViewCell {
    @IBOutlet weak var setLabel: UILabel!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var repetitionTextField: UITextField!

    var textFieldHandler: ((_ set: Set) -> Void)?
    private var updateSet: Set? {
        didSet {
            if let set = updateSet {
                textFieldHandler?(set)
            }
        }
    }

    static let cellID = "SetCellID"
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTextFieldTargetAndKeyboardType()
    }

    func setupTextFieldTargetAndKeyboardType() {
        weightTextField.addTarget(self, action: #selector(handleWeightTextFieldValueChanged), for: .allEditingEvents)
        repetitionTextField.addTarget(self, action: #selector(handleRepetitionTextFieldValueChanged), for: .allEditingEvents)
        weightTextField.keyboardType = .decimalPad
        repetitionTextField.keyboardType = .numberPad

        weightTextField.placeholder = "Ibs"
        weightTextField.textAlignment = .center
        repetitionTextField.placeholder = "#"
        repetitionTextField.textAlignment = .center

    }

    override func prepareForReuse() {
        weightTextField.text = nil
        repetitionTextField.text = nil
    }

    func setWorkoutSet(_ set: Set) {
        setLabel.text = "\(set.set)"
        weightTextField.placeholder = "\(set.weight)"
        repetitionTextField.placeholder = "\(set.repetition)"
        updateSet = set
    }

    static func initNib() -> UINib {
        return UINib(nibName: "SetCell", bundle: nil)
    }

    @objc func handleWeightTextFieldValueChanged(textField: UITextField) {
        updateSet?.weight = Double(textField.text ?? "") ?? 0
    }

    @objc func handleRepetitionTextFieldValueChanged(textField: UITextField) {
        updateSet?.repetition = Int(textField.text ?? "") ?? 0
    }

}
