//
//  WiFiController.swift
//  SonyCameraRemote
//
//  Created by Michael Ellis on 11/23/20.
//

import Foundation
import UIKit
import NetworkExtension
import SystemConfiguration.CaptiveNetwork

class WifiController: NSObject {
    
    static var shared = WifiController()
    
    deinit {
        NEHotspotConfigurationManager.shared.removeConfiguration(forSSID: SSID)
    }
    // Remember the users WiFi name between sessions
    private let SSIDKey = "SSID"
    var SSID: String {
        get { UserDefaults.standard.string(forKey: SSIDKey) ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: SSIDKey) }
    }
    // Remember the users WiFi password between sessions
    private let passwordKey = "WIFIPASSWORD"
    var wifiPassword: String {
        get { UserDefaults.standard.string(forKey: passwordKey) ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: passwordKey) }
    }
    
    private var hotspotConfig: NEHotspotConfiguration?
    
    func connectTo(ssid: String, password: String, completion: @escaping (Bool) -> ()) {
        hotspotConfig = NEHotspotConfiguration(ssid: SSID)
        guard let hotspotConfig = hotspotConfig else {
            print("Error while connecting to Device WiFi")
            return
        }
        hotspotConfig.joinOnce = true
        NEHotspotConfigurationManager.shared.removeConfiguration(forSSID: ssid)
        NEHotspotConfigurationManager.shared.apply(hotspotConfig) { [weak self] (error) in
            guard let self = self else { return }
            if let error = error {
                print(self.handleConnectionError(error))
                completion(false)
            } else if self.wifiConnectionInfo() != nil {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    /// Determine if we are connected to any wifi network or none at all
    func wifiConnectionInfo() -> [AnyHashable: Any]? {
        guard let ifs = CFBridgingRetain( CNCopySupportedInterfaces()) as? [String],
            let ifName = ifs.first as CFString?,
            let wifiInfo = CFBridgingRetain( CNCopyCurrentNetworkInfo((ifName))) as? [AnyHashable: Any] else {
                return nil
        }
        return wifiInfo
    }
    
    private func handleConnectionError(_ error: Error) -> String {
        let nsError = error as NSError
        if nsError.domain == "NEHotspotConfigurationErrorDomain" {
            if let configError = NEHotspotConfigurationError(rawValue: nsError.code) {
                switch configError {
                case .invalidWPAPassphrase:
                    return "Invalid Password"
                case .invalidSSID:
                    return "Invalid SSID"
                case .invalidSSIDPrefix:
                    return "Invlaid SSID Prefix"
                case .invalid, .invalidWEPPassphrase,
                     .invalidEAPSettings,
                     .invalidHS20Settings,
                     .invalidHS20DomainName,
                     .userDenied,
                     .pending,
                     .systemConfiguration,
                     .unknown,
                     .joinOnceNotSupported,
                     .alreadyAssociated,
                     .applicationIsNotInForeground,
                     .internal:
                    return "Connection Error"
                @unknown default:
                    return "Unknown Error"
                }
            }
        }
        return "Unknown Error"
    }
}
