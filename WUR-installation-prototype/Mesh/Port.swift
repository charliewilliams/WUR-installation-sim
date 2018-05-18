//
//  Port.swift
//  WUR-installation-prototype
//
//  Created by Charlie Williams on 18/05/2018.
//  Copyright © 2018 Charlie Williams. All rights reserved.
//

/*
 TODO
 use a state machine here?
 */

/*
 Some of this looks over-engineered in the simulation version bc we just have a reference to our neighbours; we don't have to do any serial port malarkey
 */

import Foundation

class Port {

    enum State {
        case inactive
        case listening
        case sending
        case receiving
    }
    enum Name {
        case n, e, s, w
    }

    private(set) var state: Port.State = .inactive
    let name: Name

    // in this simulation we just have a reference to the partner on this port
    // in the tangible version this will involve a whole serial connection
    var partner: StateMutatable?

    init(_ name: Name) {
        self.name = name
    }

    func activate() -> Bool {

        if [.sending, .receiving].contains(state) {
            return false
        }

        // Todo for tangible version: actually start a connection on the port indicated
        state = .sending
        return true
    }

    func deactivate() {

        state = .listening
    }

    func pass(_ statelet: Statelet) {

        if activate() {

            // Todo for tangible version:
            // startTransmissionAnimation() {
            //      stopTransmissionAnimation()
            //      deactivate()
            // }
            partner?.consider(externalStatelet: statelet)
        }
    }
}
