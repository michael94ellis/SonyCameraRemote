//
//  DeviceRequestManager.swift
//  SonyCameraRemote
//
//  Created by Michael Ellis on 11/22/20.
//

import Foundation

struct DeviceRequest {
    let params: [String]
    let id: Int
    let version: String
    let method: String
}

struct DeviceResponse {
    /// If the request fails, "result" member is skipped
    let result: [String]?
    /// If the request succeeds, "error" member is skipped in the response
    let error: (errorCode: Int, message: String)?
    /// The client must set "version" member in the request. The type of "version" value is string and the version can be set as 2 numbers separated by dot (e.g. "1.0")
    let id: Int
}

class DeviceRequestManager {
    
    static let shared = DeviceRequestManager()
    private init() { }
    
    func postDeviceServiceRequest(serviceURL: String, request: DeviceRequest, completionHandler: @escaping (DeviceResponse) -> ()) {
        guard let serviceRequestURL = URL(string: serviceURL) else {
            print("Error: Service URL cannot be converted to type URL: \(serviceURL)")
            return
        }
        var serviceRequest = URLRequest(url: serviceRequestURL)
        serviceRequest.httpMethod = "POST"
        URLSession.shared.dataTask(with: serviceRequest) { data, response, error in
            guard error == nil else {
                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            guard let data = data else {
                print("Error: Data was nil")
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                print("Error: Response data could not be converted to JSON")
                return
            }
            let resultsKey = json.keys.contains("result") ? "result" : "results"
            guard let results = json[resultsKey] as? [String] else {
                print("Error parsing results array from device response")
                return
            }
            guard json.keys.contains("id"), let id = json["id"] as? Int else {
                print("Error parsing id from device response")
                return
            }
            completionHandler(DeviceResponse(result: results, error: nil, id: id))
        }
    }
}
