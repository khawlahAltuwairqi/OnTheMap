//
//  OTMUdacityConstants.swift
//  OnTheMap
//
//  Created by khawlah on 1/19/19.
//  Copyright © 2019 khawlah. All rights reserved.
//

import Foundation

// MARK: - OTMUdacityConstants (Constants)

extension OTMUdacityClient {
    
    // MARK: Constants
    struct Constants {
        
        
        // MARK: URLs
        static let ApiScheme = "https"
        static let ApiHost = "onthemap-api.udacity.com"
        static let ApiPath = "/v1"
        
    }
    
    // MARK: URL Keys
    struct URLKeys {
        static let UserID = "id"
    }
    
    // MARK: Methods
    struct Methods {
        
        
        // MARK: Authentication
        static let AuthenticationSession = "/session"
        static let AuthenticationGetPublicDataForUserID = "/users/{id}"
        
        
        
    }
    
    
    
    
}
