//
//  Obserable.swift
//  Week3
//
//  Created by Jason wang on 9/27/18.
//  Copyright © 2018 JasonWang. All rights reserved.
//

import Foundation

class Obserable<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }

    func unbind() {
        listener = nil
    }
}
