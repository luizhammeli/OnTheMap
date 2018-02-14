//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Luiz Hammerli on 14/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

class AddLocationViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var findLocationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    func setUpViews(){
        findLocationButton.layer.cornerRadius = 6
        emailTextField.setUpTextFieldPlaceHolder()
        locationTextField.setUpTextFieldPlaceHolder()
    }

    @IBAction func returnToMainViewController(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

