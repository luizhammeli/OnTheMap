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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    func setUpViews(){
        loginButton.layer.cornerRadius = 6
        emailTextField.setUpTextFieldPlaceHolder()
        passwordTextField.setUpTextFieldPlaceHolder()
        setUpSignUpButton()
    }
    
    @IBAction func SignUp(_ sender: Any) {
        guard let url = URL(string: Strings.UdacityRegisterURL) else {return}
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func setUpSignUpButton(){
        let atributtedString = NSMutableAttributedString(string: Strings.SignUpButtonBlackText, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        atributtedString.append(NSMutableAttributedString(string: Strings.SignUpButtonBlueText, attributes: [NSAttributedStringKey.foregroundColor: UIColor.udacityBlue]))
        
        signUpButton.setAttributedTitle(atributtedString, for: .normal)
    }
    
    @IBAction func logIn(){        
        self.performSegue(withIdentifier: Strings.goToMainNavigationControllerSegueID, sender: self)
    }
}
