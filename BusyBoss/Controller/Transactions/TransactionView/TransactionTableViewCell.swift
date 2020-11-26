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
        if let clientRecordID = transaction.clientReference?.recordID {
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
    
    func getProductList(transaction: Transaction) {
        
    }
}
