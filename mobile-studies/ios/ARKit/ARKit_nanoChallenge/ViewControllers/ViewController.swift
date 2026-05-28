//
//  ViewController.swift
//  ARKit_nanoChallenge
//
//  Created by Ana Carolina Silva on 26/02/18.
//  Copyright © 2018 Ana Carolina Silva. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    // MARK: - Outlets
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var placedFlagsLabel: UILabel!
    
    // MARK: - Attributes
    var segueIdentifier = "segueIdentifier"
    
    var currentStatus = ARSessionState.initialized {
        didSet {
            DispatchQueue.main.async { self.statusLabel.text = self.currentStatus.description }
            if currentStatus == .failed {
                cleanUpARSession()
            }
        }
    }
    
    var planes = [UUID: VirtualPlane]() {
        didSet {
            if planes.count > 0 {
                currentStatus = .ready
            } else {
                if currentStatus == .ready {
                    currentStatus = .initialized
                }
            }
        }
    }
    
    var selectedPlane: VirtualPlane?
    var flagNodes = [SCNNode]()
    var firstFlagNode: SCNNode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        self.sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        self.sceneView.showsStatistics = true
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, SCNDebugOptions.showConstraints, SCNDebugOptions.showLightExtents]
        self.sceneView.automaticallyUpdatesLighting = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        self.sceneView.scene = scene
        
        self.initializeFlagNode()
    }
    
    // MARK: - ViewController life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        guard ARWorldTrackingConfiguration.isSupported else {
            showUnsupportedDeviceError()
            return
        }
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        self.sceneView.session.run(configuration)
        if self.planes.count > 0 {
            self.currentStatus = .ready
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        self.sceneView.session.pause()
        self.currentStatus = .temporarilyUnavailable
    }
    
    // MARK: - Configuration of nodes and light
    func initializeFlagNode() {
        let flagScene = SCNScene(named: "Assets.scnassets/flag.scn")!
        
        let flagNode = flagScene.rootNode.childNode(withName: "base", recursively: true)!
        
        flagNode.scale = SCNVector3(1.0, 0.5, 0.5)
        
        self.firstFlagNode = flagNode
    }
    
    private func updateLightEstimate() {
        guard let currentFrame = sceneView.session.currentFrame,
            let lightEstimate = currentFrame.lightEstimate else {
                return
        }
        
        let neutralIntensity: CGFloat = 1000
        let ambientIntensity = min(lightEstimate.ambientIntensity, neutralIntensity)
        let blendFactor = 1 - ambientIntensity / neutralIntensity
        
//        for node in self.sceneView.scene.rootNode.childNodes {
//            node.
//        }
    }
    
    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let arPlaneAnchor = anchor as? ARPlaneAnchor {
            let plane = VirtualPlane(anchor: arPlaneAnchor)
            self.planes[arPlaneAnchor.identifier] = plane
            node.addChildNode(plane)
            print("Plane added: \(plane)")
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let arPlaneAnchor = anchor as? ARPlaneAnchor, let plane = planes[arPlaneAnchor.identifier] {
            plane.updateWithNewAnchor(arPlaneAnchor)
        }
        updateLightEstimate()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        if let arPlaneAnchor = anchor as? ARPlaneAnchor, let index = planes.index(forKey: arPlaneAnchor.identifier) {
            self.planes.remove(at: index)
        }
    }
    
    // MARK: - Cleaning up the session
    func cleanUpARSession() {
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) -> Void in
            node.removeFromParentNode()
        }
    }
    
    // MARK: - Session tracking methods
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        self.currentStatus = .failed
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        self.currentStatus = .temporarilyUnavailable
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        self.currentStatus = .ready
    }
    
    // MARK: - Selecting planes and adding out flags.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        if self.currentStatus != .ready { return }
        
        let touchPoint = touch.location(in: sceneView)
        
        if let plane = virtualplaneProperlySet(touchPoint: touchPoint) {
            addFlagToPlane(plane: plane, atPoint: touchPoint)
        }
    }
    
    func virtualplaneProperlySet(touchPoint: CGPoint) -> VirtualPlane? {
        let hits = sceneView.hitTest(touchPoint, types: .existingPlaneUsingExtent)
        if hits.count > 0, let firstHit = hits.first, let identifier = firstHit.anchor?.identifier, let plane = planes[identifier] {
            self.selectedPlane = plane
            return plane
        }
        return nil
    }
    
    func addFlagToPlane(plane: VirtualPlane, atPoint point: CGPoint) {
        let hits = self.sceneView.hitTest(point, types: .existingPlaneUsingExtent)
        if hits.count > 0, let firstHit = hits.first, let flag = self.firstFlagNode {
            let anotherFlagYesPlease = flag.clone()
            anotherFlagYesPlease.position = SCNVector3Make(firstHit.worldTransform.columns.3.x, firstHit.worldTransform.columns.3.y, firstHit.worldTransform.columns.3.z)
            
            self.flagNodes.append(anotherFlagYesPlease)
            self.sceneView.scene.rootNode.addChildNode(anotherFlagYesPlease)
            
            handlePlacedFlags()
        }
    }
    
    // MARK: - Handle placed flags
    func handlePlacedFlags() {
        self.placedFlagsLabel.text = "Placed flags: \(self.flagNodes.count)/5"
        
        if self.flagNodes.count == 5 {
            let alertController = UIAlertController(
                title: "You have placed all the flags",
                message: "Now it's time to hand over your iPhone to a friend and let's the game begin",
                preferredStyle: .alert
            )
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.performSegue(withIdentifier: self.segueIdentifier, sender: self)
            }))
            
            present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: - Internal methods
    private func showUnsupportedDeviceError() {
        // This device does not support 6DOF world tracking.
        let alertController = UIAlertController(
            title: "ARKit is not available on this device.",
            message: "This app requires world tracking, which is available only on iOS devices with the A9 processor or later.",
            preferredStyle: .alert
        )
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
}
