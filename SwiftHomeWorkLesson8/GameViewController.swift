//
//  GameViewController.swift
//  SwiftHomeWorkLesson8
//
//  Created by N3L1N on 05/01/2022.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene(size: view.bounds.size)
        
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        
        }
}

