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

class TransactionViewController: UIViewController, TransactionConform {
    func transactionSave(transaction: DummyTransaction) {
        transactionDummyData.append(transaction)
        tableView.reloadData()
    }
    
    @IBOutlet weak var TransactionSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var transactionDummyData: [DummyTransaction] = []

    var transactionsAll: [DummyTransaction]?
//
//    var transactions: [Transaction] = []

    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
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
    }
    
    func refreshTableView(selectedSegmentIndex: Int) {
        if let transactionsAll = transactionsAll {
            switch selectedSegmentIndex {
            case 0: //Ongoing
                transactionDummyData = transactionsAll.filter{ $0.status == TransactionStatus.Ongoing}
            case 1: //Completed
                transactionDummyData = transactionsAll.filter{ $0.status == TransactionStatus.Completed}
            case 2:
                transactionDummyData = transactionsAll.filter{ $0.status == TransactionStatus.Ongoing}
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
        }
        
        if let viewController = segue.destination as? TransactionDetailsViewController {
            
        }
        
    }
}

extension TransactionViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension TransactionViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionDummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let transaction = transactionDummyData[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionViewCell") as! TransactionViewCell
        cell.labelStatus.text = transaction.status.rawValue
        cell.labelDescription.text = transaction.description
        cell.labelTotalPrice.text = "Rp. \(transaction.transactionTotalPrice),-)"
        cell.labelTransactionCode.text = "001"
        cell.labelClientName.text = "\(transaction.client?.firstName ?? "") \(transaction.client?.lastName ?? "")"
        return cell
    }
}
