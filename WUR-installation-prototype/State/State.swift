//
//  State.swift
//  WUR-installation-prototype
//
//  Created by Charlie Williams on 18/05/2018.
//  Copyright © 2018 Charlie Williams. All rights reserved.
//

import Foundation

class State {

    private(set) var statelets = [Statelet()]

    init() { }

    func tick(dt: TimeInterval) {

        statelets.forEach { $0.tick(dt: dt) }
    }

    func integrate(_ newStatelet: Statelet) {

        // only one statelet for each motion type is allowed
        statelets = statelets.filter { $0.motion != newStatelet.motion }
        statelets.append(newStatelet)
    }
}
