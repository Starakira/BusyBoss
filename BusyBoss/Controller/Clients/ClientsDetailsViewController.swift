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
            clientsPhoneNo.text = client.phoneNumber
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
