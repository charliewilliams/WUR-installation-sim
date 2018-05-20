//
//  StateMutatable.swift
//  WUR-installation-prototype
//
//  Created by Charlie Williams on 18/05/2018.
//  Copyright © 2018 Charlie Williams. All rights reserved.
//

import Foundation

protocol StateMutatable {

    var serial: Int { get }
    func spreadMutation(in statelet: Statelet)
    func consider(externalStatelet statelet: Statelet)
}


