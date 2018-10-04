//
//  Date + Extensions.swift
//  Week3
//
//  Created by Jason wang on 9/25/18.
//  Copyright © 2018 JasonWang. All rights reserved.
//

import Foundation

enum DateFormatString: String {
    case dMY = "E, MMM dd"
}

extension Date {
    func toString(dateFormat: DateFormatString) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.rawValue
        return dateFormatter.string(from: self)
    }

    func convertToAMorPMString() -> String {
        let hour = Calendar.current.component(.hour, from: self)
        switch hour {
        case 3..<12:
            return "Morning"
        case 12..<17:
            return "Afternoon"
        default:
            return "Evening"
        }
    }

}
