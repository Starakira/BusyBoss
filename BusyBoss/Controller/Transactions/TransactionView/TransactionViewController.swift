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
    @IBOutlet weak var transactionTableView: UITableView!
    
    var transactionDataSource: [Transaction] = []
    
    var transactionsAll: [Transaction]? = []
    
    var transactionIndex = -1
    
    let decimalFormatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var selectedTransaction: Transaction?
    
    var pendingAction: UIAlertController?
    
    override func viewDidLoad() {
        transactionTableView.tableFooterView = UIView()
        
        transactionTableView.delegate = self
        transactionTableView.dataSource = self
        
        //transactionTableView.backgroundColor = UIColor(red: 241/255, green: 242/255, blue: 246/255, alpha: 1)
        //transactionTableView.backgroundView?.backgroundColor = UIColor(red: 241/255, green: 242/255, blue: 246/255, alpha: 1)
        
        self.transactionsAll = []
        
        CloudKitManager.shared().transactionsFetchAll() {
            (transactions, error) in
            if let error = error {
                Alert.showCloudKitError(self, error)
            } else {
                self.transactionDataSource.append(contentsOf: transactions)
                self.transactionsAll = transactions
                self.transactionTableView.reloadData()
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
                transactionDataSource = transactionsAll.filter{ $0.status == TransactionStatus.ongoing}
            case 1: //Completed
                transactionDataSource = transactionsAll.filter{ $0.status == TransactionStatus.completed}
            case 2:
                transactionDataSource = transactionsAll
            default:
                return
            }
            
            transactionTableView.reloadData()
        }
    }
    
    func fetchSelectedTransactionData(completionHandler: @escaping () -> Void) {
        selectedTransaction = transactionDataSource[transactionIndex]
        pendingAction = Alert.displayPendingAlert(title: "Fetching selected transaction client...")
        
        if selectedTransaction?.products != nil, selectedTransaction?.client != nil {
            completionHandler()
            return
        }
        
        self.present(pendingAction!, animated: true) {
            self.fetchSelectedTransactionClient(self.selectedTransaction!) {
                self.fetchSelectedTransactionProducts(self.selectedTransaction!) {
                    //Cache the fetched transaction data for optimization
                    self.transactionDataSource[self.transactionIndex] = self.selectedTransaction!
                    self.pendingAction?.dismiss(animated: false, completion: {
                        completionHandler()
                    })
                }
            }
        }
    }
    
    private func fetchSelectedTransactionClient(_ transaction: Transaction, _ completionHandler: @escaping () -> Void) {
        pendingAction?.title = "Fetching selected transaction client..."
        
        CloudKitManager.shared().clientFetchOnce(clientID: (selectedTransaction?.clientReference?.recordID)!) {
            (client, error) in
            if let error = error {
                self.pendingAction?.dismiss(animated: false, completion: {
                    Alert.showRetryCloudkitError(view: self, title: "Failed to fetch client information. \n Retry?", error: error) {self.fetchSelectedTransactionClient(transaction, completionHandler)}
                })
            } else {
                self.selectedTransaction?.client = client
                completionHandler()
            }
        }
    }
    
    private func fetchSelectedTransactionProducts(_ transaction: Transaction, _ completionHandler: @escaping () -> Void) {
        pendingAction?.title = "Fetching selected transaction products..."
        
        CloudKitManager.shared().transactionFetchAllProducts(transaction: selectedTransaction!) {
            (products, error) in
            if let error = error {
                self.pendingAction?.dismiss(animated: false, completion: {
                    Alert.showRetryCloudkitError(view: self, title: "Failed to fetch products information. \n Retry?", error: error) {self.fetchSelectedTransactionProducts(transaction, completionHandler)}
                })
            } else {
                self.selectedTransaction?.products = products
                completionHandler()
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? AddNewTransactionViewController {
            viewController.transactionDelegate = self
        } else if let viewController = segue.destination as? TransactionDetailsViewController {
            viewController.transaction = selectedTransaction
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
        
        fetchSelectedTransactionData {
            self.performSegue(withIdentifier: "transactionDetailsSegue", sender: self)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension TransactionViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if transactionDataSource.count == 0 {
            tableView.setEmptyView(title: "It's empty!", message: "Start your new transaction \n by hitting \"+\" button")
        }
        else {
            tableView.restore()
        }
        
        return transactionDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let transaction = transactionDataSource[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionViewCell") as! TransactionTableViewCell
        
        cell.labelStatus.text = transaction.status.rawValue.capitalized
        cell.labelStatus.textAlignment = .center
        
        if transaction.status.rawValue.capitalized == "Ongoing"{
            cell.labelStatus.backgroundColor = .yellow
        } else if transaction.status.rawValue.capitalized == "Completed" {
            cell.labelStatus.backgroundColor = .green
        } else {
            cell.labelStatus.backgroundColor = .red
        }
        
        cell.labelDescription.text = transaction.description
        cell.labelTotalPrice.text = "Rp. \(decimalFormatter.string(for: transaction.value) ?? "0")"
        cell.labelTransactionCode.text = transaction.transactionNumber
        
        cell.setClientName(transaction: transaction)
        cell.setTransactionValue(transaction: transaction)
        
        return cell
    }
}
