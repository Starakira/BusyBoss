//
//  ChangePasswordViewController.swift
//  BusyBoss
//
//  Created by richard santoso on 03/12/20.
//

import UIKit

enum ChangePasswordError: Error {
    case incompleteForm
    case incorrectPasswordLength
    case oldPasswordMismatch
    case verifyPasswordMismatch
}

class ChangePasswordViewController: UIViewController {
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var oldPassField: UITextField!
    @IBOutlet weak var newPassField: UITextField!
    @IBOutlet weak var confirmPassField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func savePasswordButton(_ sender: Any) {
        do {
            try changePassword()
        } catch ChangePasswordError.incompleteForm {
            Alert.showAlert(view: self, title: "Incomplete Form", message: "Please fill out every field")
        } catch ChangePasswordError.oldPasswordMismatch {
            Alert.showAlert(view: self, title: "Old Password Mismatch", message: "Your old password doesn't match")
        } catch ChangePasswordError.verifyPasswordMismatch{
            Alert.showAlert(view: self, title: "Verify Password Mismatch", message: "Your new password doesn't match verify password")
        } catch ChangePasswordError.incorrectPasswordLength {
            Alert.showAlert(view: self, title: "Incorrect Password Length", message: "Password must be at least 8 characters long")
        } catch {
            Alert.showError(self, error)
        }
    }
    
    func changePassword() throws {
        let oldPassword = oldPassField.text
        let newPassword = newPassField.text
        let verifyPassword = confirmPassField.text
        
        if oldPassword!.isEmpty || newPassword!.isEmpty || verifyPassword!.isEmpty {
            throw ChangePasswordError.incompleteForm
        }
        
        if oldPassword != User.currentUser()?.password {
            throw ChangePasswordError.oldPasswordMismatch
        }
        
        if newPassword != verifyPassword {
            throw ChangePasswordError.verifyPasswordMismatch
        }
        
        if newPassword!.count < 8 {
           throw ChangePasswordError.incorrectPasswordLength
        }
        
        let user = User.currentUser()!
        let pendingAction = Alert.displayPendingAlert(title: "Saving new password...")
        CloudKitManager.shared().userChangePassword(user: user, newPassword: newPassword!) { (error) in
            pendingAction.dismiss(animated: true) {
                if let error = error {
                    Alert.showCloudKitError(self, error)
                }
                else {
                    Alert.showAlert(view: self, title: "Success!", message: "Password has been successfully changed") {
                        self.dismiss(animated: true)
                    }
                }
            }
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
