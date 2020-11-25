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

class AddTransactionProductGoodsViewController: UIViewController, ProductGoodsDismiss {
    func performDismissal(checkProduct: Product) {
        dismiss(animated: true, completion: nil)
        self.checkProduct = checkProduct
        if self.checkProduct != nil {
            passProductDelegate?.productListPassData(product: self.checkProduct!)
        }
    }
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
                print("Fetching products successful")
                print("Products = \(products.count)")
                
                for product in products {
                    print(product.type.rawValue)
                    if product.type.rawValue == "goods"{
                        self.products.append(product)
                        self.goodsProductListTableView.reloadData()
                        print(self.products)
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

extension AddTransactionProductGoodsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "AddGoodDetailsSegue", sender: self)
    }
}

extension AddTransactionProductGoodsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListBarangViewCell", for: indexPath)as!AddTransactionProductGoodsTableViewCell
        let product = products[indexPath.row]
        cell.NamaBarangLabel.text = product.name
        cell.JumlahStockBarang.text = String(product.stock ?? 0)
        cell.TotalHargaLabel.text = String(product.price)
        cell.GambarBarang.image = product.image
        return cell
    }
}
