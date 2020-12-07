//
//  productListNewTransactionViewCell.swift
//  Busy Boss
//
//  Created by Ryan Anslyno Khohari on 27/10/20.
//

import UIKit

class AddNewTransactionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var transactionProductQuantityLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setProductQuantity(transaction: Transaction, product: Product?) {
        if let productID = product?.recordID {
            print("ProductID fetched!")
            CloudKitManager.shared().transactionFetchProductQuantity(transactionID: transaction.recordID!, productID: productID) {
                (quantity, error) in
                if let error = error {
                    print("setProductQuantity error : \(error.localizedDescription)")
                } else {
                    self.transactionProductQuantityLabel.text = String(quantity)
                }
            }
        }else {
            print("ProductID not fetched!")
            self.transactionProductQuantityLabel.text = String(product?.transactionQuantity ?? 0)
        }
    }
    
    func getProductTotalValue(transaction: Transaction) -> Double{
        
        var totalPrice: Double = 0
        
        if let products = transaction.products{
            for product in products {
                totalPrice += Double(product.price) * Double(product.transactionQuantity ?? 0)
            }
            return totalPrice
        } else {
            CloudKitManager.shared().transactionFetchTotalPrice(transaction: transaction){
                (totalprice, error) in
                
                if let error = error {
                    print("Error Fetch Price : \(error.localizedDescription)")
                } else {
                    totalPrice = Double(totalprice)
                }
            }
        }
        
        return totalPrice
    }
}
