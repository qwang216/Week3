//
//  Double+Extensions.swift
//  Week3
//
//  Created by Jason wang on 10/4/18.
//  Copyright © 2018 JasonWang. All rights reserved.
//

import Foundation

extension Double {
    func formatNumberToStringAndRoundTo(_ decimalPlaces: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.roundingMode = .down
        numberFormatter.maximumFractionDigits = decimalPlaces
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
