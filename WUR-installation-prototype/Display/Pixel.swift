//
//  Pixel.swift
//  WUR-installation-prototype
//
//  Created by Charlie Williams on 18/05/2018.
//  Copyright © 2018 Charlie Williams. All rights reserved.
//

import SpriteKit

let debugColors: [NSColor] = [.red, .orange, .yellow, .green,
                                     .blue, .purple, .brown, .black,
                                     .gray, .pink, .cyan, .magenta]

class Pixel: SKSpriteNode {

    convenience init(id: Int) {
        self.init(color: debugColors[id % debugColors.count], size: CGSize(width: 10, height: 10))
    }

    override init(texture: SKTexture!, color: NSColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
