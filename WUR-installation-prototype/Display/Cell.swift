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

        let north = cells.filter { $0.position.y > position.y }.filter(sameColumn).sorted(by: verticalSort).first
        let south = cells.filter { $0.position.y < position.y }.filter(sameColumn).sorted(by: verticalSort).first

        let east = cells.filter(sameRow)
        let west = cells.filter(sameRow)

//        var minNdist = CGFloat.greatestFiniteMagnitude
//        var minEdist = CGFloat.greatestFiniteMagnitude
//        var minSdist = CGFloat.greatestFiniteMagnitude
//        var minWdist = CGFloat.greatestFiniteMagnitude
//
//        let aboveAndBelow = cells.filter { abs(position.x - $0.position.x) < radius }
//        let leftAndRight = cells.filter { abs(position.y - $0.position.y) < radius }
//
//        for cell in aboveAndBelow {
//
//            if cell == self { continue }
//
//            // N
//            if cell.position.y - position.y < minNdist {
//                minNdist = position.y - cell.position.y
//                ports[0].partner = cell
//            }
//            // S
//            if position.y - cell.position.y < minSdist {
//                minSdist = cell.position.y - position.y
//                ports[2].partner = cell
//            }
//        }
//
//        for cell in leftAndRight {
//
//            if cell == self { continue }
//
//            // E
//            if cell.position.x - position.x < minWdist {
//                minWdist = cell.position.x - position.x
//                ports[3].partner = cell
//            }
//            // W
//            if position.x - cell.position.x < minEdist {
//                minEdist = position.x - cell.position.x
//                ports[1].partner = cell
//            }
//        }
    }

    func tick() {
        state.tick()
    }
}

extension Cell: StateMutatable {

    func consider(externalStatelet statelet: Statelet) {

    }
}
