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

class Statue: SCNNode {
    fileprivate override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(size: CGFloat, hitResult: ARHitTestResult) {
        super.init()

        let scene = SCNScene(named: "art.scnassets/shyguy.dae")!
        let node = scene.rootNode.childNode(withName: "statue", recursively: true)
        
        node?.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        node?.physicsBody?.categoryBitMask = 1
        node?.physicsBody?.restitution = 0
        node?.physicsBody?.damping = 1
        position = SCNVector3(hitResult.worldTransform.columns.3.x,
                              hitResult.worldTransform.columns.3.y + Float(0.1),
                              hitResult.worldTransform.columns.3.z)

    }
}
