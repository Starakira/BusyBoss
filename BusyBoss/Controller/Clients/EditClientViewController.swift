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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //If client exist, then fill the fields
        if let client = client {
            clientFirstName.text = client.firstName
            clientLastName.text = client.lastName
            clientCompanyName.text = client.companyName
            clientAddress.text = client.companyAddress
            clientEmailAddress.text = client.emailAddress
            clientPhoneNo.text = client.phoneNumber
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
