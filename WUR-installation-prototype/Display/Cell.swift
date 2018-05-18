//
//  Cell.swift
//  WUR-installation-prototype
//
//  Created by Charlie Williams on 18/05/2018.
//  Copyright © 2018 Charlie Williams. All rights reserved.
//

import SpriteKit

let radius: CGFloat = 30

class Cell: SKShapeNode {

    let id: Int

    var ring = [Pixel]()
    var state = State()

    init(id: Int) {
        self.id = id

        super.init()

        path = CGPath(roundedRect: CGRect(origin: CGPoint(x: -radius, y: -radius), size: CGSize(width: radius * 2, height: radius * 2)), cornerWidth: radius, cornerHeight: radius, transform: nil)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func tick() {
        state.tick()
    }
}
