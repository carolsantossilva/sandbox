//
//  ARSessionState.swift
//  ARKit_nanoChallenge
//
//  Created by Ana Carolina Silva on 27/02/18.
//  Copyright © 2018 Ana Carolina Silva. All rights reserved.
//

import Foundation

enum ARSessionState: String, CustomStringConvertible {
    case initialized = "initialized"
    case ready = "ready"
    case temporarilyUnavailable = "temporarily unavailable"
    case failed = "failed"
    
    var description: String {
        switch self {
        case .initialized:
            return "Look for a plane to place your flag"
        case .ready:
            return "Click any plane to place your flag!"
        case .temporarilyUnavailable:
            return "Please wait"
        case .failed:
            return "Please restart App."
        }
    }
}
