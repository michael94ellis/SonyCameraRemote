//
//  ViewController.swift
//  SonyCameraRemote
//
//  Created by Michael Ellis on 11/22/20.
//

import UIKit

class DiscoverDeviceViewController: UIViewController, SSDPDiscoveryDelegate {

    @IBOutlet weak var discoveryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DeviceConnectionManager.shared.discoverCameras()
    }
    
    @IBAction func discoveryButtonTapped(_ sender: Any) {
        DeviceConnectionManager.shared.discoverCameras()
    }
}
