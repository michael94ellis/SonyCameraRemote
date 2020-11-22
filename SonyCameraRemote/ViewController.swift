//
//  ViewController.swift
//  SonyCameraRemote
//
//  Created by Michael Ellis on 11/22/20.
//

import UIKit

class ViewController: UIViewController, SSDPDiscoveryDelegate {
    
    /// Client used to discovery cameras using SSDP
    let client = SSDPClient()
    var ssdpService: SSDPService?

    @IBOutlet weak var discoveryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        discoverCameras()
    }
    
    @IBAction func discoveryButtonTapped(_ sender: Any) {
        discoverCameras()
    }
    
    func discoverCameras() {
        self.client.delegate = self
        self.client.discoverSonyCameras()
    }
    
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
    
    func parseDeviceInfo(_ deviceData: Data) {
        let parseDelegate = DeviceDescriptionParser()
        let parser = XMLParser(data: deviceData)
        parser.delegate = parseDelegate
        if parser.parse() {
            DeviceInfo.shared = parseDelegate.deviceInfo
        }
    }
}
