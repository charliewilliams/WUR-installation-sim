//
//  InstallationScene.swift
//  WUR-installation-prototype
//
//  Created by Charlie Williams on 18/05/2018.
//  Copyright © 2018 Charlie Williams. All rights reserved.
//

import SpriteKit
import GameplayKit

class InstallationScene: SKScene {

    var cells = [Cell]()

    // WHY
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()

    private var lastUpdateTime : TimeInterval = 0

    override func sceneDidLoad() {
        super.sceneDidLoad()

        anchorPoint = .zero

        let xStride = 720/6
        let yStride = 320/3

        for y in 1...4 {
            for x in 1...5 {

                let cell = CellBuilder.cell(radius: 30)
                cells.append(cell)
                cell.position = CGPoint(x: x * xStride, y: (6 - y) * yStride)

                addChild(cell)
            }
        }

        for cell in cells {
            CellBuilder.findNeighbors(for: cell, in: cells.filter { $0 != cell })
        }
        for cell in cells {
            CellBuilder.labelPorts(on: cell)
        }

        // HACK
        cells[12].state.statelets.first?.mutate()
    }

    override func mouseUp(with event: NSEvent) {

        let cell = CellBuilder.cell(radius: 30)
        cells.append(cell)
        cell.position = event.location(in: self)

        addChild(cell)
    }

    override func keyDown(with event: NSEvent) {

        guard let key = event.charactersIgnoringModifiers?.first else {
            return
        }

        switch key {
        case " ":
            cells.forEach { $0.toggleDebug() }
        default:
            break
        }
    }

    // Boilerplate
    override func update(_ currentTime: TimeInterval) {

        // Initialize _lastUpdateTime if it has not already been
        if lastUpdateTime == 0 {
            lastUpdateTime = currentTime
        }

        // Calculate time since last update
        let dt = currentTime - lastUpdateTime

        // Update entities
        for entity in entities {
            entity.update(deltaTime: dt)
        }

        for cell in cells {
            cell.tick(dt: dt)
        }

        lastUpdateTime = currentTime
    }
}
