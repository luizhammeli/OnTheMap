//
//  ActivityIndicator.swift
//  OnTheMap
//
//  Created by iOS Developer on 19/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

class ActivityIndicator {
    
    static var loader: UIVisualEffectView = {
        let visualEffect = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        return visualEffect
    }()
    
    static var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    static func showActivityIndicator(viewController: UIViewController){
        viewController.view.addSubview(loader)
        loader.contentView.addSubview(activityIndicator)
        
        loader.topAnchor.constraint(equalTo: viewController.view.topAnchor).isActive = true
        loader.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor).isActive = true
        loader.leftAnchor.constraint(equalTo: viewController.view.leftAnchor).isActive = true
        loader.rightAnchor.constraint(equalTo: viewController.view.rightAnchor).isActive = true
        
        activityIndicator.centerXAnchor.constraint(equalTo: loader.contentView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: loader.contentView.centerYAnchor).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 60).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        activityIndicator.startAnimating()
    }
    
    static func removeActivityIndicator(){
        loader.removeFromSuperview()
        activityIndicator.stopAnimating()
    }
}
