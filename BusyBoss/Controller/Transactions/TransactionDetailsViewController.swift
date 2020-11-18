//
//  TransactionDetailViewController.swift
//  BusyBoss
//
//  Created by Muhammad Bangun Agung on 04/11/20.
//

import UIKit

class TransactionDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var TitleNameTransaction: UILabel!
    @IBOutlet weak var NameUserTransaction: UILabel!
    @IBOutlet weak var JumlahTotalHargaTransaction: UILabel!
    @IBOutlet weak var JumlahDiscountHargaTransaction: UILabel!
    @IBOutlet weak var JumlahTaxTransaction: UILabel!
    @IBOutlet weak var JumlahGrandTotalTransaction: UILabel!
    @IBOutlet weak var DateTransaction: UILabel!
    @IBOutlet weak var ProductListTransactionTableView: UITableView!
    
    @IBOutlet weak var LogoPerusahaan: UIImageView!
    
    var Dummy : [DummyDataTransaction]!

    var dummy : DummyDataTransaction?
    
    public var documentData: Data?

    override func viewDidLoad() {
        super.viewDidLoad()

        let DummyManager : DummyDataManager = DummyDataManager()
        Dummy = DummyManager.Dummy
        ProductListTransactionTableView.dataSource = self
        ProductListTransactionTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Dummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productListNewViewCell", for: indexPath)as!ProductListNewTransactionViewCell
        let Data = Dummy[indexPath.row]
        print (Data)
        cell.NameProductNewTransaction.text = Data.transactionGoodName
        cell.StockNewTransaction.text = String(Data.transactionStockNumber)
        cell.JumlahHargaNewTransaction.text = String(Data.transactionTotalValue)
        cell.GambarProductNewTransaction.image = Data.transactionImage
        return cell
    }
    
    //show PDF
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "previewSegue" {
            guard let vc = segue.destination as? PreviewQuotationViewController else { return }
    //        vc.ClientName = Titledocument.text!
    //        vc.Company = clientName.text!
    //        vc.logo = previewimage.image!
            
            LogoPerusahaan.image = UIImage(named: "BussyBoss App Icon")
            
            if let title = TitleNameTransaction.text,
               let name = NameUserTransaction.text,
               let total = JumlahTotalHargaTransaction.text,
               let discount = JumlahDiscountHargaTransaction.text,
               let tax = JumlahTaxTransaction.text,
               let grandtotal = JumlahGrandTotalTransaction.text,
               let gambar = LogoPerusahaan.image,
               let valid = DateTransaction.text

               {
            
                let pdfCreator = CreateQuotationPDF(
                    title: title,
                    name: name,
                    total: total,
                    tax: tax,
                    discount: discount,
                    validdate: valid,
                    grandtotal: grandtotal,
                    logo: gambar

                    
            )
            vc.documentData = pdfCreator.createFlyer()
            
          }
          }
            
        
            if segue.identifier == "previewSegue1" {
              guard let vc = segue.destination as? PreviewInvoiceViewController else { return }
              
              if let title = TitleNameTransaction.text,
                 let name = NameUserTransaction.text,
                 let total = JumlahTotalHargaTransaction.text,
                 let discount = JumlahDiscountHargaTransaction.text,
                 let tax = JumlahTaxTransaction.text,
                 let grandtotal = JumlahGrandTotalTransaction.text,
                 let gambar = LogoPerusahaan.image,
                 let valid = DateTransaction.text
                
    //          let gambar = previewimage.image,
    //          let jenisdokumen = jenisdokumen.text
                 {
              
                let pdfCreator = CreateInvoicePDF(
                    title: title,
                    name: name,
                    total: total,
                    tax: tax,
                    discount: discount,
                    validdate: valid,
                    grandtotal: grandtotal,
                    logo: gambar

              )
              vc.documentData = pdfCreator.createFlyer()
            }
            }
            
            if segue.identifier == "previewSegue2" {
              guard let vc = segue.destination as? PreviewReceiptViewController else { return }
              
              if let title = TitleNameTransaction.text,
                 let name = NameUserTransaction.text,
                 let total = JumlahTotalHargaTransaction.text,
                 let discount = JumlahDiscountHargaTransaction.text,
                 let tax = JumlahTaxTransaction.text,
                 let grandtotal = JumlahGrandTotalTransaction.text,
                 let gambar = LogoPerusahaan.image,
                 let valid = DateTransaction.text
              
    //          let gambar = previewimage.image,
    //          let jenisdokumen = jenisdokumen.text
                 {
              
                let pdfCreator = CreateReceiptPDF(
                    title: title,
                    name: name,
                    total: total,
                    tax: tax,
                    discount: discount,
                    validdate: valid,
                    grandtotal: grandtotal,
                    logo: gambar
                )
              vc.documentData = pdfCreator.createFlyer()
            }
            }
        }


    

}
