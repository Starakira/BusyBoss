//
//  InputClientsViewController.swift
//  Busy Boss
//
//  Created by richard santoso on 27/10/20.
//

import UIKit

class InputClientsViewController: UIViewController {
    @IBOutlet weak var addClientsImage: UIImageView!
    var clients : [clientsStruct]!
    @IBOutlet weak var clientFirstName: UITextField!
    @IBOutlet weak var clientLastName: UITextField!
    @IBOutlet weak var clientCompanyName: UITextField!
    @IBOutlet weak var clientAddress: UITextField!
    @IBOutlet weak var clientEmailAddress: UITextField!
    @IBOutlet weak var clientPhoneNo: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let CSManager : clientsStructManager = clientsStructManager()
        clients = CSManager.clients
        // Do any additional setup after loading the view.
    }
    @IBAction func doneButton(_ sender: Any) {
        clients.append(clientsStruct(clientsFirstName: clientFirstName.text!, clientsLastName: clientLastName.text!, clientsCompanyName: clientCompanyName.text!, clientsCompanyAddress: clientAddress.text!, clientsPhoneNo: clientPhoneNo.text!, clientsImage: addClientsImage.image!, clientsEmailAddress: clientEmailAddress.text!))
            let vc = storyboard?.instantiateViewController(identifier: "clients") as! ClientsViewController
            self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func addImageClient(_ sender: Any) {
        let ivc = UIImagePickerController()
        ivc.sourceType = .photoLibrary
        ivc.delegate = self
        ivc.allowsEditing = true
        present(ivc, animated: true)
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
extension InputClientsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerIsEdited")] as? UIImage{
            addClientsImage.image = image
        }
    }
     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
       }
}
