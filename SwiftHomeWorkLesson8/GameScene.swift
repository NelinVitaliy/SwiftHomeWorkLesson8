//
//  GameScene.swift
//  SwiftHomeWorkLesson8
//
//  Created by N3L1N on 05/01/2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var snake:Snake?
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.purple
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsBody?.allowsRotation = false
        
        view.showsPhysics = true
        
        //create button 1
        let counterClockWiseButton = SKShapeNode()
        counterClockWiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        counterClockWiseButton.position = CGPoint(x: view.scene!.frame.minX + 30, y: view.scene!.frame.minY + 30)
        counterClockWiseButton.fillColor = UIColor.red
        counterClockWiseButton.strokeColor = UIColor.red
        counterClockWiseButton.lineWidth = 10
        counterClockWiseButton.name = "counterClockWiseButton"
        self.addChild(counterClockWiseButton)
        
        
        //create button 2
        
        let clockWiseButton = SKShapeNode()
        clockWiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        clockWiseButton.position = CGPoint(x: view.scene!.frame.maxX - 80, y: view.scene!.frame.minY + 30)
        clockWiseButton.fillColor = UIColor.red
        clockWiseButton.strokeColor = UIColor.red
        clockWiseButton.lineWidth = 10
        clockWiseButton.name = "clockWiseButton"
        self.addChild(clockWiseButton)
        
        // create apple
        createApple()
        
        snake = Snake(atPoint: CGPoint(x: view.scene!.frame.midX,
                                       y: view.scene!.frame.midY))
        self.addChild(snake!)
        
        self.physicsWorld.contactDelegate = self
        
        self.physicsBody?.categoryBitMask = CollusionCategories.EdgeBody
        self.physicsBody?.categoryBitMask = CollusionCategories.Snake | CollusionCategories.SnakeHead
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            guard let touchedNode = self.atPoint(touchLocation) as? SKShapeNode,touchedNode.name == "counterClockWiseButton" || touchedNode.name == "clockWiseButton"
            else {return}
        
            touchedNode.fillColor = .blue
            
            if touchedNode.name == "clockWiseButton" {
                snake!.moveClockWise()
            } else if touchedNode.name == "counterClockWiseButton" {
                snake!.moveCounterClockWise()
            }
        }
  
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            guard let touchedNode = self.atPoint(touchLocation) as? SKShapeNode,touchedNode.name == "counterClockWiseButton" || touchedNode.name == "clockWiseButton"
            else {return}
        
            touchedNode.fillColor = .red
        
    }
}
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        snake!.move()
    }
    
    func createApple(){
        let randX = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX - 10)))
        let randY = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY - 10)))
    
        let apple = Apple(position: CGPoint(x: randX, y: randY))
        self.addChild(apple)
    }
}

extension GameScene:SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let bodies = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        let collusionObject = bodies - CollusionCategories.SnakeHead
        
        switch collusionObject {
        case CollusionCategories.Apple:
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            snake!.addBody()
            apple?.removeFromParent()
            createApple()
            
        case CollusionCategories.EdgeBody:
            snake?.removeFromParent()
            snake = Snake(atPoint: CGPoint(x: view!.scene!.frame.midX, y: view!.scene!.frame.midY))
            self.addChild(snake!)
        default:
            break
        }
    }
}
