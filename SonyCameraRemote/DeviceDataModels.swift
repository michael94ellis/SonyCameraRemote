//
//  DeviceDataModels.swift
//  SonyCameraRemote
//
//  Created by Michael Ellis on 11/22/20.
//

enum DeviceServiceType: String {
    case Camera = "camera"
    case Guide = "guide"
    case unknown = "unknown"
}

struct DeviceService {
    let serviceType: DeviceServiceType
    let actionListURL: String
}

struct DeviceInfo {
    
    static var shared = DeviceInfo()
    
    var version: String = ""
    var services = [DeviceService]()
}
