//
//  GoodsViewController.swift
//  Busy Boss
//
//  Created by richard santoso on 27/10/20.
//

import UIKit

class GoodsViewController: UIViewController {

    @IBOutlet weak var goodsTableView: UITableView!
    var products : [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goodsTableView.dataSource = self
        goodsTableView.delegate = self
        
    }
}

extension GoodsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "goodsDetails") as! GoodsDetailsViewController
        vc.product = products[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension GoodsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "goodsCell", for: indexPath)as!GoodsTableViewCell
        let product = products[indexPath.row]
        cell.goodsLabel.text = product.name
        cell.goodsImage.image = product.image
        cell.goodsPrice.text = String(product.price)
        cell.goodsStock.text = String(product.stock ?? 0) + " " + (product.unit ?? "0")
        return cell
    }
}
