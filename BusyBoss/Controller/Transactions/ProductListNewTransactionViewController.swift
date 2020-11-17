//
//  productListNewTransactionViewController.swift
//  Busy Boss
//
//  Created by Ryan Anslyno Khohari on 27/10/20.
//

import UIKit

protocol ClientsConform {
    func clientListPassData(client: Client)
}

protocol ProductsConform {
    func productListPassData(product: Product)
}

class ProductListNewTransactionViewController: UIViewController, ClientsConform, ProductsConform {
    
    func clientListPassData(client: Client) {
        self.client = client
        self.clientTextField.text = client.firstName + client.lastName
    }
    
    func productListPassData(product: Product) {
        self.products.append(product)
        ProductListNewTransaction.reloadData()
    }
    
    @IBOutlet weak var clientTextField: UITextField!
    
    @IBOutlet weak var ProductListNewTransaction: UITableView!
    
    var client: Client?
    var clientIndex = -1
    
    var products: [Product] = []
    var productIndex = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProductListNewTransaction.dataSource = self
        ProductListNewTransaction.delegate = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ClientContactViewController {
            vc.clientsListDelegate = self
        }
        
        if let vc = segue.destination as? AddGoodDetailsViewController {
            vc.productListDelegate = self
        }
        
        if let vc = segue.destination as? AddServiceDetailsViewController {
            vc.productListDelegate = self
        }
    }
}

extension ProductListNewTransactionViewController: UITableViewDelegate{
    
}

extension ProductListNewTransactionViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productListNewViewCell", for: indexPath)as!ProductListNewTransactionViewCell
        let product = products[indexPath.row]
        cell.NameProductNewTransaction.text = product.name
        cell.StockNewTransaction.text = String(product.quantity)
        cell.JumlahHargaNewTransaction.text = String(product.price)
        cell.GambarProductNewTransaction.image = product.image
        return cell
    }
}
