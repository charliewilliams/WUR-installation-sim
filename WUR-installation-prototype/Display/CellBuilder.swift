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

    static func cell(id: Int) -> Cell {

        let cell = Cell(id: id)

        // configure pixels on it
        for i in 0..<pixelCount {

            let pixel = Pixel(id: i)
            let degrees = (360.0 / CGFloat(pixelCount)) * CGFloat(i)
            let radians = degrees.degreesToRadians
            pixel.zRotation = radians
            pixel.position = CGPoint(x: cos(degrees), y: sin(degrees))

            cell.addChild(pixel)
        }

        return cell
    }
}
