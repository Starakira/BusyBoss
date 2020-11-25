//
//  GoodsDetailsViewController.swift
//  Busy Boss
//
//  Created by richard santoso on 27/10/20.
//

import UIKit

class GoodsDetailsViewController: UIViewController {
    
    @IBOutlet weak var goodsDetailsImage: UIImageView!
    @IBOutlet weak var goodsDetailsLabel: UILabel!
    @IBOutlet weak var goodsDetailsPrice: UILabel!
    @IBOutlet weak var goodsDetailsStock: UILabel!
    @IBOutlet weak var goodsDetailsUnit: UILabel!
    @IBOutlet weak var goodsDetailsDescription: UILabel!
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let product = product {
            goodsDetailsLabel.text = product.name
            goodsDetailsImage.image = product.image
            goodsDetailsPrice.text = String(product.price)
            goodsDetailsStock.text = String(product.stock ?? 0)
            goodsDetailsUnit.text = product.unit
            goodsDetailsDescription.text = product.description
        }
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
