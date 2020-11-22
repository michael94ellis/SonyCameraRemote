//
//  DeviceDataModels.swift
//  SonyCameraRemote
//
//  Created by Michael Ellis on 11/22/20.
//

enum DeviceServiceType: String {
    /// To get supported API services.
    case Camera = "camera"
    /// To get/set camera settings, and access shooting functions.
    case Guide = "guide"
    /// To get/set system settings.
    case System = "system"
    /// To access still images and movies stored in a media.
    case AVContent = "avContent"
    case unknown = "unknown"
}

struct DeviceService {
    let serviceType: DeviceServiceType
    let actionListURL: String
    
    var endpointURL: String { actionListURL + "/" + serviceType.rawValue }
}

struct DeviceInfo {
    
    static var shared = DeviceInfo()
    
    var version: String = ""
    var services = [DeviceService]()
}
