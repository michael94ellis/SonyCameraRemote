//
//  SSDPDiscovery.swift
//  SonyCameraRemote
//
//  Created by Michael Ellis on 11/22/20.
//

import Foundation
import Socket

// MARK: Protocols

/// Delegate for service discovery
public protocol SSDPDiscoveryDelegate { }
// Makes implementation of protocol methods optional
public extension SSDPDiscoveryDelegate {
    /// Tells the delegate a requested service has been discovered.
    func ssdpDiscovery(_ discovery: SSDPClient, didDiscoverService service: SSDPService) { }
    /// Tells the delegate that the discovery ended due to an error.
    func ssdpDiscovery(_ discovery: SSDPClient, didFinishWithError error: Error) { }
    /// Tells the delegate that the discovery has started.
    func ssdpDiscoveryDidStart(_ discovery: SSDPClient) { }
    /// Tells the delegate that the discovery has finished.
    func ssdpDiscoveryDidFinish(_ discovery: SSDPClient) { }
}

/// SSDP discovery for UPnP devices on the LAN
public class SSDPClient {

    /// The UDP socket
    private var socket: Socket?
    /// Delegate for service discovery
    public var delegate: SSDPDiscoveryDelegate?
    /// The client is discovering
    public var isDiscovering: Bool {
        self.socket != nil
    }

    deinit {
        self.stop()
    }

    /// Read responses.
    private func readResponses() {
        do {
            var data = Data()
            let (bytesRead, address) = try self.socket!.readDatagram(into: &data)

            if bytesRead > 0 {
                let response = String(data: data, encoding: .utf8)
                let (remoteHost, _) = Socket.hostnameAndPort(from: address!)!
                self.delegate?.ssdpDiscovery(self, didDiscoverService: SSDPService(host: remoteHost, response: response!))
            }

        } catch let error {
            self.forceStop()
            self.delegate?.ssdpDiscovery(self, didFinishWithError: error)
        }
    }

    /// Read responses with timeout.
    private func readResponses(forDuration duration: TimeInterval) {
        let queue = DispatchQueue.global()

        queue.async() {
            while self.isDiscovering {
                self.readResponses()
            }
        }

        queue.asyncAfter(deadline: .now() + duration) { [unowned self] in
            self.stop()
        }
    }

    /// Force stop discovery closing the socket.
    private func forceStop() {
        if self.isDiscovering {
            self.socket?.close()
        }
        self.socket = nil
    }

    /**
        Discover SSDP services for a duration.
        - Parameters:
            - duration: The amount of time to wait.
            - searchTarget: The type of the searched service.
    */
    open func discoverSonyCameras(forDuration duration: TimeInterval = 10) {
        self.delegate?.ssdpDiscoveryDidStart(self)
        let address = "239.255.255.250"
        let port: Int32 = 1900
        let message =
            "M-SEARCH * HTTP/1.1\r\n" +
            "HOST: \(address):\(port)\r\n" +
            "MAN: \"ssdp:discover\"\r\n" +
            "MX: \(Int(duration))\r\n" +
            "ST: urn:schemas-sony-com:service:ScalarWebAPI:1\r\n"

        do {
            self.socket = try Socket.create(type: .datagram, proto: .udp)
            guard let socket = socket else {
                print("Failed to create Socket!")
                return
            }
            try socket.listen(on: 0)
            
            guard let socketAddress = Socket.createAddress(for: address, on: port) else {
                print("Failed to create Socket Address!")
                return
            }
            self.readResponses(forDuration: duration)
            try socket.write(from: message, to: socketAddress)
            
        } catch {
            self.forceStop()
            self.delegate?.ssdpDiscovery(self, didFinishWithError: error)
        }
    }

    /// Stop the discovery before the timeout.
    open func stop() {
        if self.socket != nil {
            self.forceStop()
            self.delegate?.ssdpDiscoveryDidFinish(self)
        }
    }
}
