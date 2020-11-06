//
//  TransactionDetailViewController.swift
//  BusyBoss
//
//  Created by Muhammad Bangun Agung on 04/11/20.
//

import UIKit

class TransactionDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var TitleNameTransaction: UILabel!
    @IBOutlet weak var NameUserTransaction: UILabel!
    @IBOutlet weak var JumlahTotalHargaTransaction: UILabel!
    @IBOutlet weak var JumlahDiscountHargaTransaction: UILabel!
    @IBOutlet weak var JumlahTaxTransaction: UILabel!
    @IBOutlet weak var JumlahGrandTotalTransaction: UILabel!
    @IBOutlet weak var DateTransaction: UILabel!
    @IBOutlet weak var ProductListTransactionTableView: UITableView!
    
    
    var Dummy : [DummyDataTransaction]!

    var dummy : DummyDataTransaction?

    override func viewDidLoad() {
        super.viewDidLoad()

        let DummyManager : DummyDataManager = DummyDataManager()
        Dummy = DummyManager.Dummy
        ProductListTransactionTableView.dataSource = self
        ProductListTransactionTableView.delegate = self


        
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
