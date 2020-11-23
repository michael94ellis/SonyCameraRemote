//
//  DeviceConnectionManager.swift
//  SonyCameraRemote
//
//  Created by Michael Ellis on 11/22/20.
//

import Foundation
class DeviceConnectionManager: SSDPDiscoveryDelegate {
    
    static let shared = DeviceConnectionManager()
    private init() { }
    
    /// Client used to find devices using SSDP
    let client = SSDPClient()
    /// Holds the discovered service information retrived using SSDPClient
    private var ssdpService: SSDPService?
    
    func discoverCameras() {
        self.client.delegate = self
        self.client.discoverSonyCameras()
    }
    
    /// Look for devices using SSDP - Simple Service Discovery Protocol
    func ssdpDiscovery(_ discovery: SSDPClient, didDiscoverService service: SSDPService) {
        ssdpService = service
        guard let deviceInfoLocation = ssdpService?.location, let deviceInfoURL = URL(string: deviceInfoLocation) else {
            print("Error creating DeviceInfo URL")
            return
        }
        DeviceRequestManager.shared.requestDeviceInfo(deviceInfoURL)
    }
    
    ///
    func parseDeviceInfo(_ deviceData: Data) {
        let parser = XMLParser(data: deviceData)
        parser.delegate = DeviceDescriptionParser.shared
        if parser.parse() {
            print("Successful Device Description XML Doc Parse")
        } else {
            print("Error: Failed to parse Device Description XML Doc")
        }
    }
}
