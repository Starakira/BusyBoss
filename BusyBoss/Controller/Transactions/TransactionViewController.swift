//
//  TransactionViewController.swift
//  Busy Boss
//
//  Created by Muhammad Bangun Agung on 15/10/20.
//

import UIKit

protocol TransactionConform {
    func transactionSave(transaction: DummyTransaction)
}

class TransactionViewController: UIViewController {
    @IBOutlet weak var TransactionSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var transactionDataSource: [DummyTransaction] = []

    var transactionsAll: [DummyTransaction]? = []
    
    var transactionIndex = -1
    
    var dummyProducts = [
        Product(image: #imageLiteral(resourceName: "Foruminity_Logo_Icon"), name: "Shoes", description: "", price: 20000, stock: 5, unit: "", transactionQuantity: 2, type: ProductType.goods),
        Product(image: #imageLiteral(resourceName: "Foruminity_Logo_Icon"), name: "Shirt", description: "", price: 15000, stock: 10, unit: "", transactionQuantity: 3, type: ProductType.goods),
        Product(image: #imageLiteral(resourceName: "Foruminity_Logo_Icon"), name: "Sablon", description: "", price: 30000, stock: 20, unit: "", transactionQuantity: 5, type: ProductType.services),]

    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
        transactionsAll = []
//        CloudKitManager.shared().transactionsFetchAll { (result, error) in
//            if let error = error {
//                Alert.showError(self, error)
//            }
//            else {
//                self.transactionsAll = result
//                self.refreshTableView(selectedSegmentIndex: self.TransactionSegmentedControl.selectedSegmentIndex)
//            }
//        }
    }
    
    @IBAction func segmentedTransaction(_ sender: UISegmentedControl) {
        refreshTableView(selectedSegmentIndex: sender.selectedSegmentIndex)
        print("Segmented is Called!")
    }
    
    func refreshTableView(selectedSegmentIndex: Int) {
        if let transactionsAll = transactionsAll {
            switch selectedSegmentIndex {
            case 0: //Ongoing
                transactionDataSource = transactionsAll.filter{ $0.status == TransactionStatus.Ongoing}
            case 1: //Completed
                transactionDataSource = transactionsAll.filter{ $0.status == TransactionStatus.Completed}
            case 2:
                transactionDataSource = transactionsAll.filter{ $0.status == TransactionStatus.Canceled}
            default:
                return
            }
            
            tableView.reloadData()
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? ProductListNewTransactionViewController {
            viewController.transactionDelegate = self
        } else if let viewController = segue.destination as? TransactionDetailsViewController {
            viewController.transactionDummyData = transactionDataSource[transactionIndex]
            viewController.products = transactionDataSource[transactionIndex].products
        }
    }
}

extension TransactionViewController : TransactionConform{
    func transactionSave(transaction: DummyTransaction) {
        transactionsAll?.append(transaction)
        refreshTableView(selectedSegmentIndex: TransactionSegmentedControl.selectedSegmentIndex)
    }
}

extension TransactionViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        transactionIndex = indexPath.row
        performSegue(withIdentifier: "transactionDetailsSegue", sender: self)
    }
}

extension TransactionViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let transaction = transactionDataSource[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionViewCell") as! TransactionViewCell
        cell.labelStatus.text = transaction.status.rawValue
        cell.labelDescription.text = transaction.description
        cell.labelTotalPrice.text = "Rp. \(transaction.transactionTotalPrice),-)"
        cell.labelTransactionCode.text = transaction.transactionNumber
        cell.labelClientName.text = "\(transaction.client?.firstName ?? "") \(transaction.client?.lastName ?? "")"
        return cell
    }
}
