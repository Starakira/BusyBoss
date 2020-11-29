//
//  EditClientViewController.swift
//  BusyBoss
//
//  Created by Muhammad Bangun Agung on 19/11/20.
//

import UIKit

class EditClientViewController: UIViewController {

    @IBOutlet weak var addClientsImage: UIImageView!
    @IBOutlet weak var clientFirstName: UITextField!
    @IBOutlet weak var clientLastName: UITextField!
    @IBOutlet weak var clientCompanyName: UITextField!
    @IBOutlet weak var clientAddress: UITextField!
    @IBOutlet weak var clientEmailAddress: UITextField!
    @IBOutlet weak var clientPhoneNo: UITextField!
    
    var client: Client?
    
    var editClientDelegate: ClientsConform?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //If client exist, then fill the fields
        if let client = client {
            addClientsImage.image = client.image
            clientFirstName.text = client.firstName
            clientLastName.text = client.lastName
            clientCompanyName.text = client.companyName
            clientAddress.text = client.companyAddress
            clientEmailAddress.text = client.emailAddress
            clientPhoneNo.text = client.phoneNumber
        }
    }
    
    @IBAction func doneButtonAction(_ sender: Any) {
        let clientRecordID = client?.recordID
        
        print("Client = \(String(describing: self.client))")
        
        self.client?.image = self.addClientsImage.image
        self.client?.firstName = self.clientFirstName.text ?? "No First Name"
        self.client?.lastName =  self.clientLastName.text ?? "No Last Name"
        self.client?.companyName = self.clientCompanyName.text ?? "No Company Name"
        self.client?.companyAddress = self.clientAddress.text ?? "No Company Address"
        self.client?.emailAddress = self.clientEmailAddress.text ?? "No Email"
        self.client?.phoneNumber = self.clientPhoneNo.text ?? "No Phone Number"
        
        let pendingAction = Alert.displayPendingAlert(title: "Saving Client...")
        
        self.present(pendingAction, animated: true){
                CloudKitManager.shared().clientEdit(client: self.client!) {
                (record, error) in
                
                if let error = error{
                    pendingAction.dismiss(animated: true) {
                        Alert.showCloudKitError(self, error)
                    }
                } else {
                    print("Client = \(String(describing: self.client))")
                    
                    self.client?.recordID = record
                    
                    pendingAction.dismiss(animated: true){
                        self.client?.recordID = clientRecordID
                        self.editClientDelegate?.clientListPassData(client: self.client!)
                        self.dismiss(animated: true)
                    }
                }
            }
        }
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func changePhotoAction(_ sender: Any) {
        let ivc = UIImagePickerController()
        ivc.sourceType = .photoLibrary
        ivc.delegate = self
        ivc.allowsEditing = true
        present(ivc, animated: true)
    }
}

extension EditClientViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension EditClientViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            self.addClientsImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
       }
}
