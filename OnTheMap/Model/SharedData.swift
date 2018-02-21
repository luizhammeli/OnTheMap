//
//  SharedData.swift
//  OnTheMap
//
//  Created by Luiz Hammerli on 21/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import Foundation

class SharedData: NSObject {
    static let shared = SharedData()
    var studentsInformations = [StudentInformation]()
}
