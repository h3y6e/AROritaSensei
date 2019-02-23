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
    static func create(width: CGFloat, angles: SCNVector3, hitResult: ARHitTestResult) -> SCNNode{
        
        // Create a scene from assets
        let scene = SCNScene(named: "art.scnassets/shyguy.scn")!
        
        // Create a node
        let node = SCNNode()
        for childNode in scene.rootNode.childNodes {
            node.addChildNode(childNode)
        }
        
        // Set scale
        let (min, max) = (node.boundingBox)
        let magnification = width / CGFloat(max.x - min.x)
        node.scale = SCNVector3(magnification, magnification, magnification)
        
        // Set position
        node.position = SCNVector3(hitResult.worldTransform.columns.3.x,
                                   hitResult.worldTransform.columns.3.y,
                                   hitResult.worldTransform.columns.3.z)
        
        // Set y angles
        node.eulerAngles.y = angles.y
        
        return node
    }
    
    static func update(node: SCNNode?, angles: SCNVector3, hitResult: ARHitTestResult) {
        
        // Update x and z position
        node?.position.x = hitResult.worldTransform.columns.3.x
        node?.position.z = hitResult.worldTransform.columns.3.z
        
        // Update y angles
        node?.eulerAngles.y = angles.y
        return
    }
}
