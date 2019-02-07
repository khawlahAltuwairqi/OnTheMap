//
//  ViewController.swift
//  OnTheMap
//
//  Created by khawlah on 1/19/19.
//  Copyright © 2019 khawlah. All rights reserved.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTetfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillDisappear(_ animated: Bool) {
        emailTextfield.text = ""
        passwordTetfield.text = ""
        
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        if emailTextfield.text == "" || passwordTetfield.text == ""{
            Alert.showBasicAlert(on: self, with: "Username and Password cannot be empty !")
            
        }else {
            
            ActivityIndicator.startActivityIndicator(view: self.loginButton)
            
            guard let username = emailTextfield.text else {return}
            guard let password = passwordTetfield.text else {return}
            
            let jsonBody = UdacitySessionBody(udacity: Udacity(username: username, password: password))
            
            loginButton.isEnabled = false
            
            OTMUdacityClient.sharedInstance().authenticateWithViewController(self, jsonBody: jsonBody) { (success,errorString) in
                DispatchQueue.main.async {
                    if success {
                        self.loginButton.isEnabled = true
                        ActivityIndicator.stopActivityIndicator()
                        self.completeLogin()
                    }else {
                        self.loginButton.isEnabled = true
                        ActivityIndicator.stopActivityIndicator()
                        Alert.showBasicAlert(on: self, with: errorString!)
                    }
                }
                
            }
        }
    }
    
    
    private func completeLogin() {
        let controller = storyboard!.instantiateViewController(withIdentifier: "ManagerTabBarController") as! UITabBarController
        present(controller, animated: true, completion: nil)
    }
    
    
    @IBAction func signupTapped(_ sender: Any) {
        let url = URL(string: "https://www.udacity.com/account/auth#!/signup")
        guard let newUrl = url else {return}
        let svc = SFSafariViewController(url: newUrl)
        present(svc, animated: true, completion: nil)
    }
    

}
//
extension LoginViewController: UITextFieldDelegate{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
