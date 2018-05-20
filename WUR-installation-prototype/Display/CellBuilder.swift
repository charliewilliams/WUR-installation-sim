//
//  CellBuilder.swift
//  WUR-installation-prototype
//
//  Created by Charlie Williams on 18/05/2018.
//  Copyright © 2018 Charlie Williams. All rights reserved.
//

import SpriteKit

private var serial = 1

struct CellBuilder {

    static let pixelCount = 12

    static func cell(radius: CGFloat) -> Cell {

        let cell = Cell(radius: radius)

        buildPixels(for: cell, radius: radius)

        return cell
    }

    static func buildPixels(for cell: Cell, radius: CGFloat) {

        for i in 0..<pixelCount {

            let pixel = Pixel(id: i, size: radius / 4)
            let degrees = (360.0 / CGFloat(pixelCount)) * CGFloat(i + 3)
            let radians = degrees.degreesToRadians
            pixel.zRotation = radians
            pixel.position = CGPoint(x: cos(radians) * radius * 0.8, y: sin(radians) * radius * 0.8)

            cell.addChild(pixel)
            cell.pixels.append(pixel)
        }

        // add debug label
        cell.serial = serial
        let debugLabel = SKLabelNode(text: "\(serial)")
        debugLabel.verticalAlignmentMode = .center
        serial += 1
        cell.addChild(debugLabel)
    }

    static func labelPorts(on cell: Cell) {

        // add debug label of port numbers
        for (index, port) in cell.ports.enumerated() {
            let number = port.partner?.serial ?? -1
            let debugLabel = SKLabelNode(text: "\(port.name):\(number)")
            debugLabel.fontSize = 12
            debugLabel.fontName = "Helvetica-Bold"
            debugLabel.verticalAlignmentMode = .center

            let radians = (90 * CGFloat(cell.ports.count - index + 1)).degreesToRadians
            debugLabel.position = CGPoint(x: cos(radians) * cell.radius * 1.4, y: sin(radians) * cell.radius * 1.2)

            cell.addChild(debugLabel)
            cell.debugLabels.append(debugLabel)
        }
    }

    static func findNeighbors(for cell: Cell, in cells: [Cell]) {

        let spread = cell.radius * 2
        let sameColumn: ((SKNode) -> (Bool)) = { abs($0.position.x - cell.position.x) < spread }
        let sameRow: ((SKNode) -> (Bool)) = { abs($0.position.y - cell.position.y) < spread }

        let verticalSort: ((SKNode, SKNode) -> (Bool)) = { abs($0.position.y - cell.position.y) < abs($1.position.y - cell.position.y) }
        let horizontalSort: ((SKNode, SKNode) -> (Bool)) = { abs($0.position.x - cell.position.x) < abs($1.position.x - cell.position.x) }

        let north = cells.filter { $0.position.y > cell.position.y }.filter(sameColumn).sorted(by: verticalSort).first
        let south = cells.filter { $0.position.y < cell.position.y }.filter(sameColumn).sorted(by: verticalSort).first

        let east = cells.filter { $0.position.x > cell.position.x }.filter(sameRow).sorted(by: horizontalSort).first
        let west = cells.filter { $0.position.x < cell.position.x }.filter(sameRow).sorted(by: horizontalSort).first

        for (index, partner) in [north, east, south, west].enumerated() {
            cell.ports[index].partner = partner
        }
    }
}
