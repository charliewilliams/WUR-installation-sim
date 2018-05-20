//
//  Statelet.swift
//  WUR-installation-prototype
//
//  Created by Charlie Williams on 18/05/2018.
//  Copyright © 2018 Charlie Williams. All rights reserved.
//

import Cocoa

class Statelet {

    struct Pattern {
        let ledInitialStates = [Int: NSColor]()
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

    var pattern = [NSColor](repeating: NSColor.black, count: 12)

    var motion: Motion = .clockwise
    var rotation: Float = 0

    var pulse: Pulse = .none
    var alpha: CGFloat = 0
    
    var mutatability: Float = 0.1 // what should these default values be?
    var virality: Float = 0.5
    var resilience: Float = 0
    var relativeSpeed: Float = 0.5

    var mutationElapsedTime: TimeInterval = 0
    var mutationRequiredTime: TimeInterval = 1

    init() { }

    func tick(dt: TimeInterval) {

        if dt == 0 { return }

        switch motion {
        case .clockwise:
            rotation += relativeSpeed / Float(dt)
        case .anticlockwise:
            rotation -= relativeSpeed / Float(dt)
        default: break
        }

        let intR = Int(rotation)
        if intR > pattern.count { rotation = Float(intR % pattern.count) }
        if intR < 0 { rotation = Float(intR % -pattern.count) }

        switch pulse {
        case .breathe:
            break
            // TODO implement the rest of these - in subclasses ideally
        default:
            break
        }

        if mutationElapsedTime >= mutationRequiredTime {
            mutationElapsedTime = 0
            if mutatability > Float.random(in: 0...100) {
                mutate()
            }
        } else {
            mutationElapsedTime += dt
        }
    }

    /* internal mutation; slight changes in the pattern. Can change
        - neighbouring LED states within pattern
        - motion
        - relativeSpeed
        - mutatability
        - resilience
     */
    func mutate() {
        
        // todo - change pattern etc
        pattern[3] = .oranges

        // drift these numbers
        resilience.drift(amount: mutatability)
        relativeSpeed.drift(amount: mutatability)
        mutatability.drift(amount: mutatability)
    }
}
