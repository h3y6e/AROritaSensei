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
    
    // Hide status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
        
    }
    
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
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapView))
//        sceneView.addGestureRecognizer(gesture)
    }
    
    // Tap View
//    @objc func tapView(recognizer: UIGestureRecognizer) {
//
//        let sceneView = recognizer.view as! ARSCNView
//        let touchLocation = recognizer.location(in: sceneView)
//
//        let hitTestResult = sceneView.hitTest(touchLocation, types: .existingPlaneUsingExtent)
//        if !hitTestResult.isEmpty {
//            if let hitResult = hitTestResult.first {
//            }
//        }
//    }
    
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
    
    func loadStatue() -> SCNNode {
        let url = Bundle.main.url(forResource: "art.scnassets/shyguy", withExtension: "dae")!
        let statueSceneSource = SCNSceneSource(url: url, options: nil)!
        let statueNode = statueSceneSource.entryWithIdentifier("statue", withClass: SCNNode.self)!
        return statueNode
    }

    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        node.addChildNode(loadStatue())

    }
}
