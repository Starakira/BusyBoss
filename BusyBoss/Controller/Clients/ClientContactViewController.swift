//
//  ClientContactViewController.swift
//  Busy Boss
//
//  Created by Ryan Anslyno Khohari on 27/10/20.
//

import UIKit

class ClientContactViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var ContactClientListTableView: UITableView!
    var Dummy : [DummyDataTransaction]!

    override func viewDidLoad() {
        super.viewDidLoad()

        let DummyManager : DummyDataManager = DummyDataManager()
        Dummy = DummyManager.Dummy
        ContactClientListTableView.dataSource = self
        ContactClientListTableView.delegate = self
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Dummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientContactViewCell", for: indexPath)as!ClientContactTableViewCell
        let Data = Dummy[indexPath.row]
        print (Data)
        cell.NameContactClient.text = Data.transactionUser
        cell.NameCompanyClient.text = Data.transactionClientCompanyName
        cell.AddressCompanyClient.text = Data.transactionClientAddress
        cell.NumberTelephoneCompany.text = Data.transactionClientPhoneNumber
        cell.LogoCompanyClient.image = Data.transactionImage
        cell.LogoBuildingCompany.image = Data.transactionImage
        cell.LogoAddress.image = Data.transactionImage
        cell.LogoPhone.image = Data.transactionImage
        return cell
    }
    


}
