//
//  PreviewQuotationViewController.swift
//  BusyBoss
//
//  Created by Andre Marines ado Tena Uak on 19/11/20.
//

import UIKit
import PDFKit

class PreviewQuotationViewController: UIViewController {
    
    @IBOutlet weak var pdfView : PDFView!
    
    public var documentData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let data = documentData {
          pdfView.document = PDFDocument(data: data)
          pdfView.autoScales = true
        }
    }
}
