//
//  ClientsViewController.swift
//  Busy Boss
//
//  Created by richard santoso on 27/10/20.
//

import UIKit

class ClientsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var clients : [clientsStruct]!
    @IBOutlet weak var clientsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let CSManager : clientsStructManager = clientsStructManager ()
        clients = CSManager.clients
        clientsTableView.delegate = self
        clientsTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clientsCell", for: indexPath)as!ClientsTableViewCell
        let cli = clients[indexPath.row]
        cell.clientsLabel.text = cli.clientsFirstName + cli.clientsLastName
        cell.clientsImage.image = cli.clientsImage
        cell.clientsCompanyName.text = cli.clientsCompanyName
        cell.clientsCompanyAddress.text = cli.clientsCompanyAddress
        cell.clientsPhoneNo.text = cli.clientsPhoneNo
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let vc = storyboard?.instantiateViewController(identifier: "clientsDetails") as! ClientsDetailsViewController
        vc.clients = clients[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
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
