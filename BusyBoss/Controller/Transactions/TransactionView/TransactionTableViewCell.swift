//
//  allTransactionViewCell.swift
//  Busy Boss
//
//  Created by Ryan Anslyno Khohari on 27/10/20.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelTransactionCode: UILabel!
    @IBOutlet weak var labelClientName: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var labelTotalPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setClientName(transaction: Transaction) {
        
        if let clientFirstName = transaction.client?.firstName {
            self.labelClientName.text = clientFirstName
        }
        
        if let clientLastName = transaction.client?.lastName {
            self.labelClientName.text = "\(String(self.labelClientName.text ?? "")) \(clientLastName)"
        }
        
        else if let clientRecordID = transaction.clientReference?.recordID {
            CloudKitManager.shared().transactionFetchClientName(clientID: clientRecordID){
                (clientName, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self.labelClientName.text = clientName
                }
            }
        } else {
            self.labelClientName.text = "No Name"
        }
    }
    
    func setTransactionValue(transaction: Transaction){
        print("Calling setTransactionValue")
        var totalPrice: Double = 0
        
        if let products = transaction.products{
            for product in products {
                totalPrice += Double(product.price) * Double(product.transactionQuantity ?? 0)
            }
            labelTotalPrice.text = String(totalPrice)
        } else {
            CloudKitManager.shared().transactionFetchTotalPrice(transaction: transaction){
                (totalprice, error) in
                print("setTransactionValue Function is called...")
                if let error = error {
                    print("Error Fetch Price : \(error.localizedDescription)")
                } else {
                    self.labelTotalPrice.text = String(totalprice)
                }
            }
        }
    }
}
