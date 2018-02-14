//
//  Extensions.swift
//  OnTheMap
//
//  Created by Luiz Hammerli on 14/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

extension UIColor{
    
    static let udacityBlue = UIColor(red: 2/255, green: 179/255, blue: 228/255, alpha: 1)
}

extension UITextField{
    func setUpTextFieldPlaceHolder(){
        guard let placeholder = self.placeholder else{return}
        
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)])
    }
}
