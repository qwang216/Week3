//
//  HistorySectionHeaderView.swift
//  Week3
//
//  Created by Jason wang on 9/27/18.
//  Copyright © 2018 JasonWang. All rights reserved.
//

import UIKit

class HistorySectionHeaderView: UIView {


    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var workoutTitleLabel: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }

    static func initializeViewFromNib() -> HistorySectionHeaderView {
        return UINib(nibName: "HistorySectionHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! HistorySectionHeaderView
    }



}
