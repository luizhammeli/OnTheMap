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
        
        self.font = UIFont.systemFont(ofSize: 17)
        
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17)])
    }
}

extension UIApplication{
    func showUrl(stringUrl: String){
        guard let url = URL(string: stringUrl) else {return}
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

extension URL{
    static func isValid(_ stringURL: String) -> Bool {
        let regEx = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        let urlPredicate = NSPredicate(format:"SELF MATCHES %@", regEx)
        let result = urlPredicate.evaluate(with: stringURL)
        return result
    }
}
