//
//  ProductListEditViewController.swift
//  BusyBoss
//
//  Created by Muhammad Bangun Agung on 19/11/20.
//

import UIKit

class ProductListEditTransactionViewController: UIViewController {
    
    @IBOutlet weak var transactionNumberTextField: UITextField!
    @IBOutlet weak var transactionClientTextField: UITextField!
    
    var transaction: DummyTransaction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let transaction = transaction {
            transactionNumberTextField.text = transaction.transactionNumber
            transactionClientTextField.text = (transaction.client?.firstName ?? "") + (transaction.client?.lastName ?? "")
        }
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
