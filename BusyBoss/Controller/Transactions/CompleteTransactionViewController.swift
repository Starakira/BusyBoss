//
//  CompleteTransactionViewController.swift
//  Busy Boss
//
//  Created by Ryan Anslyno Khohari on 19/10/20.
//

import UIKit

class CompleteTransactionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var completeTransactionTableView: UITableView!
    var Dummy : [DummyDataTransaction]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let DummyManager : DummyDataManager = DummyDataManager()
        Dummy = DummyManager.Dummy
        completeTransactionTableView.dataSource = self
        completeTransactionTableView.delegate = self
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Dummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "completeViewCell", for: indexPath)as!completeTransactionViewCell
        let Data = Dummy[indexPath.row]
        print (Data)
        cell.CodeTransactionLabel.text = String(Data.transactionCode)
        cell.NameUserLabel.text = Data.transactionUser
        cell.DescriptionTransactionLabel.text = Data.transactionDescription
        cell.StatusTransactionLabel.text = Data.transactionStatus
        cell.TotalJumlahLabel.text = String(Data.transactionTotalValue)
        cell.GambarTransaction.image = Data.transactionImage
        return cell

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
