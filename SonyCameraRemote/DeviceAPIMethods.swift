//
//  DeviceAPIMethods.swift
//  SonyCameraRemote
//
//  Created by Michael Ellis on 11/22/20.
//

import Foundation

enum DeviceAPIMethod {
    /// get the supported shoot modes.
    /// The client should use "getAvailableShootMode" to get the available parameters at the moment.
    static let getSupportedShootMode = "getSupportedShootMode"
    /// Current Shoot Mode
    static let getShootMode = "getShootMode"
    /// Set Shoot Mode
    static let setShootMode = "setShootMode"
    /// get current shoot mode and the available shoot modes at the moment.
    static let getAvailableShootMode = "getAvailableShootMode"
    
    /// tell device to take a picture
    static let actTakePicture = "actTakePicture"
    /// provides a function to call on to know when to wait while the camera is taking a picture
    static let awaitTakePicture = "awaitTakePicture"
}
