//
//  ProductListJasaViewController.swift
//  Busy Boss
//
//  Created by Ryan Anslyno Khohari on 27/10/20.
//

protocol ProductServicesDismiss {
    func performDismissal (checkProduct: Product)
}

import UIKit

class ProductListJasaViewController: UIViewController, ProductServicesDismiss {
    func performDismissal(checkProduct: Product) {
        dismiss(animated: true, completion: nil)
        self.checkProduct = checkProduct
        if self.checkProduct != nil {
            passProductDelegate?.productListPassData(product: self.checkProduct!)
        }
    }
    
    var checkProduct: Product?
    
    var passProductDelegate: ProductsConform?
    
    var products : [Product] = []
    var index = -1
    
    @IBOutlet weak var servicesProductListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        servicesProductListTableView.dataSource = self
        servicesProductListTableView.delegate = self
        
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
                    if product.type.rawValue == "services"{
                        self.products.append(product)
                        self.servicesProductListTableView.reloadData()
                        print(self.products)
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddServiceDetailsViewController{
            vc.product = products[index]
            vc.productListDelegate = self
        }
    }
}

extension ProductListJasaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "AddServiceDetailsSegue", sender: self)
    }
}

extension ProductListJasaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListJasaViewCell", for: indexPath)as!ProductListJasaViewCell
        let product = products[indexPath.row]
        cell.NameJasaLabel.text = product.name
        cell.TotalHargaLabel.text = String(product.price)
        return cell
    }
}
