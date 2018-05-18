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

extension BinaryInteger {
    var degreesToRadians: CGFloat { return CGFloat(Int(self)) * .pi / 180 }
}

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}
