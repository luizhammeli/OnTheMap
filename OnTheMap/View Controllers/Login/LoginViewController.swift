//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Luiz Hammerli on 14/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    func setUpViews(){
        loginButton.layer.cornerRadius = 6
        hideActivityIndicator(true)
        emailTextField.setUpTextFieldPlaceHolder()
        passwordTextField.setUpTextFieldPlaceHolder()
        setUpSignUpButton()
    }
    
    @IBAction func SignUp(_ sender: Any) {
        UIApplication.shared.showUrl(stringUrl: Strings.UdacityRegisterURL)
    }
    
    func setUpSignUpButton(){
        let atributtedString = NSMutableAttributedString(string: Strings.SignUpButtonBlackText, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        atributtedString.append(NSMutableAttributedString(string: Strings.SignUpButtonBlueText, attributes: [NSAttributedStringKey.foregroundColor: UIColor.udacityBlue]))
        
        signUpButton.setAttributedTitle(atributtedString, for: .normal)
    }
    
    @IBAction func logIn(){        
        guard let email = emailTextField.text, let password = passwordTextField.text else {return}
        if(!email.isEmpty && !password.isEmpty){
            hideActivityIndicator(false)
            UdacityClient.shared.udacityDefaultLogin(email, password, completionHandler: getUserData)
        }else{
            AlertController.showAlert(title: "", message: Strings.EmptyEmailOrPasswordMessage, viewController: self)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        emailTextField.text?.removeAll()
        passwordTextField.text?.removeAll()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func getUserData(success: Bool, error: String?){
        if(success){
            UdacityClient.shared.getUserData(completionHandler: finishLogin)
        }else{
            DispatchQueue.main.async {
                self.hideActivityIndicator(true)
                AlertController.showAlert(title: "", message: error, viewController: self)
            }            
        }
    }
    
    func finishLogin(success: Bool, error: String?){
        DispatchQueue.main.async {
            self.hideActivityIndicator(true)
            if(success){
                self.performSegue(withIdentifier: Strings.goToMainNavigationControllerSegueID, sender: self)
            }else{
                AlertController.showAlert(title: "", message: error, viewController: self)
            }
        }
    }
    
    func hideActivityIndicator(_ hide: Bool){
        hide ? activityIndicator.stopAnimating() : activityIndicator.startAnimating()
        self.activityIndicator.isHidden = hide
    }
}
