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
            let parser = XMLParser(data: deviceData)
            parser.delegate = self
            if parser.parse() {
                
            }
        }.resume()
    }
}

extension ViewController: XMLParserDelegate {
    // initialize results structure
    
    func parserDidStartDocument(_ parser: XMLParser) {
        print("Beginning to Parse Device Info XML Doc")
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        // TODO: Which of these is the one we want???
        
        if elementName.contains("ServiceType") {
            print(attributeDict)
        }
        if elementName.contains("ServiceType") {
            // Record Available Service Type
            print(attributeDict)
        } else if elementName.contains("ActionList_URL") {
            // Record URL for Service Type
            print(attributeDict)
        }
    }
    
    /// Just in case, if there's an error, report it. (We don't want to fly blind here.)
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("XML Parsing Error: \(parseError)")
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("Finishing Device Info XML Doc Parsing")

    }
}
