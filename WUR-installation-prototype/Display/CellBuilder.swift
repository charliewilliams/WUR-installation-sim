//
//  CellBuilder.swift
//  WUR-installation-prototype
//
//  Created by Charlie Williams on 18/05/2018.
//  Copyright © 2018 Charlie Williams. All rights reserved.
//

import Foundation

struct CellBuilder {

    static let pixelCount = 12

    static func cell(id: Int, radius: CGFloat) -> Cell {

        let cell = Cell(id: id, radius: radius)

        // configure pixels on it
        for i in 0..<pixelCount {

            let pixel = Pixel(id: i, size: radius / 4)
            let degrees = (360.0 / CGFloat(pixelCount)) * CGFloat(i + 3)
            let radians = degrees.degreesToRadians
            pixel.zRotation = radians
            pixel.position = CGPoint(x: cos(radians) * radius * 0.8, y: sin(radians) * radius * 0.8)

            cell.addChild(pixel)
        }

        return cell
    }
}
