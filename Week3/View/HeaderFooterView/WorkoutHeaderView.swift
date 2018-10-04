//
//  WorkoutHeaderView.swift
//  Week3
//
//  Created by Jason wang on 9/30/18.
//  Copyright © 2018 JasonWang. All rights reserved.
//

import UIKit

class WorkoutHeaderView: UIView {

    @IBOutlet weak var exerciseNameLabel: UILabel!
    
    static func initFromNib() -> UINib {
        return UINib(nibName: "WorkoutHeaderView", bundle: nil)
    }
}
