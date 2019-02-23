//
//  ViewController.swift
//  AROritaSensei
//
//  Created by KAWASE Hiroya on 2019/02/22.
//  Copyright © 2019 KAWASE Hiroya. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var statueNode: SCNNode? = nil
    
    // Hide status bar
    override var prefersStatusBarHidden: Bool { return true }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation { return .slide }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Automatically add lights to a scene
        sceneView.autoenablesDefaultLighting = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        // Add tap gesture
        sceneView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapView)))
    }
    
    @objc func tapView(recognizer: UIGestureRecognizer) {
        let sceneView = recognizer.view as! ARSCNView
        let touchLocation = recognizer.location(in: sceneView)
        
        // Get point coplanar with an already detected plane
        let hitTestResult = sceneView.hitTest(touchLocation, types: .existingPlane)
        if !hitTestResult.isEmpty {
            
            // Get camera information
            if let camera = sceneView.pointOfView {
                if statueNode == nil {
                    
                    // Create a statue
                    statueNode = Statue.create(width: 0.05, angles: camera.eulerAngles, hitResult: hitTestResult.first!)
                    sceneView.scene.rootNode.addChildNode(statueNode!)
                } else {
                    
                    // Update statue's angles and position
                    Statue.update(node: statueNode!, angles: camera.eulerAngles, hitResult: hitTestResult.first!)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Activate horizontal plane detection
        configuration.planeDetection = .horizontal
        
        // Adapt light infomation on screen
        configuration.isLightEstimationEnabled = true

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
}
