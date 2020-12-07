//  Created by richard santoso on 13/10/20.
//  Copyright © 2020 richard santoso. All rights reserved.
//

import UIKit
import CloudKit
import AuthenticationServices

enum LoginError: Error{
    case incompleteForm
    case invalidEmail
}

class LoginViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var emailLogin: UITextField!
    @IBOutlet weak var passwordLogin: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailLogin.delegate = self
        passwordLogin.delegate = self
        
        //Check if email address and password exist in userdefaults
        let emailAddress = UserDefaults.standard.string(forKey: User.keyEmail)
        let password = UserDefaults.standard.string(forKey: User.keyPassword)
        
        if let email = emailAddress, let password = password {
            
            do{
                try authenticate(emailText: email, passwordText: password)
            } catch {
                Alert.showError(self, error)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func loginButton(_ sender: Any) {
        let encryptedPassword = EncryptionManager.shared().generateEncryptedString(inputString: passwordLogin.text ?? "No Password")
        
        do{
            try  authenticate(emailText: emailLogin.text ?? "", passwordText: encryptedPassword)
        } catch LoginError.incompleteForm {
            Alert.showAlert(view: self, title: "Incomplete Form", message: "Please fill out both email and password fields")
        } catch LoginError.invalidEmail {
            Alert.showAlert(view: self, title: "Invalid Email", message: "Please enter the correct email format")
        } catch {
            Alert.showError(self, error)
        }
    }
    
    func segueToMain(){
        self.performSegue(withIdentifier: "MainIdentifier", sender: nil)
    }
    
    func authenticate(emailText: String, passwordText: String) throws{
        let email = emailText
        let password = passwordText
        
        if email.isEmpty || password.isEmpty {
            throw LoginError.incompleteForm
        }
        
        if !email.isValidEmail {
            throw LoginError.invalidEmail
        }
        
        fetchUserCridentialsFromCloudKit(emailText: email, passwordText: password)
    }
    
    func fetchUserCridentialsFromCloudKit(emailText: String, passwordText: String) {
        let pendingAction = Alert.displayPendingAlert(title: "Logging You In...")
        self.present(pendingAction, animated: true) {
            CloudKitManager.shared().authenticateUser(emailAddress: emailText, password: passwordText) { currentUser, error in
                if let error = error {
                    pendingAction.dismiss(animated: true) {
                        Alert.showRetryCloudkitError(view: self, title: "Error Logging In", error: error) {
                            self.fetchUserCridentialsFromCloudKit(emailText: emailText, passwordText: passwordText)
                        }
                    }
                    return
                }
                else if currentUser == nil {
                    pendingAction.dismiss(animated: true) {
                        Alert.showAlert(view: self, title: "Error", message: "Invalid Cridentials!")
                    }
                }
                else {
                    let loggedUser = User(record: currentUser!)
                    User.setCurrentUser(user: loggedUser)
                    pendingAction.dismiss(animated: true) {
                        self.segueToMain()
                    }
                }
            }
        }
    }
}

//extension LoginViewController: ASAuthorizationControllerDelegate{
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//
//        switch authorization.credential{
//
//        case let credentials as ASAuthorizationAppleIDCredential:
//            let user = User(credentials: credentials)
//            performSegue(withIdentifier: "EntryIdentifier", sender: user)
//
//        default: break
//        }
//
//    }
//
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
//    }
//}

//extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
//    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
//
//        return view.window!
//    }
//}
