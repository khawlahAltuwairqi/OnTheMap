//
//  OTMParseConstants.swift
//  OnTheMap
//
//  Created by khawlah on 1/19/19.
//  Copyright © 2019 khawlah. All rights reserved.
//

import Foundation

// MARK: - OTMParseClient (Constants)

extension OTMParseClient {
    
    // MARK: Constants
    struct Constants {
        
        // MARK: API Key
        static let ApiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let ApplicationID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        
        // MARK: URLs
        static let ApiScheme = "https"
        static let ApiHost = "parse.udacity.com"
        static let ApiPath = "/parse/classes"
        
    }
    
    
    // MARK: URL Keys
    struct URLKeys {
        static let UserID = "id"
        static let ObjectId = "id"
        
    }
    
    // MARK: Methods
    struct Methods {
        
        // MARK: Account
        static let StudentLocation = "/StudentLocation"
        static let StudentLocationUpdate = "/StudentLocation/{id}"
    }
    
    // MARK: Parameter Keys
    struct ParameterKeys {
        static let Order = "order"
        static let Limit = "limit"
        static let Where = "where"
        
    }
    
    // MARK: Parameter Values
    struct ParameterValues {
        static let Order = "-updatedAt"
        static let Limit = "100"
        static let Where = "{\"uniqueKey\":\"{id}\"}"
        
        
    }
    
    
}
