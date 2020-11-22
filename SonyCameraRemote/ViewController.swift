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
            let parseDelegate = DeviceDescriptionParser()
            let parser = XMLParser(data: deviceData)
            parser.delegate = parseDelegate
            if parser.parse() {
                
            }
        }.resume()
    }
}

enum DeviceServiceType: String {
    case Camera = "camera"
    case Guide = "guide"
    case unknown = "unknown"
}

struct DeviceService {
    let serviceType: DeviceServiceType
    let actionListURL: String
}

struct DeviceInfo {
    var version: String = ""
    var services = [DeviceService]()
}

class DeviceDescriptionParser: NSObject, XMLParserDelegate {
    
    var isParsingDeviceInfo = false
    var deviceInfo = DeviceInfo()
    var charactersFoundBuffer = ""
    let deviceServices = [DeviceService]()
    var currentDeviceServiceType: DeviceServiceType = .unknown
    var currentDeviceServiceURL = ""
    
    func parserDidStartDocument(_ parser: XMLParser) {
        print("Beginning to Parse Device Info XML Doc")
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        switch elementName {
        case let name where name.hasSuffix("DeviceInfo"):
            isParsingDeviceInfo = true
            charactersFoundBuffer = ""
        case let name where name.hasSuffix("Version"):
            charactersFoundBuffer = ""
        case let name where name.hasSuffix("ServiceType"):
            currentDeviceServiceType = .unknown
        case let name where name.hasSuffix("ActionList_URL"):
            currentDeviceServiceURL = ""
        default:
            print("Unhandled XML Element Begin: \(elementName)")
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        charactersFoundBuffer += string
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        switch elementName {
        case let name where name.hasSuffix("DeviceInfo"):
            isParsingDeviceInfo = false
        case let name where name.hasSuffix("Version"):
            deviceInfo.version = charactersFoundBuffer
        case let name where name.hasSuffix("Service"):
            let newDeviceService = DeviceService(serviceType: currentDeviceServiceType, actionListURL: currentDeviceServiceURL)
            deviceInfo.services.append(newDeviceService)
        case let name where name.hasSuffix("ServiceType"):
            currentDeviceServiceType = DeviceServiceType(rawValue: charactersFoundBuffer) ?? .unknown
        case let name where name.hasSuffix("ActionList_URL"):
            currentDeviceServiceURL = charactersFoundBuffer
        default:
            print("Unhandled XML Element Ended: \(elementName)")
        }
        charactersFoundBuffer = ""
    }
    
    /// Just in case, if there's an error, report it. (We don't want to fly blind here.)
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("XML Parsing Error: \(parseError)")
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("Finishing Device Info XML Doc Parsing")
    }
}
