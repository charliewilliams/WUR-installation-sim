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
    var elapsed: TimeInterval = 0

    var pixels = [Pixel]()
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

    func tick(dt: TimeInterval) {
        
        state.tick(dt: dt)

        var colors = [NSColor](repeating: NSColor.black, count: 12)

        for statelet in state.statelets {
            for i in 0..<statelet.pattern.count {

                let index = abs((i + Int(statelet.rotation)) % statelet.pattern.count)
                let color = statelet.pattern[index]
                // colors[i] += color
                colors[i] = color
            }
        }

        for (i, pixel) in pixels.enumerated() {
            pixel.color = colors[i]
        }
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
