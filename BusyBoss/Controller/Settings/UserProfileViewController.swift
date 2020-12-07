//
//  UserProfileViewController.swift
//  BusyBoss
//
//  Created by richard santoso on 26/11/20.
//

import UIKit
import CloudKit

class UserProfileViewController: UIViewController {
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var phoneNoField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    let user = User.currentUser()
    var userRecordID: CKRecord.ID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userRecordID = (user?.recordID)!
        firstNameField.text = user?.firstName
        lastNameField.text = user?.lastName
        phoneNoField.text = user?.phoneNumber
        emailField.text = user?.email
        userImage.image = user?.image
    }
    @IBAction func addPhotoButton(_ sender: Any) {
        let ivc = UIImagePickerController()
        ivc.sourceType = .photoLibrary
        ivc.delegate = self
        ivc.allowsEditing = true
        present(ivc, animated: true)
    }
    @IBAction func logOutButton(_ sender: Any) {
        Alert.showConfirmation(view: self, title: "Sign Out Confirmation", message: "Are you sure you want to sign out?") {
            User.deleteCurrentUser()
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
            
            let loginViewController = storyBoard.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
            self.navigationController?.pushViewController(loginViewController, animated: true)
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.tabBarController?.tabBar.isHidden = true
        }
    }
    
    @IBAction func onSaveButtonTapped(_ sender: UIBarButtonItem) {
        
        let changeUser = User(recordID: userRecordID, firstName: firstNameField.text!, lastName: lastNameField.text!, email: emailField.text!, password: User.currentUser()!.password, phoneNumber: phoneNoField.text!, image: userImage.image!, signature: #imageLiteral(resourceName: "Image Placeholder"))
        let pendingAction = Alert.displayPendingAlert(title: "Saving new changes...")
        self.present(pendingAction, animated: true) {
            CloudKitManager.shared().userEdit(user: changeUser) { (error) in
                pendingAction.dismiss(animated: true) {
                    if let error = error {
                        Alert.showCloudKitError(self, error)
                    }
                    else {
                        Alert.showAlert(view: self, title: "Success!", message: "Profile has been successfully changed") {
                            User.setCurrentUser(user: changeUser)
                            self.dismiss(animated: true)
                        }
                    }
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
extension UserProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            self.userImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

