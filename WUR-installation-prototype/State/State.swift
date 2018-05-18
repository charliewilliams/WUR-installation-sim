//
//  State.swift
//  WUR-installation-prototype
//
//  Created by Charlie Williams on 18/05/2018.
//  Copyright © 2018 Charlie Williams. All rights reserved.
//

import Foundation

class State {

    var statelets = [Statelet]()

    init() { }

    // a way to update the leds based on the sum of the current statelets
    func tick() {
        statelets.forEach { $0.tick() }
    }

    
}
