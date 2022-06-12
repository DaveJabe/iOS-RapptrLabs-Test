//
//  FireScene.swift
//  Rapptr iOS Test
//
//  Created by David Jabech on 6/11/22.
//

import Foundation
import SpriteKit

class FireScene: SKScene {
    let fireEmitterNode = SKEmitterNode(fileNamed: "FireParticles")
    
    override func didMove(to view: SKView) {
        guard let fireEmitterNode = fireEmitterNode else { return }
        fireEmitterNode.particleSize = CGSize(width: 50, height: 50)
        fireEmitterNode.particleLifetime = 2
        fireEmitterNode.particleLifetimeRange = 6
        addChild(fireEmitterNode)
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        guard let fireEmitterNode = fireEmitterNode else { return }
        fireEmitterNode.particlePosition = CGPoint(x: size.width/2, y: size.height)
        fireEmitterNode.particlePositionRange = CGVector(dx: size.width, dy: size.height)
    }
}
