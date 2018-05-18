//
//  Float.swift
//  WUR-installation-prototype
//
//  Created by Charlie Williams on 18/05/2018.
//  Copyright © 2018 Charlie Williams. All rights reserved.
//

import Foundation

extension Float {

    // TODO use some kind of noise source instead of random
    mutating func drift(amount: Float) {
        let change = Float(arc4random_uniform(UInt32(amount))) - (amount / 2)
        self += change
    }
}
