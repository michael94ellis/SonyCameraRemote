//
//  DeviceConnectionManager.swift
//  SonyCameraRemote
//
//  Created by Michael Ellis on 11/22/20.
//

import Foundation

protocol DeviceDiscoveryDelegate: class {
    func deviceFound()
}

class DeviceConnectionManager: SSDPDiscoveryDelegate {
    
    init(discoveryDelegate: DeviceDiscoveryDelegate) {
        self.delegate = discoveryDelegate
    }
    private weak var delegate: DeviceDiscoveryDelegate?
    
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
        requestDeviceInfo(deviceInfoURL)
    }
    
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
            self.parseDeviceInfo(deviceData)
        }.resume()
    }
    
    /// After receiving device info, parse the DeviceDescription XML doc
    func parseDeviceInfo(_ deviceData: Data) {
        let parser = XMLParser(data: deviceData)
        parser.delegate = DeviceDescriptionParser.shared
        if parser.parse() {
            print("Successful Device Description XML Doc Parse")
            delegate?.deviceFound()
        } else {
            print("Error: Failed to parse Device Description XML Doc")
        }
    }
}
