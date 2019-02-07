//
//  OTMUdacityClient.swift
//  OnTheMap
//
//  Created by khawlah on 1/19/19.
//  Copyright © 2019 khawlah. All rights reserved.
//

import Foundation

// MARK: - OTMUdacityClient: NSObject

class OTMUdacityClient : NSObject {
    
    // MARK: Properties
    
    // shared session
    var session = URLSession.shared
    
    
    // authentication state
    var sessionID : String? = nil
    var userID : String? = nil
    var nickname : String? = nil
    
    
    // MARK: Initializers
    
    override init() {
        super.init()
    }
    
    // MARK: GET
    
    func taskForGETMethod<D: Decodable>(_ method: String,decode:D.Type, completionHandlerForGET: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        /* 1. Set the parameters */
        
        /* 2/3. Build the URL, Configure the request */
        let request = NSMutableURLRequest(url: OTMUdacityClient.tmdbURLFromWithoutParameters( withPathExtension: method))
        
        /* 4. Make the request */
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGET(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("\(error!.localizedDescription)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your Password or Email uncorrect!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            
            let range = 5..<data.count
            let newData = data.subdata(in: range) /* subset response data! */
            
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            self.convertDataWithCompletionHandler(newData, decode:decode,completionHandlerForConvertData: completionHandlerForGET)
            
        }
        /* 7. Start the request */
        task.resume()
        
        return task
        
        
    }
    
    // MARK: POST
    
    func taskForPOSTMethod<E: Encodable,D:Decodable>(_ method: String,decode:D.Type?, jsonBody: E, completionHandlerForPOST: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        
        func sendError(_ error: String) {
            print(error)
            let userInfo = [NSLocalizedDescriptionKey : error]
            completionHandlerForPOST(nil, NSError(domain: "taskForPOSTMethod", code: 1, userInfo: userInfo))
        }
        
        /* 2/3. Build the URL, Configure the request */
        let request = NSMutableURLRequest(url: OTMUdacityClient.tmdbURLFromWithoutParameters(withPathExtension: method))
        
        
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do{
            let JsonBody = try JSONEncoder().encode(jsonBody)
            request.httpBody = JsonBody
            
            
        } catch{
            sendError("There was an error with your request JSON Body: \(error)")
            
        }
        
        
        
        /* 4. Make the request */
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("\(error!.localizedDescription)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your Password or Email uncorrect!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            //Remove 5 checter from Response
            let range = 5..<data.count
            let newData = data.subdata(in: range) /* subset response data! */
            
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            self.convertDataWithCompletionHandler(newData, decode: decode!, completionHandlerForConvertData: completionHandlerForPOST)
            
        }
        /* 7. Start the request */
        task.resume()
        
        return task
    }
    
    
    //MARK : Delete
    func taskForDeleteMethod<D:Decodable>(_ method: String,decode:D.Type?, completionHandlerForDelete: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        
        func sendError(_ error: String) {
            print(error)
            let userInfo = [NSLocalizedDescriptionKey : error]
            completionHandlerForDelete(nil, NSError(domain: "taskForPOSTMethod", code: 1, userInfo: userInfo))
        }
        
        /* 2/3. Build the URL, Configure the request */
        let request = NSMutableURLRequest(url: OTMUdacityClient.tmdbURLFromWithoutParameters(withPathExtension: method))
        
        
        
        request.httpMethod = "Delete"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        
        
        
        /* 4. Make the request */
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("\(error!.localizedDescription)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your Password or Email uncorrect!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            //Remove 5 checter from Response
            let range = 5..<data.count
            let newData = data.subdata(in: range) /* subset response data! */
            
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            self.convertDataWithCompletionHandler(newData, decode: decode!, completionHandlerForConvertData: completionHandlerForDelete)
            
        }
        /* 7. Start the request */
        task.resume()
        
        return task
    }
    
    // MARK: Helpers
    
    // substitute the key for the value that is contained within the method name
    func substituteKeyInMethod(_ method: String, key: String, value: String) -> String? {
        if method.range(of: "{\(key)}") != nil {
            return method.replacingOccurrences(of: "{\(key)}", with: value)
        } else {
            return nil
        }
    }
    
    
    private func convertDataWithCompletionHandler<D: Decodable>(_ data: Data,decode:D.Type, completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError?) -> Void) {
        
        
        do {
            let obj = try JSONDecoder().decode(decode, from: data)
            completionHandlerForConvertData(obj as AnyObject, nil)
            
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
    }
    
    
    
    
    // create a URL from without parameters
    class func tmdbURLFromWithoutParameters( withPathExtension: String? = nil) -> URL {
        
        var components = URLComponents()
        components.scheme = OTMUdacityClient.Constants.ApiScheme
        components.host = OTMUdacityClient.Constants.ApiHost
        components.path = OTMUdacityClient.Constants.ApiPath + (withPathExtension ?? "")
        
        
        print("Udacity API: \(components.url!)")
        return components.url!
    }
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> OTMUdacityClient {
        struct Singleton {
            static var sharedInstance = OTMUdacityClient()
        }
        return Singleton.sharedInstance
    }
}
