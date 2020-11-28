//
//  TransactionDetailViewController.swift
//  BusyBoss
//
//  Created by Muhammad Bangun Agung on 04/11/20.
//

import UIKit

class TransactionDetailsViewController: UIViewController{
    
    @IBOutlet weak var transactionNumberLabel: UILabel!
    @IBOutlet weak var NameUserTransaction: UILabel!
    @IBOutlet weak var transactionProductsTotalPriceLabel: UILabel!
    @IBOutlet weak var transactionDiscountLabel: UILabel!
    @IBOutlet weak var transactionTaxLabel: UILabel!
    @IBOutlet weak var transactionTotalValueLabel: UILabel!
    @IBOutlet weak var DateTransaction: UILabel!
    @IBOutlet weak var ProductListTransactionTableView: UITableView!
    
    var transaction : Transaction?
    var client: Client?
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
        
        ProductListTransactionTableView.dataSource = self
        ProductListTransactionTableView.delegate = self
        
        CloudKitManager.shared().transactionFetchAllProducts(transaction: transaction!) {
            (products, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                
                self.products = products
                self.ProductListTransactionTableView.reloadData()
            }
        }
        
        CloudKitManager.shared().clientFetchOnce(clientID: (transaction?.clientReference?.recordID)!) {
            (client, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.client = client
                self.NameUserTransaction.text = (self.client?.firstName ?? "") + (self.client?.lastName ?? "")
            }
        }
        
        transactionNumberLabel.text = transaction?.transactionNumber
        transactionProductsTotalPriceLabel.text = String(transaction?.value ?? 0.0)
        transactionDiscountLabel.text = String(transaction?.discount ?? 0.0)
        transactionTaxLabel.text = String(transaction?.tax ?? 0.0)
        transactionTotalValueLabel.text = String(transaction?.value ?? 0.0)
        DateTransaction.text = String(dateFormatter.string(from: transaction?.validityDate ?? Date()))
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
}



extension TransactionDetailsViewController: UITableViewDelegate{
    
}

extension TransactionDetailsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = products?[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productListNewViewCell", for: indexPath)as!AddNewTransactionTableViewCell
        
        cell.NameProductNewTransaction.text = product?.name
        cell.JumlahHargaNewTransaction.text = String(product?.price ?? 0)
        cell.GambarProductNewTransaction.image = product?.image
        
        cell.setProductQuantity(transaction: transaction!, product: product)
        
        return cell
    }
}
