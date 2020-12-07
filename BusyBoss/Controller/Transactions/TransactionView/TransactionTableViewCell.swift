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
    
    let decimalFormatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
          let bottomSpace = 30.0 // Let's assume the space you want is 10
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: CGFloat(bottomSpace), right: 0))
     }
    
    func setClientName(transaction: Transaction) {
        
        if let clientFirstName = transaction.client?.firstName {
            self.labelClientName.text = clientFirstName
        }
        
        if let clientLastName = transaction.client?.lastName {
            self.labelClientName.text = " \(String(self.labelClientName.text ?? "")) \(clientLastName)"
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
        
        var totalPrice: Double = 0
        
        if let products = transaction.products{
            for product in products {
                totalPrice += Double(product.price) * Double(product.transactionQuantity ?? 0)
            }
            labelTotalPrice.text = "Rp. \(decimalFormatter.string(for: totalPrice) ?? "0")"
        } else {
            CloudKitManager.shared().transactionFetchTotalPrice(transaction: transaction){
                (price, error) in
                
                if let error = error {
                    print("Error Fetch Price : \(error.localizedDescription)")
                } else {
                    self.labelTotalPrice.text = "Rp. \(self.decimalFormatter.string(for: price) ?? "0")"
                }
            }
        }
    }
}
