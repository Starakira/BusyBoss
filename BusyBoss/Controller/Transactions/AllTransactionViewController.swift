//
//  AllTransactionViewController.swift
//  Busy Boss
//
//  Created by Ryan Anslyno Khohari on 19/10/20.
//

import UIKit

class AllTransactionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var allTransactionTableView: UITableView!
    var Dummy = [
        DummyDataTransaction(
            transactionCode: 666,
            transactionUser: "bang jago",
            transactionDescription: "Tumbas kacang",
            transactionStatus: "OnGoing",
            transactionTotalValue: 999000,
            transactionStockNumber: 10,
            transactionGoodName: "Kacang2Kelinci",
            transactionImage: #imageLiteral(resourceName: "Foruminity_Logo_Icon"),
            transactionClientPhoneNumber: "14045",
            transactionClientAddress: "Candi Borobudur",
            transactionClientCompanyName: "Koplak Jaya",
            transactionServiceName: "Cukur Bulu Kaki"),
        DummyDataTransaction(
            transactionCode: 999,
            transactionUser: "mas yus",
            transactionDescription: "kaos kaki",
            transactionStatus: "Canceled",
            transactionTotalValue: 899000,
            transactionStockNumber: 9,
            transactionGoodName: "Kuaci Sambalado",
            transactionImage: #imageLiteral(resourceName: "EXPp0EPVAAERD2A.jpeg"),
            transactionClientPhoneNumber: "14022",
            transactionClientAddress: "Candi Prambanan",
            transactionClientCompanyName: "CV. Darsono",
            transactionServiceName: "Tukang Cuci Piring")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allTransactionTableView.dataSource = self
        allTransactionTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Dummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allViewCell", for: indexPath)as!TransactionViewCell
        let Data = Dummy[indexPath.row]
        print (Data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let DetailVC = storyboard?.instantiateViewController(identifier: "TransactionDetailsView")as!TransactionDetailsViewController
        DetailVC.dummy = Dummy[indexPath.row]
        self.navigationController?.pushViewController(DetailVC, animated: true)
    }
    
}
