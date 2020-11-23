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
    
    func requestDeviceInfo(_ deviceInfoURL: URL) {
        let deviceInfoRequest = URLRequest(url: deviceInfoURL)
        URLSession.shared.dataTask(with: deviceInfoRequest) { data, response, error in
            if let error = error {
                print("Device Info Responded with ERROR: \(error.localizedDescription)")
                return
            }
            guard let deviceData = data else {
                print("No Device Data Retrieved from Device Info Request")
                return
            }
            DeviceConnectionManager.shared.parseDeviceInfo(deviceData)
        }.resume()
    }
    
    func postDeviceServiceRequest(serviceURL: String, request: DeviceRequest, completionHandler: @escaping (DeviceResponse) -> ()) {
        guard let serviceRequestURL = URL(string: serviceURL) else {
            print("Error: Service URL cannot be converted to type URL: \(serviceURL)")
            return
        }
        var serviceRequest = URLRequest(url: serviceRequestURL)
        serviceRequest.httpMethod = "POST"
        URLSession.shared.dataTask(with: serviceRequest) { data, response, error in
//            guard let response = response else {
//                print("Error: No response from \(#function)")
//                return
//            }
//            
            // TODO
        }
    }
    
}
