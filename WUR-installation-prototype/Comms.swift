//
//  Comms.swift
//  WUR-installation-prototype
//
//  Created by Charlie Williams on 18/05/2018.
//  Copyright © 2018 Charlie Williams. All rights reserved.
//

import Foundation

class Comms {

    static let shared = Comms()

    private let ports: [Port] = [Port(.n), Port(.e), Port(.s), Port(.w)]

    private init() { }

    func spreadMutation(in statelet: Statelet) {

        ports.randomItem().pass(statelet)
    }
}
