//
//  Statue.swift
//  AROritaSensei
//
//  Created by KAWASE Hiroya on 2019/02/22.
//  Copyright © 2019 KAWASE Hiroya. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class Statue {
    
    static func create(width: CGFloat) -> SCNNode {

        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        let node = scene.rootNode.childNode(withName: "statue", recursively: true)
        
        let (min, max) = (node?.boundingBox)!
        let w = CGFloat(max.x - min.x)
        let magnification = width / w
        node?.scale = SCNVector3(magnification, magnification, magnification)
        node?.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        node?.physicsBody?.categoryBitMask = 1
        node?.physicsBody?.restitution = 0
        node?.physicsBody?.damping = 1
        return node!
    }
}
