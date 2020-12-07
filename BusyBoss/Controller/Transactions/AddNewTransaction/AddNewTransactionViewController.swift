//
//  productListNewTransactionViewController.swift
//  Busy Boss
//
//  Created by Ryan Anslyno Khohari on 27/10/20.
//

import UIKit
import CloudKit

protocol ClientsConform {
    func clientListPassData(client: Client)
}

protocol ProductsConform {
    func productListPassData(product: Product)
}

class AddNewTransactionViewController: UIViewController {
    
    @IBOutlet weak var clientTextField: UITextField!
    
    @IBOutlet weak var productListNewTransactionTableView: UITableView!
    
    @IBOutlet weak var disountSwitch: UISwitch!
    
    @IBOutlet weak var taxSwitch: UISwitch!
    
    @IBOutlet weak var transactionNumberTextField: UITextField!
    
    @IBOutlet weak var transactionDescriptionTextField: UITextField!
    
    @IBOutlet weak var discountTextField: UITextField!
    
    @IBOutlet weak var validityDateTextField: UITextField!
    
    @IBOutlet weak var totalProductsPriceLabel: UILabel!
    
    @IBOutlet weak var totalTaxLabel: UILabel!
    
    @IBOutlet weak var totalTransactionValueLabel: UILabel!
    
    var transaction: Transaction?
    
    var transactionNumber = ""
    
    var transactionDescription = ""
    
    var client: Client?
    var clientIndex = -1
    
    var products: [Product] = []
    var productIndex = -1
    
    let decimalFormatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var totalProductPrice = 0.0
    var discount = 0.0
    var tax = 0.0
    var totalValue = 0.0
    
    let dateFormatter : DateFormatter = {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy"
        return dateFormat
    }()
    
    var validityDate : Date?
    
    var transactionDelegate: TransactionConform?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalProductsPriceLabel.text = "Rp " + decimalFormatter.string(for: totalProductPrice)!
        
        discountTextField.isHidden = true
        
        totalTaxLabel.isHidden = true
        
        getTotalValue()
        
        validityDate = Date()
        validityDateTextField.text = dateFormatter.string(from: validityDate ?? Date())
        
        transactionNumberTextField.delegate = self
        transactionDescriptionTextField.delegate = self
        
        discountTextField.delegate = self
        validityDateTextField.delegate = self
        
        productListNewTransactionTableView.tableFooterView = UIView()
        
        productListNewTransactionTableView.dataSource = self
        productListNewTransactionTableView.delegate = self
    }
    
    @IBAction func discountSwitchAction(_ sender: Any) {
        if disountSwitch.isOn {
            discountTextField.isHidden = false
            
            getTotalValue()
        } else {
            discountTextField.isHidden = true
            discountTextField.text = ""
            
            discount = 0.0
            
            getTax()
            getTotalValue()
        }
    }
    
    @IBAction func taxSwitchAction(_ sender: Any) {
        if taxSwitch.isOn {
            totalTaxLabel.isHidden = false
            
            getTax()
            getTotalValue()
        } else {
            totalTaxLabel.isHidden = true
            
            tax = 0.0
            getTotalValue()
        }
    }
    
    @IBAction func newTransactionSaveButtonAction(_ sender: Any) {
        
        transaction = Transaction(transactionNumber: transactionNumber, description: transactionDescription, status: TransactionStatus.ongoing, approval: TransactionApproval.pending, products: products, client: client, validityDate: validityDate ?? Date(), discount: discount, tax: tax, value: totalValue)
        
        transaction?.clientReference = CKRecord.Reference(recordID: (client?.recordID)!, action: CKRecord_Reference_Action.none)
        
        let pendingAction = Alert.displayPendingAlert(title: "Saving new transaction to Database...")
        self.present(pendingAction, animated: true) {
            CloudKitManager.shared().transactionCreate(transaction: self.transaction!) {
                (recordID, error) in
                if let error = error {
                    pendingAction.dismiss(animated: true) {
                        Alert.showAlert(view: self, title: "Error creating transaction", message: CloudKitError.getUserFriendlyDescription(error: error))
                    }
                    
                    return
                }
                if recordID == nil {
                    print("ID not created!")
                }
                else {
                    self.transaction?.recordID = recordID
                    CloudKitManager.shared().transactionAddRecordProducts(transaction: self.transaction!) { (error) in
                        self.transactionDelegate?.transactionSave(transaction: self.transaction!)
                        pendingAction.dismiss(animated: true) {
                            self.dismiss(animated: true)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddNewTransactionClientViewController {
            vc.clientsListDelegate = self
        } else if let vc = segue.destination as? AddTransactionProductsViewController {
            vc.myDelegate = self
        }
    }
    
    func getTax() {
        if taxSwitch.isOn {
            tax = (totalProductPrice - discount) * 0.1
            totalTaxLabel.text = "Rp \(decimalFormatter.string(for: tax) ?? "0")"
        } else {
            tax = 0.0
        }
    }
    
    func getTotalValue(){
        totalValue = totalProductPrice - discount + tax
        totalTransactionValueLabel.text = "Rp " + decimalFormatter.string(for: totalValue)!
    }
}

extension AddNewTransactionViewController: ClientsConform {
    func clientListPassData(client: Client) {
        self.client = client
        self.clientTextField.text = client.firstName + client.lastName
    }
}

extension AddNewTransactionViewController: ProductsConform {
    func productListPassData(product: Product) {
        self.products.append(product)
        totalProductPrice += product.price * Double(product.transactionQuantity ?? 0)
        totalProductsPriceLabel.text = "Rp " + decimalFormatter.string(for: totalProductPrice)!
        getTax()
        getTotalValue()
        
        productListNewTransactionTableView.reloadData()
    }
}

extension AddNewTransactionViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == transactionNumberTextField {
            transactionNumber = transactionNumberTextField.text ?? ""
        } else if textField == transactionDescriptionTextField {
            transactionDescription = transactionDescriptionTextField.text ?? ""
        }
        else if textField == discountTextField {
            discount = Double(textField.text ?? "0.0") ?? 0.0
            getTax()
            getTotalValue()
        } else if textField == validityDateTextField {
            validityDate = dateFormatter.date(from: textField.text ?? "00/00/0000")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension AddNewTransactionViewController: UITableViewDelegate{
    
}

extension AddNewTransactionViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = products[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productListNewViewCell", for: indexPath)as!AddNewTransactionTableViewCell
        
        cell.productNameLabel.text = product.name
        cell.transactionProductQuantityLabel.text = String(product.transactionQuantity ?? 0)
        cell.productPriceLabel.text = String(product.price)
        
        cell.productImage.image = product.image
        return cell
    }
}
