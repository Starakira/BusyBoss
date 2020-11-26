//
//  TransactionViewController.swift
//  Busy Boss
//
//  Created by Muhammad Bangun Agung on 15/10/20.
//

import UIKit

protocol TransactionConform {
    func transactionSave(transaction: Transaction)
}

class TransactionViewController: UIViewController {
    @IBOutlet weak var TransactionSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var transactionDataSource: [Transaction] = []

    var transactionsAll: [Transaction]? = []
    
    var transactionIndex = -1

    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
        CloudKitManager.shared().transactionsFetchAll() {
            (transactions, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Appending: \(transactions)")
                
                self.transactionDataSource = transactions
                
                print("This is transaction \(self.transactionDataSource)")
                
                self.tableView.reloadData()
            }
        }
        
        transactionsAll = []
    }
    
    @IBAction func segmentedTransaction(_ sender: UISegmentedControl) {
        refreshTableView(selectedSegmentIndex: sender.selectedSegmentIndex)
        print("Segmented is Called!")
    }
    
    func refreshTableView(selectedSegmentIndex: Int) {
        if let transactionsAll = transactionsAll {
            switch selectedSegmentIndex {
            case 0: //Ongoing
                transactionDataSource = transactionsAll.filter{ $0.status == TransactionStatus.ongoing}
            case 1: //Completed
                transactionDataSource = transactionsAll.filter{ $0.status == TransactionStatus.completed}
            case 2:
                transactionDataSource = transactionsAll.filter{ $0.status == TransactionStatus.canceled}
            default:
                return
            }
            
            tableView.reloadData()
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? AddNewTransactionViewController {
            viewController.transactionDelegate = self
        } else if let viewController = segue.destination as? TransactionDetailsViewController {
            viewController.transactionDummyData = transactionDataSource[transactionIndex]
            viewController.products = transactionDataSource[transactionIndex].products
        }
    }
}

extension TransactionViewController : TransactionConform{
    func transactionSave(transaction: Transaction) {
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
        cell.labelTotalPrice.text = "Rp. \(String(describing: transaction.value))"
        cell.labelTransactionCode.text = transaction.transactionNumber
        cell.labelClientName.text = "\(transaction.client?.firstName ?? "") \(transaction.client?.lastName ?? "")"
        return cell
    }
}
