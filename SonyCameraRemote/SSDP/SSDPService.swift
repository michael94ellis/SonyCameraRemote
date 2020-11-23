//
//  SSDPService.swift
//  SonyCameraRemote
//
//  Created by Michael Ellis on 11/22/20.
//

import Foundation

public class SSDPService {
    
    /// The host of service
    public private(set) var host: String
    /// The value of `LOCATION` header
    public private(set) var location: String?
    /// The value of `SERVER` header
    public private(set) var server: String?
    /// The value of `ST` header
    public private(set) var searchTarget: String?
    /// The value of `USN` header
    public private(set) var uniqueServiceName: String?

    /**
        Initialize the `SSDPService` with the discovery response.

        - Parameters:
            - host: The host of service
            - response: The discovery response.
    */
    init(host: String, response: String) {
        self.host = host
        self.location = self.parse(header: "LOCATION", in: response)
        self.server = self.parse(header: "SERVER", in: response)
        self.searchTarget = self.parse(header: "ST", in: response)
        self.uniqueServiceName = self.parse(header: "USN", in: response)
    }

    /**
        Parse the discovery response.

        - Parameters:
            - header: The header to parse.
            - response: The discovery response.
    */
    private func parse(header: String, in response: String) -> String? {
        if let range = response.range(of: "\(header): .*", options: .regularExpression) {
            var value = String(response[range])
            value = value.replacingOccurrences(of: "\(header): ", with: "")
            return value
        }
        return nil
    }
}
