//  Created by richard santoso on 13/10/20.
//  Copyright © 2020 richard santoso. All rights reserved.
//

import UIKit
import CloudKit
import AuthenticationServices
class LoginViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var emailLogin: UITextField!
    @IBOutlet weak var passwordLogin: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Check if email address and password exist in userdefaults
        let emailAddress = UserDefaults.standard.string(forKey: User.keyEmail)
        let password = UserDefaults.standard.string(forKey: User.keyPassword)
        
        if let email = emailAddress, let password = password {
            authenticate(emailAddress: email, password: password)
        }
        emailLogin.delegate = self
        passwordLogin.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func loginButton(_ sender: Any) {
        authenticate(emailAddress: emailLogin.text ?? "", password: passwordLogin.text ?? "")
    }
    
//    @IBAction func signInWithAppleButton(_ sender: Any) {
//        let provider = ASAuthorizationAppleIDProvider()
//        let request = provider.createRequest()
//        request.requestedScopes = [.fullName, .email]
//        
//        let controller = ASAuthorizationController(authorizationRequests: [request])
//        
//        controller.delegate = self
//        controller.presentationContextProvider = self
//        
//        controller.performRequests()
//    }
    
    
    func segueToMain(){
        self.performSegue(withIdentifier: "MainIdentifier", sender: nil)
    }
    
    func authenticate(emailAddress: String, password: String){
        CloudKitManager.shared().authenticateUser(emailAddress: emailAddress, password: password) { currentUser, error in
            
            if let error = error {
                Alert.showError(self, error)
                return
            }
            else if currentUser == nil {
                Alert.showAlert(view: self, title: "Error", message: "Invalid Cridentials!")
            }
            else {
                UserDefaults.standard.setValue(currentUser![User.keyEmail], forKey: User.keyEmail)
                UserDefaults.standard.setValue(currentUser![User.keyPassword], forKey: User.keyPassword)
                self.segueToMain()
                
                let loggedUser = User(record: currentUser!)
                User.setCurrentUser(user: loggedUser)
            }
        }
    }
    
    func logout() {
        
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
