//
//  GoodsViewController.swift
//  Busy Boss
//
//  Created by richard santoso on 27/10/20.
//

import UIKit

class GoodsViewController: UIViewController {

    @IBOutlet weak var goodsTableView: UITableView!
    
    let decimalFormatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var products : [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goodsTableView.tableFooterView = UIView()
        
        goodsTableView.dataSource = self
        goodsTableView.delegate = self
        
        CloudKitManager.shared().productsFetchAll {
            (products, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                print("Fetching products successful")
                print("Products = \(products.count)")
                
                for product in products {
                    print(product.type.rawValue)
                    if product.type.rawValue == "goods"{
                        self.products.append(product)
                        self.goodsTableView.reloadData()
                        print(self.products)
                    }
                }
            }
        }
        
        print(products)
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
        cell.goodsPrice.text = "Rp \(decimalFormatter.string(for: product.price) ?? "0")"
        cell.goodsStock.text = "\(decimalFormatter.string(for: product.stock) ?? "0") \(product.unit ?? "")"
        return cell
    }
}
