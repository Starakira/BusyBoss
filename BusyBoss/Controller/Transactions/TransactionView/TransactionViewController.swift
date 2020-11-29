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
    
    var client: Client?
    
    override func viewDidLoad() {
        transactionTableView.tableFooterView = UIView()
        
        transactionTableView.delegate = self
        transactionTableView.dataSource = self
        
        self.transactionsAll = []
        let pendingAction = Alert.displayPendingAlert(title: "Loading transactions...")
        
        self.present(pendingAction, animated: true){
            CloudKitManager.shared().transactionsFetchAll() {
                (transactions, error) in
                if let error = error {
                    pendingAction.dismiss(animated: true){
                        Alert.showCloudKitError(self, error)
                    }
                } else {
                    pendingAction.dismiss(animated: true){
                        self.transactionDataSource.append(contentsOf: transactions)
                        self.transactionsAll = transactions
                        self.transactionTableView.reloadData()
                    }
                }
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
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? AddNewTransactionViewController {
            viewController.transactionDelegate = self
        } else if let viewController = segue.destination as? TransactionDetailsViewController {
            viewController.transaction = transactionDataSource[transactionIndex]
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

extension UITableView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
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
        cell.labelTotalPrice.text = "Rp. \(String(describing: transaction.value))"
        cell.labelTransactionCode.text = transaction.transactionNumber
        
        cell.setClientName(transaction: transaction)
        cell.setTransactionValue(transaction: transaction)
        
        return cell
    }
}
