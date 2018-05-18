//
//  Statelet.swift
//  WUR-installation-prototype
//
//  Created by Charlie Williams on 18/05/2018.
//  Copyright © 2018 Charlie Williams. All rights reserved.
//

import Cocoa

class Statelet {

    class Color: NSColor {
        static var rouge = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        static var greeen = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        static var oranges = #colorLiteral(red: 0.9083227515, green: 0.4916348457, blue: 0, alpha: 1)
        static var lightPurple = #colorLiteral(red: 0.8429682851, green: 0.780713737, blue: 0.9477006793, alpha: 1)
        static var purpled = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    }

    struct Pattern {
        let ledInitialStates = [Int: Color]()
    }

    enum Motion {
        case none
        case clockwise
        case anticlockwise
    }

    enum Pulse {
        case none
        case breathe
        case warble
        case flutter
        case flicker
        case flash
        case doubleFlash
    }

    let pattern = Pattern()
    let motion: Motion = .none
    let pulse: Pulse = .none
    
    var mutatability: Float = 0 // what should these default values be?
    var resilience: Float = 0
    var relativeSpeed: Float = 0

    init() {

    }

    func tick() {

        if mutatability > Float(arc4random_uniform(100)) {
            mutate()
        }
    }

    /* internal mutation; slight changes in the pattern. Can change
        - neighbouring LED states within pattern
        - motion
        - relativeSpeed
        - mutatability
        - resilience
     */
    private func mutate() {

        resilience.drift(amount: mutatability)
        relativeSpeed.drift(amount: mutatability)
        mutatability.drift(amount: mutatability)
    }
}
