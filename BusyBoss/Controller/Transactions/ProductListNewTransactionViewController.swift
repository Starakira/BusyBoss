//
//  productListNewTransactionViewController.swift
//  Busy Boss
//
//  Created by Ryan Anslyno Khohari on 27/10/20.
//

import UIKit

protocol ClientsConform {
    func clientListPassData(client: Client)
}

class ProductListNewTransactionViewController: UIViewController, ClientsConform {
    func clientListPassData(client: Client) {
        self.client = client
        self.clientTextField.text = client.firstName + client.lastName
    }
    
    @IBOutlet weak var clientTextField: UITextField!
    
    var client: Client?
    var index = -1
    
    @IBOutlet weak var ProductListNewTransaction: UITableView!
    var Dummy : [DummyDataTransaction]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let DummyManager : DummyDataManager = DummyDataManager()
        Dummy = DummyManager.Dummy
        ProductListNewTransaction.dataSource = self
        ProductListNewTransaction.delegate = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ClientContactViewController{
            vc.clientsListDelegate = self
        }
    }
}

extension ProductListNewTransactionViewController: UITableViewDelegate{
    
}

extension ProductListNewTransactionViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Dummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productListNewViewCell", for: indexPath)as!ProductListNewTransactionViewCell
        let Data = Dummy[indexPath.row]
        cell.NameProductNewTransaction.text = Data.transactionGoodName
        cell.StockNewTransaction.text = String(Data.transactionStockNumber)
        cell.JumlahHargaNewTransaction.text = String(Data.transactionTotalValue)
        cell.GambarProductNewTransaction.image = Data.transactionImage
        return cell
    }
}
