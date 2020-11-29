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

class AddTransactionProductServicesViewController: UIViewController {
    
    let decimalFormatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var checkProduct: Product?
    
    var passProductDelegate: ProductsConform?
    
    var products : [Product] = []
    var index = -1
    
    @IBOutlet weak var servicesProductListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        servicesProductListTableView.dataSource = self
        servicesProductListTableView.delegate = self
        
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
                            if product.type.rawValue == "services"{
                                self.products.append(product)
                                self.servicesProductListTableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddTransactionProductServicesDetailsViewController{
            vc.product = products[index]
            vc.productListDelegate = self
        }
    }
}

extension AddTransactionProductServicesViewController: ProductServicesDismiss{
    func performDismissal(checkProduct: Product) {
        dismiss(animated: true, completion: nil)
        self.checkProduct = checkProduct
        if self.checkProduct != nil {
            passProductDelegate?.productListPassData(product: self.checkProduct!)
        }
    }
}

extension AddTransactionProductServicesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "AddServiceDetailsSegue", sender: self)
    }
}

extension AddTransactionProductServicesViewController: UITableViewDataSource {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListJasaViewCell", for: indexPath)as!AddNewTransactionProductServicesTableViewCell
        let product = products[indexPath.row]
        cell.NameJasaLabel.text = product.name
        cell.TotalHargaLabel.text = "Rp \(decimalFormatter.string(for: product.price) ?? "0")"
        return cell
    }
}
