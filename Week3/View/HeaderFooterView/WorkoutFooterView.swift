//
//  WorkoutFooterView.swift
//  Week3
//
//  Created by Jason wang on 9/30/18.
//  Copyright © 2018 JasonWang. All rights reserved.
//

import UIKit

class WorkoutFooterView: UIView {

    @IBOutlet weak var addSetButton: UIButton!

    var addSetSelector: ((Set) -> Void)?
    var nextSet: Set?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        addSetButton.addTarget(self, action: #selector(handleAddSetButton), for: .touchUpInside)
        addSetButton.layer.borderWidth = 3
        addSetButton.layer.borderColor = UIColor.lightGray.cgColor
    }

    static func initFromNib() -> UINib {
        return UINib(nibName: "WorkoutFooterView", bundle: nil)
    }

    @objc private func handleAddSetButton() {
        if let set = nextSet {
            addSetSelector?(set)
        }
    }

}
