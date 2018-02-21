//
//  ActivityIndicator.swift
//  OnTheMap
//
//  Created by iOS Developer on 19/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

class ActivityIndicator {
    
    static var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    static var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    static func showActivityIndicator(viewController: UIViewController){
        viewController.view.addSubview(containerView)
        viewController.view.addSubview(activityIndicator)
        var tabBarHeight:CGFloat = 0.0
        
        guard let navBarHeight = viewController.navigationController?.navigationBar.layer.frame.height else {return}
        tabBarHeight = viewController.getTabBarHeigh()
        containerView.alpha = tabBarHeight == 0 ? 0.35 : 0.75
        
        containerView.topAnchor.constraint(equalTo: viewController.view.topAnchor, constant: navBarHeight).isActive = true
        containerView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: -tabBarHeight).isActive = true
        containerView.leftAnchor.constraint(equalTo: viewController.view.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: viewController.view.rightAnchor).isActive = true

        activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        activityIndicator.startAnimating()
    }
    
    static func removeActivityIndicator(){
        containerView.removeFromSuperview()
        activityIndicator.stopAnimating()
    }
}
