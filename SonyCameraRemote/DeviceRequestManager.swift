//
//  DeviceRequestManager.swift
//  SonyCameraRemote
//
//  Created by Michael Ellis on 11/22/20.
//

import Foundation

struct DeviceRequest {
    let method: String
    let params: [String]
    let id: Int
    let version: String
}

struct DeviceResponse {
    /// If the request fails, "result" member is skipped
    let result: [String]
    /// If the request succeeds, "error" member is skipped in the response
    let error: (errorCode: Int, message: String)
    /// The client must set "version" member in the request. The type of "version" value is string and the version can be set as 2 numbers separated by dot (e.g. "1.0")
    let version: String
}

class DeviceRequestManager {
    
    static let shared = DeviceRequestManager()
    private init() { }
}
