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
    @IBOutlet weak var BtnReject: UIButton!
    
    public var documentData: Data?
    var transaction : Transaction?
    var value = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        BtnReject.layer.borderWidth = 4
        BtnReject.layer.borderColor = UIColor.systemRed.cgColor
    
        if let data = documentData {
          pdfView.document = PDFDocument(data: data)
          pdfView.autoScales = true
        }
    }
    
    @IBAction func BtnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func BtnShare(_ sender: Any) {
        if let data = documentData {
            let vc = UIActivityViewController(activityItems: [data], applicationActivities: [])
            present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func BtnPaid(_ sender: Any) {
     
    }
    
    @IBAction func BtnReject(_ sender: Any) {
        
    }
}
