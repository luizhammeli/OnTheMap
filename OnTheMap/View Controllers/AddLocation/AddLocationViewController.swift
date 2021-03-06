//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Luiz Hammerli on 14/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

class AddLocationViewController: UIViewController {

    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var findLocationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    func setUpViews(){
        findLocationButton.layer.cornerRadius = 6
        locationTextField.setUpTextFieldPlaceHolder()
        urlTextField.setUpTextFieldPlaceHolder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addNotification()
    }

    @IBAction func returnToMainViewController(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func finishAddLocation(){
        
        guard let location = locationTextField.text, let url = urlTextField.text else {return}
        
        if(!location.isEmpty && !url.isEmpty){
            if URL.isValid(url){
                self.performSegue(withIdentifier: Strings.FinishAddLocation, sender: (location, url))
            }else{
                AlertController.showAlert(title: Strings.LocationNotFoundTitleMessage, message: Strings.InvalidURLMessage, viewController: self)
            }
            return
        }
        AlertController.showAlert(title: Strings.LocationNotFoundTitleMessage, message: Strings.LocationNotFoundMessage, viewController: self)
    }
    
    func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(showAddKeyboard), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideAddKeyboard), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func showAddKeyboard(_ notification:Notification){
        self.view.frame.origin.y = -130
    }
    
    @objc func hideAddKeyboard(){
        self.view.frame.origin.y = 0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier ==  Strings.FinishAddLocation){
            let finishAddLocationViewController = segue.destination as! FinishAddLocationViewController
            guard let sender = sender as? (String, String) else {return}
            finishAddLocationViewController.mediaUrl = sender.1
            finishAddLocationViewController.stringLocation = sender.0
        }
    }
}
