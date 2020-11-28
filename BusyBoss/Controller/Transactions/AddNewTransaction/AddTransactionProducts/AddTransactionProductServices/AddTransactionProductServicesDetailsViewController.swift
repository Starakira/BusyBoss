//
//  AddServiceDetailsViewController.swift
//  BusyBoss
//
//  Created by Muhammad Bangun Agung on 16/11/20.
//

import UIKit

class AddTransactionProductServicesDetailsViewController: UIViewController {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    var product: Product?
    
    var productListDelegate: ProductServicesDismiss?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productNameLabel.text = product?.name
        productPriceLabel.text = String(product?.price ?? 0.0)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        productListDelegate?.performDismissal(checkProduct: product!)
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
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
