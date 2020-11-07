//
//  InputClientsViewController.swift
//  Busy Boss
//
//  Created by richard santoso on 27/10/20.
//

import UIKit

class InputClientsViewController: UIViewController {
    @IBOutlet weak var addClientsImage: UIImageView!
    @IBOutlet weak var clientFirstName: UITextField!
    @IBOutlet weak var clientLastName: UITextField!
    @IBOutlet weak var clientCompanyName: UITextField!
    @IBOutlet weak var clientAddress: UITextField!
    @IBOutlet weak var clientEmailAddress: UITextField!
    @IBOutlet weak var clientPhoneNo: UITextField!
    
    var client: Client?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
   
    // MARK: - Action
    
    @IBAction func doneButton(_ sender: Any) {
        let client = Client(image: addClientsImage.image!,
                            firstName: clientFirstName.text!,
                            lastName: clientLastName.text!,
                            emailAddress: clientEmailAddress.text!,
                            phoneNumber: clientPhoneNo.text!,
                            companyName: clientCompanyName.text!,
                            companyAddress: clientAddress.text!)
        
        
        CloudKitManager.shared().createClient(client: client) { (recordID, error) in
            if let error = error {
                Alert.showError(self, error)
            }
            else if recordID != nil {
                Alert.showAlert(view: self, title: "ID not created!", message: "Database failed to create ID for new client!")
            }
            else {
                self.client = client
                self.client?.recordID = recordID
                
                /*
                let vc = self.storyboard?.instantiateViewController(identifier: "clients") as! ClientsViewController
                self.navigationController?.pushViewController(vc, animated: true)
                 */
                self.dismiss(animated: true)
            }
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    @IBAction func addImageClient(_ sender: Any) {
        let ivc = UIImagePickerController()
        ivc.sourceType = .photoLibrary
        ivc.delegate = self
        ivc.allowsEditing = true
        present(ivc, animated: true)
    }

}
extension InputClientsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerIsEdited")] as? UIImage{
            self.addClientsImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
       }
}
