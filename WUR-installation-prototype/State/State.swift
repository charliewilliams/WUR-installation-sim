//
//  State.swift
//  WUR-installation-prototype
//
//  Created by Charlie Williams on 18/05/2018.
//  Copyright © 2018 Charlie Williams. All rights reserved.
//

import Foundation

/*
 A `none` pattern can merge with an external pattern
 A `dynamic` pattern just gets overwritten if it's moving in the same direction
 However, a `none` pattern can mutate to start being dynamic, in which case it replaces any local dynamic pattern of the same direction (?)
 */

class State {

    private(set) var statelets = [Statelet()]

    init() { }

    func tick(dt: TimeInterval) {

        statelets.forEach { $0.tick(dt: dt) }
    }

    func integrate(_ newStatelet: Statelet) {

        // only one statelet for each motion type is allowed
        // `none` is handled specially because we can merge multiple `none` patterns
        if newStatelet.direction == .none, let existingNone = statelets.filter({ $0.direction == .none }).first {

            // this is what we want to do:
//            existingNone.pattern |= newStatelet.pattern

            // manually overwrite any pixels existing in the new pattern
            for index in 0..<newStatelet.pattern.count {

                if newStatelet.pattern[index] != .black {
                    existingNone.pattern[index] = newStatelet.pattern[index]
                }
            }

        } else {
            statelets = statelets.filter { $0.direction != newStatelet.direction }
            statelets.append(newStatelet)
        }
    }
}
