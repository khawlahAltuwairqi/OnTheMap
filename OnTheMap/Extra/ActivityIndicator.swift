//
//  ActivityIndicator.swift
//  OnTheMap
//
//  Created by khawlah on 1/19/19.
//  Copyright © 2019 khawlah. All rights reserved.
//
import UIKit
import Foundation


struct ActivityIndicator {
    
    private static var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    static func startActivityIndicator(view:UIView){
        
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    
    static func stopActivityIndicator(){
        activityIndicator.stopAnimating()
    }
    
}
