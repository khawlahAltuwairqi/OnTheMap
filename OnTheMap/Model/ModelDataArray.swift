//
//  ModelDataArray.swift
//  OnTheMap
//
//  Created by khawlah on 1/19/19.
//  Copyright © 2019 khawlah. All rights reserved.
//

import Foundation

class ModelDataArray {
    static let shared = ModelDataArray()
    
    var usersDataArray = [Any?]()
    
    private init() { }
}
