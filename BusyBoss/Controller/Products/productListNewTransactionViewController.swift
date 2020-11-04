//
//  productListNewTransactionViewController.swift
//  Busy Boss
//
//  Created by Ryan Anslyno Khohari on 27/10/20.
//

import UIKit

class productListNewTransactionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var ProductListNewTransaction: UITableView!
    var Dummy : [DummyDataTransaction]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let DummyManager : DummyDataManager = DummyDataManager()
        Dummy = DummyManager.Dummy
        ProductListNewTransaction.dataSource = self
        ProductListNewTransaction.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Dummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productListNewViewCell", for: indexPath)as!productListNewTransactionViewCell
        let Data = Dummy[indexPath.row]
        print (Data)
        cell.NameProductNewTransaction.text = Data.transactionGoodName
        cell.StockNewTransaction.text = String(Data.transactionStockNumber)
        cell.JumlahHargaNewTransaction.text = String(Data.transactionTotalValue)
        cell.GambarProductNewTransaction.image = Data.transactionImage
        return cell
    }
    

}
