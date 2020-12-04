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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let data = documentData {
          pdfView.document = PDFDocument(data: data)
          pdfView.autoScales = true
        }
    }
    
    @IBAction func BtnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func BtnShare(_ sender: Any) {
        
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
