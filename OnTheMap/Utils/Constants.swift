//
//  Constants.swift
//  OnTheMap
//
//  Created by Luiz Hammerli on 14/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import Foundation

struct Strings{
    static let SignUpButtonBlackText = "Don't have an account?"
    static let SignUpButtonBlueText = " Sign Up"
    static let UdacityRegisterURL = "https://auth.udacity.com/sign-up?locale=pt-br&next=https%3A%2F%2Fbr.udacity.com"
    
    static let invalidLink = "Invalid Link"
    static let OK = "Ok"
    static let EmptyEmailOrPasswordMessage = "Empty Email or Password"
    static let LocationNotFoundMessage = "Must Enter a Location"
    static let LocationNotFoundTitleMessage = "Location Not Found"
    static let LoginErrorDefaultMessage = "Login Error"
    static let InvalidURLMessage = "Invalid URL"
    static let ErrorGetUserData = "Error to get user data"
    static let GeoCodeError = "Could not Geocode the location"
    
    //Segue ID
    static let goToMainNavigationControllerSegueID = "goToMainNavigationController"
    static let goToAddLocationSegueID = "goToAddLocation"
    static let FinishAddLocation = "finishAddLocation"
    
    //Cell ID
    static let LocationsTableViewControllerCellID = "cellID"
    
    //Alert Button
    
    static let Dismiss = "Dismiss"
    static let Overwrite = "Overwrite"
    static let Cancel = "Cancel"
    
    static let locationUpdateMessage = "User {user} Has Alredy Posted a Student Location. Would You Like To Overwrite Their Location?"
}
