//
//  ProductListBarangViewController.swift
//  Busy Boss
//
//  Created by Ryan Anslyno Khohari on 27/10/20.
//

import UIKit

class ProductListBarangViewController: UIViewController {
    
    var products : [Product] = []
    var index = -1
    
    @IBOutlet weak var TableBarangProductList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("View loaded")
        
        TableBarangProductList.dataSource = self
        TableBarangProductList.delegate = self
        
        CloudKitManager.shared().productsFetchAll {
            (products, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                print("Fetching client successful")
                print("Products = \(products.count)")
                self.products = products
                self.TableBarangProductList.reloadData()
            }
        }
    }
}

extension ProductListBarangViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "AddGoodDetailsSegue", sender: self)
    }
}

extension ProductListBarangViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListBarangViewCell", for: indexPath)as!ProductListBarangViewCell
        let product = products[indexPath.row]
        cell.NamaBarangLabel.text = product.name
        cell.JumlahStockBarang.text = String(product.quantity)
        cell.TotalHargaLabel.text = String(product.price)
        cell.GambarBarang.image = product.image
        return cell
    }
}
