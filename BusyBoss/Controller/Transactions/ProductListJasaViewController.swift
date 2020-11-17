//
//  ProductListJasaViewController.swift
//  Busy Boss
//
//  Created by Ryan Anslyno Khohari on 27/10/20.
//

import UIKit

class ProductListJasaViewController: UIViewController {
    
    var products : [Product] = []
    var index = -1
    
    @IBOutlet weak var TableJasaProductList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableJasaProductList.dataSource = self
        TableJasaProductList.delegate = self
        
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
                        self.TableJasaProductList.reloadData()
                        print(self.products)
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddServiceDetailsViewController{
            vc.product = products[index]
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
