//
//  ClientContactViewController.swift
//  Busy Boss
//
//  Created by Ryan Anslyno Khohari on 27/10/20.
//

import UIKit

class AddNewTransactionClientViewController: UIViewController {
    @IBOutlet weak var ContactClientListTableView: UITableView!

    var clients : [Client] = []
    var index = -1

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
                self.clients = clients
                self.ContactClientListTableView.reloadData()
            }
        }
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}


extension AddNewTransactionClientViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedClient = clients[indexPath.row]
        
        clientsListDelegate?.clientListPassData(client: selectedClient)
        dismiss(animated: true, completion: nil)
    }
}

extension AddNewTransactionClientViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if clients.count == 0 {
            tableView.setEmptyView(title: "It's empty!", message: "You can add clients \n from the \"Clients\" tab")
        }
        else {
            tableView.restore()
        }
        
        return clients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientContactViewCell", for: indexPath)as!AddNewTransactionClientTableViewCell
        let client = clients[indexPath.row]
        cell.NameContactClient.text = client.firstName + " " + client.lastName
        cell.NameCompanyClient.text = client.companyName
        cell.AddressCompanyClient.text = client.companyAddress
        cell.NumberTelephoneCompany.text = client.phoneNumber
        cell.LogoCompanyClient.image = client.image
        return cell
    }
}
