//
//  DeviceDescriptionXMLParser.swift
//  SonyCameraRemote
//
//  Created by Michael Ellis on 11/22/20.
//

import Foundation

class DeviceDescriptionParser: NSObject, XMLParserDelegate {
    
    static let shared = DeviceDescriptionParser()
    private override init() { }

    var deviceInfo = DeviceInfo()

    private var isParsingDeviceInfo = false
    private var charactersFoundBuffer = ""
    private let deviceServices = [DeviceService]()
    private var currentDeviceServiceType: DeviceServiceType = .unknown
    private var currentDeviceServiceURL = ""
    
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
            DeviceInfo.version = charactersFoundBuffer
        case let name where name.hasSuffix("Service"):
            let newDeviceService = DeviceService(serviceType: currentDeviceServiceType, actionListURL: currentDeviceServiceURL)
            DeviceInfo.services.append(newDeviceService)
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
