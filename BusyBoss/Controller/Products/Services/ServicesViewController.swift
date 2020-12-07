//
//  ServicesViewController.swift
//  Busy Boss
//
//  Created by richard santoso on 27/10/20.
//

import UIKit

class ServicesViewController: UIViewController{
    
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
                Alert.showCloudKitError(self, error)
                
            }
            else {
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
        let vc = storyboard?.instantiateViewController(identifier: "servicesDetails") as! ServicesDetailsViewController
        vc.product = products[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ServicesViewController: UITableViewDataSource {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "servicesCell", for: indexPath)as!ServicesTableViewCell
        let product = products[indexPath.row]
        cell.servicesLabel.text = product.name
        cell.servicesPrice.text = "Rp \(decimalFormatter.string(for: product.price) ?? "0")"
        return cell
    }
}
