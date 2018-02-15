//
//  LocationsTableViewController.swift
//  OnTheMap
//
//  Created by Luiz Hammerli on 14/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

class LocationsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: Strings.LocationsTableViewControllerCellID, for: indexPath) as! LocationTableViewCell
        cell.nameLabel?.text = "Luiz Hammerli"
        cell.urlLabel?.text = "https://www.udacity.com"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let url = URL(string: "https://www.udacity.com") else {
            AlertController.showAlert(title: "", message: Strings.invalidLink, viewController: self)
            self.tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: { (true) in
            self.tableView.deselectRow(at: indexPath, animated: true)
        })
    }

}
