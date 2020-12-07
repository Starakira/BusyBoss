//
//  ClientsViewController.swift
//  Busy Boss
//
//  Created by richard santoso on 27/10/20.
//

import UIKit

class ClientsViewController: UIViewController {
    
    var clients : [Client] = []
    var index = -1
    
    @IBOutlet weak var clientsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clientsTableView.tableFooterView = UIView()
        
        clientsTableView.delegate = self
        clientsTableView.dataSource = self
        
        CloudKitManager.shared().clientsFetchAll {
            (clients, error) in
            if let error = error {
                Alert.showCloudKitError(self, error)
            }
            else {
                self.clients = clients
                self.clientsTableView.reloadData()
            }
        }
    }
    
    @IBAction func unwindToSegue(_ sender: UIStoryboardSegue) {
        guard let vc = sender.source as? InputClientViewController else {
            print("Failed to cast Source ViewController to InputClientsViewController")
            return
        }
        
        guard var client = vc.client else {
            print("No Client Data present!")
            return
        }
        
        let pendingAction = Alert.displayPendingAlert(title: "Creating client...")
        
        vc.present(pendingAction, animated: true){
            CloudKitManager.shared().clientCreate(client: client) { (recordID, error) in
                if let error = error {
                    print(error.localizedDescription)
                    Alert.showAlert(view: self, title: "Error creating client", message: "Error")
                    return
                }
                
                pendingAction.dismiss(animated: true){
                    //Create new Client
                    if self.index == -1 {
                        if recordID == nil {
                            print("ID not created!")
                        }
                        else {
                            print("Creating client successful")
                            client.recordID = recordID
                            
                            self.clients.append(client)
                        }
                    }
                    
                    //update existing client
                    else {
                        self.clients[self.index] = client
                    }
                    
                    self.clientsTableView.reloadData()
                    self.index = -1
                }
            }
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if let clientDetailsViewController = segue.destination as? ClientsDetailsViewController {
            print("Index \(index)")
            // Pass the selected object to the new view controller.
            clientDetailsViewController.client = clients[index]
            
            clientDetailsViewController.clientDetailsDelegate = self
        } else if let inputClientViewController = segue.destination as? InputClientViewController {
            // Pass the selected object to the new view controller.
            inputClientViewController.client = index != -1 ? clients[index] : nil
        }
        
        index = -1
    }
}

extension ClientsViewController: ClientsConform {
    func clientListPassData(client: Client) {
        self.clients[index] = client
        clientsTableView.reloadData()
    }
}

extension ClientsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index = indexPath.row
        
        performSegue(withIdentifier: "clientDetailsSegue", sender: self)
        
        self.index = indexPath.row
    }
}

extension ClientsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clientsCell", for: indexPath)as!ClientsTableViewCell
        let client = clients[indexPath.row]
        
        cell.clientsLabel.text = client.firstName + " " + client.lastName
        cell.clientsImage.image = client.image
        cell.clientsCompanyName.text = client.companyName
        cell.clientsCompanyAddress.text = client.companyAddress
        cell.clientsPhoneNo.text = client.phoneNumber
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clients.count
    }
    
}
