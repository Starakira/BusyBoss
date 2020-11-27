//
//  TransactionDetailViewController.swift
//  BusyBoss
//
//  Created by Muhammad Bangun Agung on 04/11/20.
//

import UIKit

class TransactionDetailsViewController: UIViewController{
    
    @IBOutlet weak var TitleNameTransaction: UILabel!
    @IBOutlet weak var NameUserTransaction: UILabel!
    @IBOutlet weak var JumlahTotalHargaTransaction: UILabel!
    @IBOutlet weak var JumlahDiscountHargaTransaction: UILabel!
    @IBOutlet weak var JumlahTaxTransaction: UILabel!
    @IBOutlet weak var JumlahGrandTotalTransaction: UILabel!
    @IBOutlet weak var DateTransaction: UILabel!
    @IBOutlet weak var ProductListTransactionTableView: UITableView!
    
    var transaction : Transaction?

    var products : [Product]?
    
    let decimalFormatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    let dateFormatter : DateFormatter = {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy"
        return dateFormat
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CloudKitManager.shared().transactionFetchAllProducts(transaction: transaction!) {
            (products, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                
                self.products = products
                self.ProductListTransactionTableView.reloadData()
            }
        }
        
        TitleNameTransaction.text = transaction?.transactionNumber
//        NameUserTransaction.text = (transactionDummyData?.clientReference?.firstName ?? "") + (transactionDummyData?.clientReference?.lastName ?? "")
        JumlahTotalHargaTransaction.text = String(transaction?.value ?? 0.0)
        JumlahDiscountHargaTransaction.text = String(transaction?.discount ?? 0.0)
        JumlahTaxTransaction.text = String(transaction?.tax ?? 0.0)
        JumlahGrandTotalTransaction.text = String(transaction?.value ?? 0.0)
        DateTransaction.text = String(dateFormatter.string(from: transaction?.validityDate ?? Date()))
        
        ProductListTransactionTableView.dataSource = self
        ProductListTransactionTableView.delegate = self
    }
}

extension TransactionDetailsViewController: UITableViewDelegate{
    
}

extension TransactionDetailsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productListNewViewCell", for: indexPath)as!AddNewTransactionTableViewCell
        let product = products?[indexPath.row]
        cell.NameProductNewTransaction.text = product?.name
        cell.transactionProductQuantityLabel.text = String(product?.transactionQuantity ?? 0)
        cell.JumlahHargaNewTransaction.text = String(product?.price ?? 0)
        cell.GambarProductNewTransaction.image = product?.image
        return cell
    }
}
