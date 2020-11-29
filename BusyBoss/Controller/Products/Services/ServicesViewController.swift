//
//  ServicesViewController.swift
//  Busy Boss
//
//  Created by richard santoso on 27/10/20.
//

import UIKit

class ServicesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var servicesTableView: UITableView!
    
    let decimalFormatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var products : [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        servicesTableView.tableFooterView = UIView()
        
        servicesTableView.dataSource = self
        servicesTableView.delegate = self
        
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "servicesCell", for: indexPath)as!ServicesTableViewCell
               let product = products[indexPath.row]
        cell.servicesLabel.text = product.name
        cell.servicesPrice.text = "Rp \(decimalFormatter.string(for: product.price) ?? "0")"
               return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "servicesDetails") as! ServicesDetailsViewController
        vc.product = products[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
