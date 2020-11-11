//
//  ClientsViewController.swift
//  Busy Boss
//
//  Created by richard santoso on 27/10/20.
//

import UIKit

class ClientsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var clients : [Client] = []
    @IBOutlet weak var clientsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        clientsTableView.delegate = self
        clientsTableView.dataSource = self
        
        CloudKitManager.shared().clientsFetchAll {
            (clients, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                print("Fetching client successful")
                print(clients)
                self.clients = clients
                self.clientsTableView.reloadData()
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clientsCell", for: indexPath)as!ClientsTableViewCell
        let client = clients[indexPath.row]
        cell.clientsLabel.text = client.firstName + client.lastName
        cell.clientsImage.image = client.image
        cell.clientsCompanyName.text = client.companyName
        cell.clientsCompanyAddress.text = client.companyAddress
        cell.clientsPhoneNo.text = client.phoneNumber
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "clientsDetails") as! ClientsDetailsViewController
        vc.client = clients[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func unwindToSegue(_ sender: UIStoryboardSegue) {
        guard let vc = sender.source as? InputClientsViewController else {
//            Alert.showAlert(view: self, title: "Error", message: "Failed to cast Source ViewController to InputClientsViewController")
            print("Failed to cast Source ViewController to InputClientsViewController")
            return
        }
        
        guard var client = vc.client else {
//            Alert.showAlert(view: self, title: "Error", message: "No Client Data present!")
            print("No Client Data present!")
            return
        }
        
        CloudKitManager.shared().clientCreate(client: client) { (recordID, error) in
            if let error = error {
//                Alert.showError(self, error)
                print(error.localizedDescription)
            }
            else if recordID == nil {
                print("ID not created!")
//                Alert.showAlert(view: self, title: "ID not created!", message: "Database failed to create ID for new client!")
            }
            else {
                print("Creating client successful")
//                client = client
                client.recordID = recordID
                
                /*
                let vc = self.storyboard?.instantiateViewController(identifier: "clients") as! ClientsViewController
                self.navigationController?.pushViewController(vc, animated: true)
                 */
            }
        }
        
        clients.append(client)
        print(clients)
        clientsTableView.reloadData()
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
