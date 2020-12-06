//
//  InvoicePDFPreviewViewController.swift
//  BusyBoss
//
//  Created by Andre Marines ado Tena Uak on 30/11/20.
//

import UIKit
import PDFKit

class InvoicePDFPreviewViewController: UIViewController {

    @IBOutlet weak var pdfView: PDFView!
    @IBOutlet weak var savedata: UIView!
    
    @IBOutlet weak var labelclientname: UILabel!
    @IBOutlet weak var labelclientcompany: UILabel!
    @IBOutlet weak var labelclientaddress: UILabel!
    @IBOutlet weak var labelclientphone: UILabel!
    @IBOutlet weak var labelclientemail: UILabel!
    @IBOutlet weak var labeltotal: UILabel!
    @IBOutlet weak var labeldiscount: UILabel!
    @IBOutlet weak var labeltax: UILabel!
    @IBOutlet weak var labelgrandtotal: UILabel!
    @IBOutlet weak var labelvaliddate: UILabel!
    @IBOutlet weak var labeltitle: UILabel!
    @IBOutlet weak var BtnReject: UIButton!
    
    var clientName = String()
    var clientCompany = String()
    var clientAddress = String()
    var clientPhone = String()
    var clientEmail = String()
    var transactionTitle = String()
    var validDate = String()
    var total = String()
    var discount = String()
    var tax = String()
    var grandTotal = String()
    var logo = UIImage()
    
    
    
    public var documentData: Data?
    var transaction : Transaction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        savedata.isHidden = true
        BtnReject.layer.borderWidth = 4
        BtnReject.layer.borderColor = UIColor.systemRed.cgColor
        
        labelclientname.text = clientName
        labelclientcompany.text = clientCompany
        labelclientphone.text = clientPhone
        labelclientaddress.text = clientAddress
        labelclientemail.text = clientEmail
        labeltitle.text = transactionTitle
        labeltotal.text = total
        labeltax.text = tax
        labeldiscount.text = discount
        labelgrandtotal.text = grandTotal
        labelvaliddate.text = validDate

        if let data = documentData {
          pdfView.document = PDFDocument(data: data)
          pdfView.autoScales = true
        }
    }
    
    @IBAction func BtnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func BtnShare(_ sender: Any) {
        guard
            let clientname = labelclientname.text,
            let clientphone = labelclientphone.text,
            let clientaddress = labelclientaddress.text,
            let clientcompany = labelclientcompany.text,
            let clientemail = labelclientemail.text,
            let datatotalvalue = labeltotal.text,
            let datatax = labeltax.text,
            let datadiscount = labeldiscount.text,
            let datagrandtotal = labelgrandtotal.text,
            let datavaliddate = labelvaliddate.text,
            let datatitletransaction = labeltitle.text
            else {
                return }
        let pdfCreator = CreateInvoicePDF(
            tax: datatax,
            clientname: clientname,
            clientphone: clientphone,
            clientemail: clientemail,
            clientaddress: clientaddress,
            title: datatitletransaction,
            total: datatotalvalue,
            grandtotal: datagrandtotal,
            discount: datadiscount,
            clientcompany: clientcompany,
            date: datavaliddate
        )
    
        let pdfData = pdfCreator.createFlyer(products: self.transaction?.products)
        let vc = UIActivityViewController(activityItems: [pdfData], applicationActivities: [])
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func BtnPaid(_ sender: Any) {
        let vc = TransactionDetailsViewController(nibName: "TransactionDetailsView", bundle: nil)
        vc.value = 1
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func BtnReject(_ sender: Any) {
        
    }
}
