//
//  SnakeHead.swift
//  SwiftHomeWorkLesson8
//
//  Created by N3L1N on 05/01/2022.
//

import UIKit

class SnakeHead: SnakeBodyPart {
    override init(atPoint point: CGPoint) {
        super.init(atPoint: point)
        
        self.physicsBody?.categoryBitMask = CollusionCategories.SnakeHead
        self.physicsBody?.contactTestBitMask = CollusionCategories.EdgeBody | CollusionCategories.Apple | CollusionCategories.Snake
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    
    
