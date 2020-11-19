//
//  PreviewInvoiceViewController.swift
//  BusyBoss
//
//  Created by Andre Marines ado Tena Uak on 16/11/20.
//

import UIKit
import PDFKit

class PreviewInvoiceViewController: UIViewController {
    
    @IBOutlet weak var pdfView : PDFView!
    
    public var documentData: Data?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let data = documentData {
          pdfView.document = PDFDocument(data: data)
          pdfView.autoScales = true
        }
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


