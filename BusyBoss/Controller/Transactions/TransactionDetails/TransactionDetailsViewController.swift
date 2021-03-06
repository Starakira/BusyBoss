//
//  TransactionDetailViewController.swift
//  BusyBoss
//
//  Created by Muhammad Bangun Agung on 04/11/20.
//

import UIKit

class TransactionDetailsViewController: UIViewController{
    
    @IBOutlet weak var transactionNumberLabel: UILabel!
    @IBOutlet weak var NameUserTransaction: UILabel!
    @IBOutlet weak var transactionProductsTotalPriceLabel: UILabel!
    @IBOutlet weak var transactionDiscountLabel: UILabel!
    @IBOutlet weak var transactionTaxLabel: UILabel!
    @IBOutlet weak var transactionTotalValueLabel: UILabel!
    @IBOutlet weak var DateTransaction: UILabel!
    @IBOutlet weak var Invoice: UIButton!
    @IBOutlet weak var Receipt: UIButton!
    
    
    @IBOutlet weak var productListTransactionTableView: UITableView!
    
    var transaction : Transaction?
    var client: Client?
    
    var totalProductPrice: Double = 0

    var value = Int()
    public var documentData: Data?
    
    let decimalFormatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    let dateFormatter : DateFormatter = {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy"
        return dateFormat
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        productListTransactionTableView.tableFooterView = UIView()
        
        productListTransactionTableView.dataSource = self
        productListTransactionTableView.delegate = self
        
        for product in transaction?.products ?? [] {
            totalProductPrice += Double(product.price) * Double( product.transactionQuantity ?? 0)
        }
        
        self.client = transaction?.client

        self.NameUserTransaction.text = (self.client?.firstName ?? "") + " " + (self.client?.lastName ?? "")
        transactionNumberLabel.text = transaction?.transactionNumber
        transactionProductsTotalPriceLabel.text = "Rp \(decimalFormatter.string(for: totalProductPrice) ?? "0")"
        transactionDiscountLabel.text = "Rp \(decimalFormatter.string(for: transaction?.discount) ?? "0")"
        transactionTaxLabel.text = "Rp \(decimalFormatter.string(for: transaction?.tax) ?? "0")"
        transactionTotalValueLabel.text = "Rp \(decimalFormatter.string(for: transaction?.value) ?? "0")"
        DateTransaction.text = dateFormatter.string(from: transaction?.validityDate ?? Date())
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "previewSegue" {
            guard let vc = segue.destination as? QoutationPDFPreviewViewController else { return }
            
                if
                    let ClientName = NameUserTransaction.text,
                    let PriceTotal = transactionProductsTotalPriceLabel.text,
                    let Discount = transactionDiscountLabel.text,
                    let Tax = transactionTaxLabel.text,
                    let GrandTotal = transactionTotalValueLabel.text,
                    let Date = DateTransaction.text,
                    let TitleNumber = transactionNumberLabel.text
                
                    {
                    let pdfCreator = CreateQuotation2(
                        tax: Tax,
                        clientname: ClientName,
                        clientphone: client?.phoneNumber ?? "No Number",
                        clientemail: client?.emailAddress ?? "No Email",
                        clientaddress: client?.companyAddress ?? "No Address",
                        title: TitleNumber,
                        total: PriceTotal,
                        grandtotal: GrandTotal,
                        discount: Discount,
                        clientcompany: client?.companyName ?? "No Company",
                        date : Date)
                    
                    vc.documentData = pdfCreator.createFlyer(products: (self.transaction?.products)!)
                    }
                
            }
        if segue.identifier == "previewSegue2" {
            guard let vc = segue.destination as? InvoicePDFPreviewViewController else { return }
                if let ClientName = NameUserTransaction.text,
                    let PriceTotal = transactionProductsTotalPriceLabel.text,
                    let Discount = transactionDiscountLabel.text,
                    let Tax = transactionTaxLabel.text,
                    let GrandTotal = transactionTotalValueLabel.text,
                    let Date = DateTransaction.text,
                    let TitleNumber = transactionNumberLabel.text
                
                    {
                    let pdfCreator = CreateInvoicePDF(
                        tax: Tax,
                        clientname: ClientName,
                        clientphone: client?.phoneNumber ?? "No Number",
                        clientemail: client?.emailAddress ?? "No Email",
                        clientaddress: client?.companyAddress ?? "No Address",
                        title: TitleNumber,
                        total: PriceTotal,
                        grandtotal: GrandTotal,
                        discount: Discount,
                        clientcompany: client?.companyName ?? "No Company",
                        date : Date)
                    
                    vc.documentData = pdfCreator.createFlyer(products: self.transaction?.products)
                    }
            }
        if segue.identifier == "previewSegue3" {
            guard let vc = segue.destination as? ReceiptPDFPreviewViewController else { return }
            
                if
                    let ClientName = NameUserTransaction.text,
                    let PriceTotal = transactionProductsTotalPriceLabel.text,
                    let Discount = transactionDiscountLabel.text,
                    let Tax = transactionTaxLabel.text,
                    let GrandTotal = transactionTotalValueLabel.text,
                    let Date = DateTransaction.text,
                    let TitleNumber = transactionNumberLabel.text
                
                    {
                    let pdfCreator = CreateReceiptPDF(
                        tax: Tax,
                        clientname: ClientName,
                        clientphone: client?.phoneNumber ?? "No Number",
                        clientemail: client?.emailAddress ?? "No Email",
                        clientaddress: client?.companyAddress ?? "No Address",
                        title: TitleNumber,
                        total: PriceTotal,
                        grandtotal: GrandTotal,
                        discount: Discount,
                        clientcompany: client?.companyName ?? "No Company",
                        date : Date)
                    
                    vc.documentData = pdfCreator.createFlyer(products: self.transaction?.products)
                    }
            }
        }
    @IBAction func BtnQuotation(_ sender: Any) {
    }
    
    @IBAction func BtnInvoice(_ sender: Any) {
        print(value)
        if value == 1 {
            Invoice.isEnabled = true
            value = 0
        }
    }
    
    @IBAction func BtnReceipt(_ sender: Any) {
        
        if value == 1 {
            Invoice.isEnabled = true
        }
    }
}

extension TransactionDetailsViewController: UITableViewDelegate{
    
}

extension TransactionDetailsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transaction?.products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = transaction?.products?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "productListNewViewCell", for: indexPath) as! AddNewTransactionTableViewCell
        
        cell.selectionStyle = .none
        cell.isUserInteractionEnabled = false
        
        cell.productNameLabel.text = product?.name
        cell.productPriceLabel.text = "Rp. \(decimalFormatter.string(for: product?.price) ?? "0")"
        cell.productImage.image = product?.image?.withRoundedCorners(radius: 50)
        
        cell.setProductQuantity(transaction: transaction!, product: product)
        
        return cell
    }
}
