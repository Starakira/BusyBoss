//
//  ClientsDetailsViewController.swift
//  Busy Boss
//
//  Created by richard santoso on 27/10/20.
//

import UIKit

class ClientsDetailsViewController: UIViewController {
    @IBOutlet weak var clientsImage: UIImageView!
    @IBOutlet weak var clientsNameLabel: UILabel!
    @IBOutlet weak var clientsCompanyName: UILabel!
    @IBOutlet weak var clientsCompanyAddress: UILabel!
    @IBOutlet weak var clientsCompanyEmail: UILabel!
    @IBOutlet weak var clientsPhoneNo: UILabel!
    var client : Client?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let client = client{
            clientsNameLabel.text = client.firstName + client.lastName
            clientsImage.image = client.image
            clientsCompanyName.text = client.companyName
            clientsCompanyAddress.text = client.companyAddress
            clientsCompanyEmail.text = client.emailAddress
            clientsPhoneNo.text = client.phoneNumber
        }
        
//        let editButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.edit, target: self, action: #selector(self.editButtonFunction))
//            navigationItem.rightBarButtonItem = editButton
//            title = "Client Details"
    }
    
//    @objc func editButtonFunction() {
//        let vc = storyboard?.instantiateViewController(identifier: "inputClient") as! InputClientsViewController
//        
//        vc.client = client
//        
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    

    @IBAction func cancelButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
