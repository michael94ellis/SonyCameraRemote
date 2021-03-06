//
//  DeviceDataModels.swift
//  SonyCameraRemote
//
//  Created by Michael Ellis on 11/22/20.
//

enum DeviceServiceType: String {
    /// To get/set camera settings, and access shooting functions
    case Camera = "camera"
    /// To get supported API services
    case Guide = "guide"
    /// To get/set system settings
    case System = "system"
    /// To access still images and movies stored in a media
    case AVContent = "avContent"
    /// This is indicative of an error or unset value during XML parsing
    case unknown = "unknown"
}

struct DeviceService {
    let serviceType: DeviceServiceType
    let actionListURL: String
    
    var endpointURL: String { actionListURL + "/" + serviceType.rawValue }
}

struct DeviceInfo {
    static var version: String = ""
    static var services = [DeviceService]()
}
