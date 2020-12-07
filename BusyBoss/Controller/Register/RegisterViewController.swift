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
    case confirmPasswordMismatch
}

class RegisterViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailAddressTextField.delegate = self
        passwordTextField.delegate = self
        phoneNumberTextField.delegate = self
    }
    
    @IBAction func registerButton(_ sender: Any) {
        do {
            try checkValidUser()
        } catch RegisterError.incompleteForm {
            Alert.showAlert(view: self, title: "Incomplete Form", message: "Please fill out the required fields")
        } catch RegisterError.invalidEmail {
            Alert.showAlert(view: self, title: "Invalid Email", message: "Please use a valid email")
        } catch RegisterError.incorrectPasswordLength {
            Alert.showAlert(view: self, title: "Incorrect Password Length", message: "Password must be 8 characters long")
        } catch RegisterError.confirmPasswordMismatch {
            Alert.showAlert(view: self, title: "Confirm Password Mismatch", message: "Your password doesn't match confirm password")
        } catch {
            Alert.showError(self, error)
        }
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func checkValidUser() throws {
        let firstName = firstNameTextField.text
        let lastName = lastNameTextField.text
        let email = emailAddressTextField.text
        let phoneNumber = phoneNumberTextField.text
        let password = passwordTextField.text
        let confirmPassword = confirmPasswordTextField.text
        
        
        if firstName!.isEmpty || lastName!.isEmpty || email!.isEmpty || password!.isEmpty || confirmPassword!.isEmpty || phoneNumber!.isEmpty {
            throw RegisterError.incompleteForm
        }
        
        if !email!.isValidEmail {
            throw RegisterError.invalidEmail
        }
        
        if password!.count < 8 {
            throw RegisterError.incorrectPasswordLength
        }
        
        if password != confirmPassword {
            throw RegisterError.confirmPasswordMismatch
        }
        
        registerNewUser()
    }
    
    func registerNewUser(){
        let encryptedPassword = EncryptionManager.shared().generateEncryptedString(inputString: passwordTextField.text!)
        
        var user = User(
            firstName: firstNameTextField.text!,
            lastName: lastNameTextField.text!,
            email: emailAddressTextField.text!,
            password: encryptedPassword,
            phoneNumber: phoneNumberTextField.text!, image: #imageLiteral(resourceName: "placeholder image client"), signature: #imageLiteral(resourceName: "Image Placeholder"))
        
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
