//
//  QoutationPDFPreviewViewController.swift
//  BusyBoss
//
//  Created by Andre Marines ado Tena Uak on 30/11/20.
//

import UIKit
import PDFKit

class QoutationPDFPreviewViewController: UIViewController {
    @IBOutlet weak var savedataview: UIView!
    
    @IBOutlet weak var pdfView : PDFView!
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
    
    public var documentData: Data?
    var client: Client?
    
    var clientName = String()
    var transactionTitle = String()
    var validDate = String()
    var total = String()
    var discount = String()
    var tax = String()
    var grandTotal = String()
    var logo = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        savedataview.isHidden = true
        
        labelclientname.text = clientName
        labelclientcompany.text = client?.companyName
        labelclientphone.text = client?.phoneNumber
        labelclientaddress.text = client?.companyAddress
        labelclientemail.text = client?.emailAddress
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
    
    @IBAction func BtnShare() {
        guard
            let clientname = labelclientname,
            let clientphone = labelclientphone,
            let clientaddress = labelclientaddress,
            let clientcompany = labelclientcompany,
            let clientemail = labelclientemail,
            let datatotalvalue = labeltotal,
            let datatax = labeltax,
            let datadiscount = labeldiscount,
            let datagrandtotal = labelgrandtotal,
            let datavaliddate = labelvaliddate,
            let datatitletransaction = labeltitle
            else {
                return }
        let pdfCreator = CreateQuotationPDF(
            tax: datatax,
            clientname: clientname,
            clientphone: clientphone,
            clientemail: client?.emailAddress ?? "No Email",
            clientaddress: client?.companyAddress ?? "No Address",
            title: datatitletransaction,
            total: datatotalvalue,
            grandtotal: datagrandtotal,
            discount: datadiscount,
            clientcompany: client?.companyName ?? "No Company",
            date : datavaliddate
        )
        let pdfData = pdfCreator.createFlyer()
        let vc = UIActivityViewController(activityItems: [pdfData], applicationActivities: [])
        present(vc, animated: true, completion: nil)
    }

}
