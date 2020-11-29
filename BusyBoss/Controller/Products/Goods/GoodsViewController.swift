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
        
        let pendingAction = Alert.displayPendingAlert(title: "Loading products...")
        
        self.present(pendingAction, animated: true){
            CloudKitManager.shared().productsFetchAll {
                (products, error) in
                if let error = error {
                    pendingAction.dismiss(animated: true){
                        Alert.showCloudKitError(self, error)
                    }
                }
                else {
                    pendingAction.dismiss(animated: true){
                        for product in products {
                            if product.type.rawValue == "goods"{
                                self.products.append(product)
                                self.goodsTableView.reloadData()
                                print(self.products)
                            }
                        }
                    }
                }
            }
        }
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
        if products.count == 0 {
            tableView.setEmptyView(title: "It's empty!", message: "Add your new Product \n by clicking \"+\" button")
        }
        else {
            tableView.restore()
        }
        
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
