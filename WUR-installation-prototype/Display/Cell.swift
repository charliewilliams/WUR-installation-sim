//
//  Cell.swift
//  WUR-installation-prototype
//
//  Created by Charlie Williams on 18/05/2018.
//  Copyright © 2018 Charlie Williams. All rights reserved.
//

import SpriteKit

class Cell: SKShapeNode {

    var serial: Int = 0
    let radius: CGFloat

    var ring = [Pixel]()
    var state = State()
    let ports: [Port] = [Port(.n), Port(.e), Port(.s), Port(.w)]

    var debugLabels: [SKLabelNode]  = []

    init(radius: CGFloat) {

        self.radius = radius

        super.init()

        path = CGPath(roundedRect: CGRect(origin: CGPoint(x: -radius, y: -radius), size: CGSize(width: radius * 2, height: radius * 2)), cornerWidth: radius, cornerHeight: radius, transform: nil)
    }

    required init?(coder aDecoder: NSCoder) {

        self.radius = 30

        super.init(coder: aDecoder)

        CellBuilder.buildPixels(for: self, radius: radius)
    }

    func findNeighbors(in cells: [Cell]) {

        let spread = radius * 2
        let sameColumn: ((SKNode) -> (Bool)) = { abs($0.position.x - self.position.x) < spread }
        let sameRow: ((SKNode) -> (Bool)) = { abs($0.position.y - self.position.y) < spread }

        let verticalSort: ((SKNode, SKNode) -> (Bool)) = { abs($0.position.y - self.position.y) < abs($1.position.y - self.position.y) }
        let horizontalSort: ((SKNode, SKNode) -> (Bool)) = { abs($0.position.x - self.position.x) < abs($1.position.x - self.position.x) }

        let north = cells.filter { $0.position.y > position.y }.filter(sameColumn).sorted(by: verticalSort).first
        let south = cells.filter { $0.position.y < position.y }.filter(sameColumn).sorted(by: verticalSort).first

        let east = cells.filter { $0.position.x > position.x }.filter(sameRow).sorted(by: horizontalSort).first
        let west = cells.filter { $0.position.x < position.x }.filter(sameRow).sorted(by: horizontalSort).first

        for (index, partner) in [north, east, south, west].enumerated() {
            ports[index].partner = partner
        }
    }

    func tick() {
        state.tick()
    }

    func toggleDebug() {

        for label in debugLabels {
            label.isHidden = !label.isHidden
        }
    }
}

extension Cell: StateMutatable {

    func spreadMutation(in statelet: Statelet) {

        ports.randomItem().pass(statelet)
    }

    func consider(externalStatelet statelet: Statelet) {

        // virality is 0...1 so at most we have a 50% chance of accepting the mutation
        let accept = Float.random(in: 0...2) < statelet.virality

        if accept {
            state.integrate(statelet)
        }
    }
}
