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
    @IBOutlet weak var phoneNoTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerButton(_ sender: Any) {
        let firstName = firstNameTextField.text
        let lastName = lastNameTextField.text
        let emailAddress = emailAddressTextField.text
        let password = passwordTextField.text
        let phoneNo = phoneNoTextField.text
        
        let pendingAction = Alert.displayPendingAlert(title: "Registering New User...")
        self.present(pendingAction, animated: true)
        
        CloudKitManager.shared().addUser(emailAddress: emailAddress!, password: password!, firstName: firstName!, lastName: lastName!, phoneNo: phoneNo!){ error in
            pendingAction.dismiss(animated: true) {
                if let error = error {
                    Alert.showError(self, error)
                }
                else {
                    self.dismiss(animated: true)
                }
            }
            
        }
    }
}
