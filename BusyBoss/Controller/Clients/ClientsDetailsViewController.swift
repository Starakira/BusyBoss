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
    @IBOutlet weak var clientsComapnyAddress: UILabel!
    @IBOutlet weak var clientsCompanyEmail: UILabel!
    @IBOutlet weak var clientsPhoneNo: UILabel!
    var clients : clientsStruct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let cli = clients{
            clientsNameLabel.text = cli.clientsFirstName + cli.clientsLastName
            clientsImage.image = cli.clientsImage
            clientsCompanyName.text = cli.clientsCompanyName
            clientsComapnyAddress.text = cli.clientsCompanyAddress
            clientsCompanyEmail.text = cli.clientsEmailAddress
            clientsPhoneNo.text = cli.clientsPhoneNo
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
