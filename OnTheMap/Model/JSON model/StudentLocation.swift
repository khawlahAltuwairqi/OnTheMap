//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by khawlah on 1/19/19.
//  Copyright © 2019 khawlah. All rights reserved.
//

import Foundation

struct StudentLocations : Codable {
    let results : [Results]?
}

struct Results : Codable {
    let createdAt:String?
    let firstName:String?
    let lastName:String?
    let latitude:Double?
    let longitude:Double?
    let mapString:String?
    let mediaURL:String?
    let uniqueKey:String?
    let updatedAt:String?
    let objectId:String?
    
}



struct StudentLocationsBody : Codable {
    let uniqueKey:String?
    let firstName:String?
    let lastName:String?
    let mapString:String?
    let mediaURL:String?
    let latitude:Double?
    let longitude:Double?
}

//Post StudentLocations Response
struct StudentLocationsResponse : Codable {
    let createdAt : String?
    let objectId : String?
    
}

struct StudentLocationsUpdateResponse : Codable {
    let createdAt : String?
}
