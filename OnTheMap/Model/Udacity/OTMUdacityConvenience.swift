//
//  OTMUdacityConvenience.swift
//  OnTheMap
//
//  Created by khawlah on 1/19/19.
//  Copyright © 2019 khawlah. All rights reserved.
//
import UIKit
import Foundation

// MARK: - OTMParseClient (Convenient Resource Methods)

extension OTMUdacityClient {
    
    
    func authenticateWithViewController<E: Encodable>(_ hostViewController: UIViewController,jsonBody: E, completionHandlerForAuth: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        // chain completion handlers for each request so that they run one after the other
        
        
        
        self.getSession(jsonBody: jsonBody) { (success, sessionID,userID, errorString) in
            
            if success {
                
                // success! we have the sessionID!
                self.sessionID = sessionID
                self.userID = userID
                
                
                self.getPublicDataForUserID(userID: userID) { (success, nickname, errorString) in
                    
                    if success {
                        print("nickname is: \(nickname)")
                        
                        if let nickname = nickname {
                            self.nickname = "\(nickname)"
                        }
                        
                        
                    }
                    
                    completionHandlerForAuth(success, errorString)
                }
            } else {
                completionHandlerForAuth(success, errorString)
            }
        }
        
        
        
        
    }
    
    
    
    
    private func getSession<E: Encodable>( jsonBody:E ,completionHandlerForSession: @escaping (_ success: Bool , _ sessionID: String?,_ userID: String?, _ errorString: String?) -> Void) {
        
        /* 1. Specify parameters, the API method, and the HTTP body (if POST) */
        
        
        /* 2. Make the request */
        
        _ = taskForPOSTMethod(Methods.AuthenticationSession, decode: UdacitySessionResponse.self, jsonBody: jsonBody) { (result, error) in
            
            if let error = error {
                completionHandlerForSession(false ,nil ,nil,"\(error.localizedDescription) ")
            }else {
                let newResult = result as! UdacitySessionResponse
                if let sessionID = newResult.session.id , let userID = newResult.account.key  {
                    completionHandlerForSession(true ,sessionID,userID ,nil)
                    
                }else {
                    completionHandlerForSession(false ,nil ,nil," \(error!.localizedDescription)")
                    
                }
                
                
            }
        }
        
    }
    
    func deleteSession(_ completionHandlerForSession: @escaping (_ success: Bool , _ sessionID: String?, _ errorString: String?) -> Void) {
        
        /* 1. Specify parameters, the API method, and the HTTP body (if POST) */
        
        
        /* 2. Make the request */
        
        
        
        _ = taskForDeleteMethod(Methods.AuthenticationSession, decode: SessionDelete.self, completionHandlerForDelete: { (result, error) in
            
            if let error = error {
                completionHandlerForSession(false ,nil,"\(error.localizedDescription) ")
            }else {
                let newResult = result as! SessionDelete
                if let sessionID = newResult.session.id  {
                    completionHandlerForSession(true ,sessionID ,nil)
                    
                }else {
                    completionHandlerForSession(false ,nil ," \(error!.localizedDescription)")
                    
                }
                
                
            }
        }
        )
    }
    
    private func getPublicDataForUserID(userID: String?,_ completionHandlerForUserID: @escaping (_ success: Bool,_ nickname: String?, _ errorString: String?) -> Void) {
        
        
        
        
        
        var mutableMethod: String = Methods.AuthenticationGetPublicDataForUserID
        mutableMethod = substituteKeyInMethod(mutableMethod, key: OTMUdacityClient.URLKeys.UserID, value: String(OTMUdacityClient.sharedInstance().userID!))!
        
        
        
        /* 2. Make the request */
        
        _ = taskForGETMethod(mutableMethod , decode: UdacityUserData.self) { (result, error) in
            
            
            if let error = error {
                
                completionHandlerForUserID(false ,nil ,"\(error.localizedDescription)")
            }else {
                let newResult = result as! UdacityUserData
                if let nickname = newResult.nickname  {
                    
                    completionHandlerForUserID(true ,nickname,nil)
                    
                }else {
                    completionHandlerForUserID(false ,nil,"\(String(describing: error?.localizedDescription))")
                    
                }
                
                
            }
        }
        
    }
    
}
