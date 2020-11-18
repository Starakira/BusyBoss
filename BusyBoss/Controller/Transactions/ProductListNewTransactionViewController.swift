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
        productListNewTransaction.reloadData()
    }
    
    @IBOutlet weak var clientTextField: UITextField!
    
    @IBOutlet weak var productListNewTransaction: UITableView!
    
    @IBOutlet weak var disountSwitch: UISwitch!
    
    @IBOutlet weak var taxSwitch: UISwitch!
    
    @IBOutlet weak var discountTextField: UITextField!
    
    @IBOutlet weak var validityDateTextField: UITextField!
    
    @IBOutlet weak var totalProductPriceLabel: UILabel!
    
    @IBOutlet weak var totalTaxLabel: UILabel!
    
    @IBOutlet weak var totalTransactionValueLabel: UILabel!
    
    var client: Client?
    var clientIndex = -1
    
    var products: [Product] = []
    var productIndex = -1
    
    var totalProductPrice = 1000000000.0
    var discount = 0.0
    var tax = 0.0
    var totalPrice = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        totalProductPriceLabel.text = String(totalProductPrice)
        
        discountTextField.isHidden = true
        
        totalTaxLabel.isHidden = true
        
        getTotalPrice()
        
        discountTextField.delegate = self
        
        productListNewTransaction.dataSource = self
        productListNewTransaction.delegate = self
    }
    
    @IBAction func discountSwitchAction(_ sender: Any) {
        if disountSwitch.isOn {
            discountTextField.isHidden = false
        } else {
            discountTextField.isHidden = true
            
            discount = 0.0
            getTotalPrice()
        }
    }
    
    @IBAction func taxSwitchAction(_ sender: Any) {
        if taxSwitch.isOn {
            totalTaxLabel.isHidden = false
            tax = totalProductPrice-(totalProductPrice*0.1)
            totalTaxLabel.text = String(tax)
            
            getTotalPrice()
        } else {
            totalTaxLabel.isHidden = true
            tax = 0.0
            
            getTotalPrice()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ClientContactViewController {
            vc.clientsListDelegate = self
        } else if let vc = segue.destination as? ListProductBarangJasaNewTransactionViewController {
            vc.myDelegate = self
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func getTotalPrice(){
        totalPrice = totalProductPrice - discount - tax
        totalTransactionValueLabel.text = String(totalPrice)
    }
}

extension ProductListNewTransactionViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == discountTextField {
            discount = Double(textField.text ?? "0.0") ?? 0.0
            
            getTotalPrice()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
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
