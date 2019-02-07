//
//  Alert.swift
//  OnTheMap
//
//  Created by khawlah on 1/19/19.
//  Copyright © 2019 khawlah. All rights reserved.
//
import UIKit
import Foundation

struct Alert {
    
    static func showBasicAlert(on vc: UIViewController, with message: String) {
        let alert = UIAlertController(title: "Alert!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async { vc.present(alert, animated: true) }
    }
    
    static func showAlertWithTwoButtons(on vc: UIViewController, with message: String , completionHandlerForAlert: @escaping ( _ action: UIAlertAction?) -> Void) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Overwrite", style: .default, handler: completionHandlerForAlert))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        DispatchQueue.main.async { vc.present(alert, animated: true) }
    }
    
    
    
    
}
