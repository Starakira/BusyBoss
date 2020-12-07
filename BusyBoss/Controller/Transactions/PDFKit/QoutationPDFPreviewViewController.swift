//
//  QoutationPDFPreviewViewController.swift
//  BusyBoss
//
//  Created by Andre Marines ado Tena Uak on 30/11/20.
//

import UIKit
import PDFKit

class QoutationPDFPreviewViewController: UIViewController {
    
    @IBOutlet weak var pdfView : PDFView!
    @IBOutlet weak var BtnApprove: UIButton!
    @IBOutlet weak var BtnReject: UIButton!
    
    public var documentData: Data?
    var transaction : Transaction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = documentData {
            pdfView.document = PDFDocument(data: data)
            pdfView.autoScales = true
        }
        
        BtnReject.layer.borderWidth = 4
        BtnReject.layer.borderColor = UIColor.systemRed.cgColor
        
    }
    @IBAction func BtnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func BtnShare() {
        if let data = documentData {
            let vc = UIActivityViewController(activityItems: [data], applicationActivities: [])
            present(vc, animated: true, completion: nil)
        }
    }

    @IBAction func BtnApprove(_ sender: Any) {
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let vc = segue.destination as? InvoicePDFPreviewViewController else {
                return
            }
            vc.value = 1
            print(vc.value)
        }
        
    }
    
    @IBAction func BtnReject(_ sender: Any) {
    }
}
