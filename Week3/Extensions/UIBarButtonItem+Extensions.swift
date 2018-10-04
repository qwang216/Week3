//
//  UIBarButtonItem+Extensions.swift
//  Week3
//
//  Created by Jason wang on 9/28/18.
//  Copyright © 2018 JasonWang. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    func addTarget(target: AnyObject, action: Selector) {
        self.target = target
        self.action = action
    }
}
