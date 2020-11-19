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
    }
    
    @IBAction func registerButton(_ sender: Any) {
        var user = User(recordID: CKRecord.ID(),
            firstName: firstNameTextField.text!,
                        lastName: lastNameTextField.text!,
                        email: emailAddressTextField.text!,
                        password: phoneNumberTextField.text!,
                        phoneNumber: passwordTextField.text!)
        
        let pendingAction = Alert.displayPendingAlert(title: "Registering New User...")
        self.present(pendingAction, animated: true)
        
        CloudKitManager.shared().userCreate(user: user){ recordID, error  in
            pendingAction.dismiss(animated: true) {
                if let error = error {
                    Alert.showError(self, error )
                }
                else {
                    user.recordID = recordID
                    self.dismiss(animated: true)
                }
            }
            
        }
    }
}
