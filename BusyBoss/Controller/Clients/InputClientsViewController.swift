//
//  InputClientsViewController.swift
//  Busy Boss
//
//  Created by richard santoso on 27/10/20.
//

import UIKit

class InputClientsViewController: UIViewController {
    @IBOutlet weak var addClientsImage: UIImageView!
    var client : clientsStruct!
    @IBOutlet weak var clientFirstName: UITextField!
    @IBOutlet weak var clientLastName: UITextField!
    @IBOutlet weak var clientCompanyName: UITextField!
    @IBOutlet weak var clientAddress: UITextField!
    @IBOutlet weak var clientEmailAddress: UITextField!
    @IBOutlet weak var clientPhoneNo: UITextField!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    // MARK: - Image Manager
    
    @IBAction func addImageClient(_ sender: Any) {
        let ivc = UIImagePickerController()
        ivc.sourceType = .photoLibrary
        ivc.delegate = self
        ivc.allowsEditing = true
        present(ivc, animated: true)
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let button = sender as? UIBarButtonItem, button === doneButton else {
            
            return
        }
        
         let newClient = clientsStruct(clientsFirstName: clientFirstName.text!, clientsLastName: clientLastName.text!, clientsCompanyName: clientCompanyName.text!, clientsCompanyAddress: clientAddress.text!, clientsPhoneNo: clientPhoneNo.text!, clientsImage: addClientsImage.image!, clientsEmailAddress: clientEmailAddress.text!)
               
        self.client = newClient
        
    }
    

}
extension InputClientsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            self.addClientsImage.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
       }
}
