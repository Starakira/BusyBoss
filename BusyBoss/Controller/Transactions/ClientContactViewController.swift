//
//  ClientContactViewController.swift
//  Busy Boss
//
//  Created by Ryan Anslyno Khohari on 27/10/20.
//

import UIKit

class ClientContactViewController: UIViewController {
    @IBOutlet weak var ContactClientListTableView: UITableView!

    var clients : [Client] = []
    var index = -1
    
    let logoBuilding = #imageLiteral(resourceName: "shiba icon new")
    let logoAddress = #imageLiteral(resourceName: "shiba icon new")
    let logoPhone = #imageLiteral(resourceName: "shiba icon new")

    var clientsListDelegate: ClientsConform?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        ContactClientListTableView.dataSource = self
        ContactClientListTableView.delegate = self
        
        CloudKitManager.shared().clientsFetchAll {
            (clients, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                print("Fetching client successful")
                print("Clients = \(clients.count)")
                self.clients = clients
                self.ContactClientListTableView.reloadData()
            }
        }
    }
}


extension ClientContactViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedClient = clients[indexPath.row]
        
        clientsListDelegate?.clientListPassData(client: selectedClient)
        dismiss(animated: true, completion: nil)
    }
}

extension ClientContactViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientContactViewCell", for: indexPath)as!ClientContactTableViewCell
        let client = clients[indexPath.row]
        cell.NameContactClient.text = client.firstName + client.lastName
        cell.NameCompanyClient.text = client.companyName
        cell.AddressCompanyClient.text = client.companyAddress
        cell.NumberTelephoneCompany.text = client.phoneNumber
        cell.LogoCompanyClient.image = client.image
        cell.LogoBuildingCompany.image = logoBuilding
        cell.LogoAddress.image = logoAddress
        cell.LogoPhone.image = logoPhone
        return cell
    }
}
