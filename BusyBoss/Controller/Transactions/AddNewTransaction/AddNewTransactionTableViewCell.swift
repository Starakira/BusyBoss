//
//  productListNewTransactionViewCell.swift
//  Busy Boss
//
//  Created by Ryan Anslyno Khohari on 27/10/20.
//

import UIKit

class AddNewTransactionTableViewCell: UITableViewCell {

    @IBOutlet weak var GambarProductNewTransaction: UIImageView!
    @IBOutlet weak var NameProductNewTransaction: UILabel!
    @IBOutlet weak var transactionProductQuantityLabel: UILabel!
    @IBOutlet weak var JumlahHargaNewTransaction: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setProductQuantity(transaction: Transaction, product: Product?) {
        CloudKitManager.shared().transactionFetchProductQuantity(transactionID: transaction.recordID!, productID: (product?.recordID)!) {
            (quantity, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    self.transactionProductQuantityLabel.text = String(quantity)
                }
            }
        }
    }
}
