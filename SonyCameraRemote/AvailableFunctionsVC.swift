//
//  AvailableFunctionsVC.swift
//  SonyCameraRemote
//
//  Created by Michael Ellis on 11/23/20.
//

import UIKit

class AvailableFunctionsVC: UIViewController {
    @IBOutlet weak var availableFunctionsList: UITableView!
    
    var funcs = [String]()
    
    override func viewDidLoad() {
        let request = DeviceRequest(params: [], id: 1, version: "1.0", method: CameraServiceMethods.getAvailableApiList)
        
        DeviceRequestManager.shared.postDeviceServiceRequest(serviceURL: "camera", request: request) { response in
            guard response.error == nil else {
                print("Error returned requesting Available APIs: Code \(response.error?.errorCode ?? -999) :: Message \(response.error?.message ?? "NO MESSAGE")")
                return
            }
            guard let result = response.result else {
                print("Error: No result returned requesting Available APIs")
                return
            }
            self.funcs = result
            DispatchQueue.main.async {
                self.availableFunctionsList.reloadData()
            }
        }
    }
    
}

extension AvailableFunctionsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        funcs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = UITableViewCell()
        newCell.textLabel?.text = funcs[indexPath.row]
        return newCell
    }
}
