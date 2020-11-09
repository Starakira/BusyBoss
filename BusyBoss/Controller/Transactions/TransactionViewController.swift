//
//  TransactionViewController.swift
//  Busy Boss
//
//  Created by Muhammad Bangun Agung on 15/10/20.
//

import UIKit

class TransactionViewController: UIViewController {
    
    @IBOutlet weak var TransactionSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var transactionsAll: [Transaction]?
    
    var transactions: [Transaction] = []

    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
        CloudKitManager.shared().transactionsFetchAll { (result, error) in
            if let error = error {
                Alert.showError(self, error)
            }
            else {
                self.transactionsAll = result
                self.refreshTableView(selectedSegmentIndex: self.TransactionSegmentedControl.selectedSegmentIndex)
            }
        }
    }
    
    @IBAction func segmentedTransaction(_ sender: UISegmentedControl) {
        refreshTableView(selectedSegmentIndex: sender.selectedSegmentIndex)
    }
    
    func refreshTableView(selectedSegmentIndex: Int) {
        if let transactionsAll = transactionsAll {
            switch selectedSegmentIndex {
            case 0: //Ongoing
                transactions = transactionsAll.filter{ $0.status == TransactionStatus.Ongoing}
            case 1: //Completed
                transactions = transactionsAll.filter{ $0.status == TransactionStatus.Completed}
            case 2:
                transactions = transactionsAll.filter{ $0.status == TransactionStatus.Ongoing}
            default:
                return
            }
            
            tableView.reloadData()
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let transaction = transactions[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionViewCell") as! TransactionViewCell
        cell.labelStatus.text = transaction.status.rawValue
        cell.labelDescription.text = transaction.description
        cell.labelTotalPrice.text = "Rp. \(transaction.getTotalProductPrices()),-)"
        cell.labelTransactionCode.text = "\(transaction.recordID.hashValue)"
        cell.labelClientName.text = "\(transaction.client?.firstName ?? "") \(transaction.client?.lastName ?? "")"
        return cell
    }
}
