
//  OTMParseClient.swift
//  OnTheMap
//
//  Created by khawlah on 1/19/19.
//  Copyright © 2019 khawlah. All rights reserved.
//

import Foundation

// MARK: - OTMParseClient: NSObject

class OTMParseClient : NSObject {
    
    // MARK: Properties
    
    // shared session
    var session = URLSession.shared
    var objectId : String? = nil
    
    
    
    // MARK: Initializers
    
    override init() {
        super.init()
    }
    
    // MARK: GET
    
    func taskForGETMethod<D: Decodable>(_ method: String, parameters: [String:AnyObject],decode:D.Type, completionHandlerForGET: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        /* 1. Set the parameters */
        var parametersWithApiKey = parameters
        /* 2/3. Build the URL, Configure the request */
        
        
        var request = NSMutableURLRequest(url: tmdbURLFromParameters(parametersWithApiKey, withPathExtension: method))
        
        
        
        request.addValue(OTMParseClient.Constants.ApplicationID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(OTMParseClient.Constants.ApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        
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
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            self.convertDataWithCompletionHandler(data, decode:decode,completionHandlerForConvertData: completionHandlerForGET)
            
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
        let request = NSMutableURLRequest(url:tmdbURLFromWithoutParameters(withPathExtension: method))
        
        
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.addValue(OTMParseClient.Constants.ApplicationID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(OTMParseClient.Constants.ApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        
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
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            self.convertDataWithCompletionHandler(data, decode: decode!, completionHandlerForConvertData: completionHandlerForPOST)
            
        }
        /* 7. Start the request */
        task.resume()
        
        return task
    }
    
    //Mark Put
    
    func taskForPUTMethod<E: Encodable,D:Decodable>(_ method: String,decode:D.Type?, jsonBody: E, completionHandlerForPUT: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        
        func sendError(_ error: String) {
            print(error)
            let userInfo = [NSLocalizedDescriptionKey : error]
            completionHandlerForPUT(nil, NSError(domain: "taskForPUTMethod", code: 1, userInfo: userInfo))
        }
        
        
        /* 2/3. Build the URL, Configure the request */
        let request = NSMutableURLRequest(url:tmdbURLFromWithoutParameters(withPathExtension: method))
        
        
        
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.addValue(OTMParseClient.Constants.ApplicationID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(OTMParseClient.Constants.ApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        
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
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            self.convertDataWithCompletionHandler(data, decode: decode!, completionHandlerForConvertData: completionHandlerForPUT)
            
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
    
    // create a URL from parameters
    private func tmdbURLFromParameters(_ parameters: [String:AnyObject], withPathExtension: String? = nil) -> URL {
        
        var components = URLComponents()
        components.scheme = OTMParseClient.Constants.ApiScheme
        components.host = OTMParseClient.Constants.ApiHost
        components.path = OTMParseClient.Constants.ApiPath + (withPathExtension ?? "")
        
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
            
        }
        
        //for known reason the sign ":" won't convert to escaping value "%3A"
        //that mean instead of uniqueKey%22%3A it will print it uniqueKey%22:
        //so this is working around to fix this issue !
        
        let url:URL?
        let urlString = components.url!.absoluteString
        if urlString.contains("%22:"){
            
            url = URL(string: "\(urlString.replacingOccurrences(of: "%22:", with: "%22%3A"))")
        }else {
            url = components.url!
        }
        
        
        
        return url!
    }
    
    // create a URL from without parameters
    private func tmdbURLFromWithoutParameters(withPathExtension: String? = nil) -> URL {
        
        var components = URLComponents()
        components.scheme = OTMParseClient.Constants.ApiScheme
        components.host = OTMParseClient.Constants.ApiHost
        components.path = OTMParseClient.Constants.ApiPath + (withPathExtension ?? "")
        
        print(components.url!)
        
        return components.url!
    }
    
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> OTMParseClient {
        struct Singleton {
            static var sharedInstance = OTMParseClient()
        }
        return Singleton.sharedInstance
    }
}
