//
//  RegisterViewController.swift
//  login
//
//  Created by richard santoso on 13/10/20.
//  Copyright © 2020 richard santoso. All rights reserved.
//

import UIKit
import CloudKit

enum RegisterError: Error{
    case incompleteForm
    case invalidEmail
    case incorrectPasswordLength
}

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

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
