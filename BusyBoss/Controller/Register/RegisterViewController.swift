//
//  RegisterViewController.swift
//  login
//
//  Created by richard santoso on 13/10/20.
//  Copyright © 2020 richard santoso. All rights reserved.
//

import UIKit
import CloudKit
class RegisterViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailAddressTextField.delegate = self
        passwordTextField.delegate = self
        phoneNumberTextField.delegate = self
    }
    
    @IBAction func registerButton(_ sender: Any) {
        var user = User(
            firstName: firstNameTextField.text!,
            lastName: lastNameTextField.text!,
            email: emailAddressTextField.text!,
            password: passwordTextField.text!,
            phoneNumber: phoneNumberTextField.text!, image: #imageLiteral(resourceName: "BusyBoss_Logo"))
        
        if firstNameTextField.isEmpty {
            Alert.showAlert(view: self, title: "First Name Empty", message: "Please fill out your first name!")
        } else if lastNameTextField.isEmpty {
            Alert.showAlert(view: self, title: "Last Name Empty", message: "Please fill out your last name!")
        } else if emailAddressTextField.isEmpty {
            Alert.showAlert(view: self, title: "Email Address Empty", message: "Please fill out your email address!")
        } else if phoneNumberTextField.isEmpty {
            Alert.showAlert(view: self, title: "Phone Number Empty", message: "Please fill out your phone number!")
        } else if passwordTextField.isEmpty {
            Alert.showAlert(view: self, title: "Password Empty", message: "Please fill out your password!")
        } else {
            let pendingAction = Alert.displayPendingAlert(title: "Registering New User...")
            
            self.present(pendingAction, animated: true) {
                CloudKitManager.shared().userCreate(user: user){ recordID, error  in
                    pendingAction.dismiss(animated: true) {
            
                        if let error = error {
                            Alert.showCloudKitError(self, error)
                        
                        }
                        else {
                            user.recordID = recordID
                            self.dismiss(animated: true)
                        }
                    }
                }
            }
        }
    }
    
    func ifTextFieldEmpty(textField: UITextField) -> Bool{
        if !textField.hasText {
            textField.text = "Please fill out this \(textField))"
            return true
        } else {
            return false
        }
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}

extension UITextField {

    var isEmpty: Bool {
        if let text = UITextField().text, !text.isEmpty {
             return false
        }
        return true
    }
}
