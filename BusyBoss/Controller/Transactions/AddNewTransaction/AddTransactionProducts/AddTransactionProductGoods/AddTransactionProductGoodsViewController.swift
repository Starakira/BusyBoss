//
//  ProductListBarangViewController.swift
//  Busy Boss
//
//  Created by Ryan Anslyno Khohari on 27/10/20.
//

import UIKit

protocol ProductGoodsDismiss {
    func performDismissal (checkProduct: Product)
}

class AddTransactionProductGoodsViewController: UIViewController {
    
    let decimalFormatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var checkProduct: Product?
    
    var products : [Product] = []
    var index = -1
    
    var passProductDelegate: ProductsConform?
    
    @IBOutlet weak var goodsProductListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goodsProductListTableView.dataSource = self
        goodsProductListTableView.delegate = self
        
        CloudKitManager.shared().productsFetchAll {
            (products, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                for product in products {
                    if product.type.rawValue == "goods"{
                        self.products.append(product)
                        self.goodsProductListTableView.reloadData()
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddTransactionProductGoodsDetailsViewContoller{
            vc.product = products[index]
            vc.productListDelegate = self
        }
    }
}

extension AddTransactionProductGoodsViewController: ProductGoodsDismiss {
    func performDismissal(checkProduct: Product) {
        
        self.checkProduct = checkProduct
        if self.checkProduct != nil {
            passProductDelegate?.productListPassData(product: self.checkProduct!)
        }
        
        dismiss(animated: true)
    }
}

extension AddTransactionProductGoodsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "AddGoodDetailsSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension AddTransactionProductGoodsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if products.count == 0 {
            tableView.setEmptyView(title: "It's empty!", message: "You can add new product \n from the \"Products\" tab")
        }
        else {
            tableView.restore()
        }
        
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListBarangViewCell", for: indexPath)as!AddTransactionProductGoodsTableViewCell
        let product = products[indexPath.row]
        cell.goodNameLabel.text = product.name
        cell.goodStockLabel.text = String(product.stock ?? 0)
        cell.productPriceLabel.text = "Rp \(decimalFormatter.string(for: product.price) ?? "0")"
        cell.goodImageView.image = product.image?.withRoundedCorners(radius: 50)
        return cell
    }
}
