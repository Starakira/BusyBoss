//
//  InputClientsViewController.swift
//  Busy Boss
//
//  Created by richard santoso on 27/10/20.
//

import UIKit

enum ClientError: Error {
    case incompleteForm
}

class InputClientViewController: UIViewController {
    @IBOutlet weak var addClientsImage: UIImageView!
    @IBOutlet weak var clientFirstName: UITextField!
    @IBOutlet weak var clientLastName: UITextField!
    @IBOutlet weak var clientCompanyName: UITextField!
    @IBOutlet weak var clientAddress: UITextField!
    @IBOutlet weak var clientEmailAddress: UITextField!
    @IBOutlet weak var clientPhoneNumber: UITextField!
    
    var client: Client?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addClientsImage.layer.borderWidth = 1
        addClientsImage.layer.masksToBounds = false
        addClientsImage.layer.borderColor = UIColor.clear.cgColor
        addClientsImage.layer.cornerRadius = addClientsImage.frame.height/2
        addClientsImage.clipsToBounds = true
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if self.client == nil {
            self.client = Client(image: addClientsImage.image ?? #imageLiteral(resourceName: "placeholder image client"),
                                firstName: clientFirstName.text!,
                                lastName: clientLastName.text!,
                                emailAddress: clientEmailAddress.text!,
                                phoneNumber: clientPhoneNumber.text!,
                                companyName: clientCompanyName.text!,
                                companyAddress: clientAddress.text!)
        }
        
        print("Creating client...")
    }
    
   
    // MARK: - Action
    
    @IBAction func doneButton(_ sender: Any) {
        do {
            try checkValidClient()
        } catch ClientError.incompleteForm {
            Alert.showAlert(view: self, title: "Incomplete Form", message: "Please fill out the required fields")
        }
        catch {
            Alert.showError(self, error)
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
    
    func checkValidClient() throws {
        let firstName = clientFirstName.text
        let lastName = clientLastName.text
        let phoneNumber = clientPhoneNumber.text
        
        if firstName!.isEmpty || lastName!.isEmpty || phoneNumber!.isEmpty {
            throw ClientError.incompleteForm
        }
        
        createClient()
    }
    
    func createClient(){
        let client = Client(image: addClientsImage.image ?? #imageLiteral(resourceName: "placeholder image client"),
                            firstName: clientFirstName.text!,
                            lastName: clientLastName.text!,
                            emailAddress: clientEmailAddress.text!,
                            phoneNumber: clientPhoneNumber.text!,
                            companyName: clientCompanyName.text!,
                            companyAddress: clientAddress.text!)
        
        self.client = client
    }
}

extension InputClientViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension InputClientViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
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
