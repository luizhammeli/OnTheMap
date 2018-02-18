//
//  LocationTableViewCell.swift
//  OnTheMap
//
//  Created by Luiz Hammerli on 14/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    var location:Location?{
        didSet{
            guard let location = location else {return}
            nameLabel.text = "\(location.firstName) \(location.lastName)"
            urlLabel.text = location.mediaURL
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
}
