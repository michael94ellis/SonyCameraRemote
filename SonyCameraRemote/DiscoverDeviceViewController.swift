//
//  DiscoverDeviceViewController.swift
//  SonyCameraRemote
//
//  Created by Michael Ellis on 11/22/20.
//

import UIKit

class DiscoverDeviceViewController: UIViewController, SSDPDiscoveryDelegate {

    @IBOutlet weak var discoveryButton: UIButton!
    @IBOutlet weak var discoveredDevicesList: UITableView!
    @IBOutlet weak var wifiButton: UIButton!
    
    var connectionManager: DeviceConnectionManager?
    var didDiscoverDevice = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectionManager = DeviceConnectionManager(discoveryDelegate: self)
        discoveredDevicesList.delegate = self
        discoveredDevicesList.dataSource = self
    }
    
    @IBAction func discoveryButtonTapped(_ sender: Any) {
        guard connectionManager != nil else {
            connectionManager = DeviceConnectionManager(discoveryDelegate: self)
            if connectionManager == nil {
                self.present(UIAlertController(title: "Error", message: "Could not establish connection to any device", preferredStyle: .alert), animated: true)
            }
            return
        }
        connectionManager?.discoverCameras()
    }
    
    @IBAction func wifiButtonTapped(_ sender: UIButton) {
        var wifiAlertTitle = "Connect to WiFi"
        var wifiMessage = "Enter the Device's WiFi Name(SSID)"
        var buttonText = "Connect"
        let savedSSID = WifiController.shared.SSID
        let wifiPassword = WifiController.shared.wifiPassword
        
        // Change message if user is already connected
        if (WifiController.shared.wifiConnectionInfo()?["SSID"] as? String) != nil {
            // Currently connected to some Device's WiFi thru the app
            wifiAlertTitle = "Reconnect?"
            wifiMessage = "Enter the Device's WiFi Name(SSID)"
            buttonText = "Reconnect"
        }
        presentWiFiDialog(title: wifiAlertTitle, message: wifiMessage, buttonText: buttonText, savedSSID: savedSSID, savedPassword: wifiPassword)
    }
}

 // MARK: - WiFI Management

extension DiscoverDeviceViewController {
    
    var wifiImage: UIImage { UIImage(systemName: "wifi") ?? UIImage() }
    var wifiDisconnectedImage: UIImage { UIImage(systemName: "wifi.slash") ?? UIImage() }
    var wifiExclamationImage: UIImage { UIImage(systemName: "wifi.exclamationmark") ?? UIImage() }
    
    func presentWiFiDialog(title: String, message: String, buttonText: String, savedSSID: String, savedPassword: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = savedSSID
        }
        alert.addTextField { (textField) in
            textField.text = savedPassword
        }
        alert.addAction(UIAlertAction(title: buttonText, style: .default, handler: { _ in
            let ssidTextField = alert.textFields?[0]
            let passwordTextField = alert.textFields?[1]
            guard let newSSID = ssidTextField?.text, !newSSID.isEmpty else {
                self.wifiButton.setTitle("Invalid SSID", for: .normal)
                return
            }
            guard let newPassword = passwordTextField?.text, !newPassword.isEmpty else {
                self.wifiButton.setTitle("Invalid Password", for: .normal)
                return
            }
            if newSSID != savedSSID {
                WifiController.shared.SSID = newSSID
            }
            self.connectToDroneWiFi(ssid: newSSID, password: newPassword)
            print("Connecting to WiFi SSID: \(newSSID)")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func connectToDroneWiFi(ssid: String, password: String) {
        self.wifiButton.isEnabled = false
        WifiController.shared.connectTo(ssid: ssid, password: password) { success in
            self.wifiButton.isEnabled = true
            guard success else {
                self.wifiButton.setImage(self.wifiExclamationImage, for: .normal)
                self.wifiButton.setTitle("Not Connected", for: .normal)
                return
            }
            self.handleWiFiConnectionSuccess(ssid: ssid)
        }
    }
    
    /// Sets the label at the top of the view
    func handleWiFiConnectionSuccess(ssid: String) {
        self.wifiButton.setTitle(ssid, for: .normal)
        self.wifiButton.setImage(self.wifiImage, for: .normal)
    }
}

 // MARK: - TableView Datasource/Delegate

extension DiscoverDeviceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        didDiscoverDevice ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = UITableViewCell()
        newCell.textLabel?.text = "Sony Camera: \(DeviceInfo.version)"
        return newCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabController")
        self.present(vc, animated: true)
    }
}

 // MARK: - Device SSDP Discovery Delegate

extension DiscoverDeviceViewController: DeviceDiscoveryDelegate{
    func deviceFound() {
        self.didDiscoverDevice = true
    }
}
