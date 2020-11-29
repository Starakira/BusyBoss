//
//  AddGoodDetailsViewController.swift
//  BusyBoss
//
//  Created by Muhammad Bangun Agung on 16/11/20.
//

import UIKit

class AddTransactionProductGoodsDetailsViewContoller: UIViewController {
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    @IBOutlet weak var productImageLabel: UIImageView!
    
    let decimalFormatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var product: Product?
    
    var productListDelegate: ProductGoodsDismiss?
    
    var productQuantity: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productImageLabel.image = product?.image
        productNameLabel.text = product?.name
        productPriceLabel.text = "Rp \(decimalFormatter.string(for: product?.price) ?? "0")"
        productQuantityLabel.text = String(productQuantity)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @IBAction func plusQuantityButtonAction(_ sender: Any) {
        productQuantity += 1
        productQuantityLabel.text = String(productQuantity)
    }
    
    @IBAction func minusQuantityButtonAction(_ sender: Any) {
        productQuantity -= 1
        productQuantityLabel.text = String(productQuantity)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        product?.transactionQuantity = productQuantity
        self.dismiss(animated: true, completion: nil)
        productListDelegate?.performDismissal(checkProduct: product!)
        //self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        
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
