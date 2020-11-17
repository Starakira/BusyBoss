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
        
        TableBarangProductList.dataSource = self
        TableBarangProductList.delegate = self
        
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
                        self.TableBarangProductList.reloadData()
                        print(self.products)
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddGoodDetailsViewController{
            vc.product = products[index]
        }
    }
}

extension ProductListBarangViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
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
