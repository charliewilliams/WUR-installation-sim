//
//  ViewController.swift
//  WUR-installation-prototype
//
//  Created by Charlie Williams on 18/05/2018.
//  Copyright © 2018 Charlie Williams. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {

    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let scene = GKScene(fileNamed: "InstallationScene"),
            let node = scene.rootNode as? InstallationScene else {
                return
        }

        node.entities = scene.entities // wtf
        node.graphs = scene.graphs

        node.scaleMode = .aspectFill

        skView.presentScene(node)

        skView.ignoresSiblingOrder = true
    }
}

