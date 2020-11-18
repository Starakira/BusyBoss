//
//  ServicesViewController.swift
//  Busy Boss
//
//  Created by richard santoso on 27/10/20.
//

import UIKit

class ServicesViewController: UIViewController {
    
    @IBOutlet weak var servicesTableView: UITableView!
    
    var products : [Product] = []
    var index = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        servicesTableView.delegate = self
        servicesTableView.dataSource = self
        
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
                        self.servicesTableView.reloadData()
                        print(self.products)
                    }
                }
            }
        }
    }
}

extension ServicesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ServicesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "servicesCell", for: indexPath)as!ServicesTableViewCell
               let product = products[indexPath.row]
               cell.servicesLabel.text = product.name
               cell.servicesPrice.text = String(product.price)
               return cell
    }
}
