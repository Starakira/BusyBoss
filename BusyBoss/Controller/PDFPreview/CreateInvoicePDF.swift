//
//  CreateInvoicePDF.swift
//  BusyBoss
//
//  Created by Andre Marines ado Tena Uak on 19/11/20.
//

import UIKit
import PDFKit

class CreateInvoicePDF: NSObject {
    
    let title: String
    let name: String
    let total : String
    let tax : String
    let discount : String
    let validdate : String
    let grandtotal : String
    let logo : UIImage
    
    init(title: String, name: String, total : String, tax: String, discount : String, validdate : String, grandtotal : String, logo : UIImage) {
      self.title = title
      self.name = name
        self.total = total
        self.tax = tax
        self.discount = discount
        self.validdate = validdate
        self.grandtotal = grandtotal
        self.logo = logo

}

    func createFlyer() -> Data {
        
      // 1
        let pdfMetaData = [
          kCGPDFContextCreator: "Flyer Builder",
          kCGPDFContextAuthor: "raywenderlich.com",
          kCGPDFContextTitle: title
        ]

      let format = UIGraphicsPDFRendererFormat()
      format.documentInfo = pdfMetaData as [String: Any]

      // 2
      let pageWidth = 8.5 * 72.0
      let pageHeight = 11 * 72.0
      let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)

      // 3
      let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
      // 4
      let data = renderer.pdfData { (context) in
        // 5
        context.beginPage()
        // 6
        //setting font
//        let attributes = [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 34)]
        let normalattributes = [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        let boldattributes = [ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
        let validattributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        
        
        
        //setting tulisan pasti
//        let text = "QOUTATION"
//        text.draw(at: CGPoint(x: 20, y: 40), withAttributes: attributes)
        
        let Numbertext = "Number : "
        Numbertext.draw(at: CGPoint(x: 20, y: 75), withAttributes :normalattributes)
        
        let data = "TO                            :"
        data.draw(at: CGPoint(x: 20, y: 180), withAttributes : normalattributes)
        
        let CompanyName = "Company Name      :"
        CompanyName.draw(at: CGPoint(x: 20, y: 195), withAttributes : normalattributes)
        
        let Address = "Address                   :"
        Address.draw(at: CGPoint(x: 20, y: 210), withAttributes : normalattributes)
        
        let PhoneNumber = "Phone Number        :"
        PhoneNumber.draw(at: CGPoint(x: 20, y: 225), withAttributes : normalattributes)
        
        let Email = "Email                        :"
        Email.draw(at: CGPoint(x: 20, y: 240), withAttributes : normalattributes)
        
        let TransactionTitle = "Transaction Title    :"
        TransactionTitle.draw(at: CGPoint(x: 20, y: 265), withAttributes : boldattributes)
        
        let Pages = "Pages                        :"
        Pages.draw(at: CGPoint(x: 20, y: 280), withAttributes : boldattributes)
        
        
        
        // setting tampilan table
        let Nomor = "NO"
        Nomor.draw(at: CGPoint(x: 30, y: 330), withAttributes : boldattributes)
        
        let ProductName = "Product Name"
        ProductName.draw(at: CGPoint(x: 90, y: 330), withAttributes : boldattributes)
        
        let Unit = "Unit"
        Unit.draw(at: CGPoint(x: 240, y: 330), withAttributes : boldattributes)
        
        let Qty = "Qty"
        Qty.draw(at: CGPoint(x: 320, y: 330), withAttributes : boldattributes)
        
        let UnitPrice = "Unit Price"
        UnitPrice.draw(at: CGPoint(x: 390, y: 330), withAttributes : boldattributes)
        
        let IDR1 = "(IDR)"
        IDR1.draw(at: CGPoint(x: 407, y: 350), withAttributes : boldattributes)
        
        let Amount = "Amount"
        Amount.draw(at: CGPoint(x: 500, y: 330), withAttributes : boldattributes)
        
        let IDR2 = "(IDR)"
        IDR2.draw(at: CGPoint(x: 507, y: 350), withAttributes : boldattributes)
        
        let Total = "Total"
        Total.draw(at: CGPoint(x: 400, y: 475), withAttributes : boldattributes)
        
        let Discount = "Discount"
        Discount.draw(at: CGPoint(x: 400, y: 490), withAttributes : boldattributes)
        
        let PPN = "PPN 10%"
        PPN.draw(at: CGPoint(x: 400, y: 505), withAttributes : boldattributes)
        
        let GrandTotal = "Grand Total"
        GrandTotal.draw(at: CGPoint(x: 400, y: 520), withAttributes : boldattributes)
        
        // setting terms
        let valid = "Please make your payment before : "
        valid.draw(at: CGPoint(x: 20, y: 560),withAttributes : validattributes)
        
        let Terms = "Terms and Condition :"
        Terms.draw(at: CGPoint(x: 20, y: 580), withAttributes : normalattributes)
        
        //setting tanda tangan
//        let please = "Please confirm acceptance of this quotation"
//        please.draw(at: CGPoint(x: 300, y: 640), withAttributes : normalattributes)
//
//        let please2 = "by clicking here. (ini untuk apps clips)"
//        please2.draw(at: CGPoint(x: 300, y: 655), withAttributes : normalattributes)
        
        let Sincerely = "Sincerely,"
        Sincerely.draw(at: CGPoint(x: 20, y: 665), withAttributes : boldattributes)
        
//        let Signature = "Signature    :"
//        Signature.draw(at: CGPoint(x: 300, y: 725), withAttributes : normalattributes)
//
//        let Name = "Name    :"
//        Name.draw(at: CGPoint(x: 300, y: 740), withAttributes : normalattributes)
//
//        let Position = "Signature    :"
//        Position.draw(at: CGPoint(x: 300, y: 755), withAttributes : normalattributes)
        
        //add data ke PDF
        
        let toclient = addTitle(pageRect: pageRect)
        let companyname = addName(pageRect: pageRect)
        let documentName = addDocument(pageRect: pageRect)
        let TotalHarga = addTotal(pageRect: pageRect)
        let Potongan = addDiscount(pageRect: pageRect)
        let Tax = addTax(pageRect: pageRect)
        let GrandTotalHarga = addGrandTotal(pageRect: pageRect)
        let clientcompany = addClientCompany(pageRect: pageRect)
        let clientaddress = addClientAddres(pageRect: pageRect)
        let clientphone = addCompanyContact(pageRect: pageRect)
        let clientemail = addClientEmail(pageRect: pageRect)
        let company = addCompany(pageRect: pageRect)
        let address = addCompanyAddress(pageRect: pageRect)
        let phone = addCompanyContact(pageRect: pageRect)
        let email = addCompanyEmail(pageRect: pageRect)
        let imageBottom = addImage(pageRect: pageRect)
        let terms1 = addTerms1(pageRect: pageRect)
        let terms2 = addTerms2(pageRect: pageRect)
        let terms3 = addTerms3(pageRect: pageRect)

        

        
      }

      return data
    }
    
    func addTitle(pageRect: CGRect) -> CGFloat {
      // 1
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
      // 2
      let titleAttributes: [NSAttributedString.Key: Any] =
        [NSAttributedString.Key.font: titleFont]
      // 3
      let attributedTitle = NSAttributedString(
        string: title,
        attributes: titleAttributes
      )
      // 4
      let titleStringSize = attributedTitle.size()
      // 5
      let titleStringRect = CGRect(
        x: 150,
        y: 180,
        width: titleStringSize.width,
        height: titleStringSize.height
      )
      // 6
      attributedTitle.draw(in: titleStringRect)
      // 7
      return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    func addName(pageRect: CGRect) -> CGFloat {
      // 1
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
      // 2
      let titleAttributes: [NSAttributedString.Key: Any] =
        [NSAttributedString.Key.font: titleFont]
      // 3
      let attributedTitle = NSAttributedString(
        string: name,
        attributes: titleAttributes
      )
      // 4
      let titleStringSize = attributedTitle.size()
      // 5
      let titleStringRect = CGRect(
        x: 150,
        y: 195,
        width: titleStringSize.width,
        height: titleStringSize.height
      )
      // 6
      attributedTitle.draw(in: titleStringRect)
      // 7
      return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    func addDocument(pageRect: CGRect) -> CGFloat {
      // 1
        let titleFont = UIFont.systemFont(ofSize: 34.0, weight: .regular)
      // 2
      let titleAttributes: [NSAttributedString.Key: Any] =
        [NSAttributedString.Key.font: titleFont]
      // 3
      let attributedTitle = NSAttributedString(
        string: "Invoice",
        attributes: titleAttributes
      )
      // 4
      let titleStringSize = attributedTitle.size()
      // 5
      let titleStringRect = CGRect(
        x: 20,
        y: 40,
        width: titleStringSize.width,
        height: titleStringSize.height
      )
      // 6
      attributedTitle.draw(in: titleStringRect)
      // 7
      return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    
    func addTotal(pageRect: CGRect) -> CGFloat {
      // 1
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
      // 2
      let titleAttributes: [NSAttributedString.Key: Any] =
        [NSAttributedString.Key.font: titleFont]
      // 3
      let attributedTitle = NSAttributedString(
        string: total,
        attributes: titleAttributes
      )
      // 4
      let titleStringSize = attributedTitle.size()
      // 5
      let titleStringRect = CGRect(
        x: 495,
        y: 475,
        width: titleStringSize.width,
        height: titleStringSize.height
      )
      // 6
      attributedTitle.draw(in: titleStringRect)
      // 7
      return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    func addDiscount(pageRect: CGRect) -> CGFloat {
      // 1
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
      // 2
      let titleAttributes: [NSAttributedString.Key: Any] =
        [NSAttributedString.Key.font: titleFont]
      // 3
      let attributedTitle = NSAttributedString(
        string: discount,
        attributes: titleAttributes
      )
      // 4
      let titleStringSize = attributedTitle.size()
      // 5
      let titleStringRect = CGRect(
        x: 495,
        y: 490,
        width: titleStringSize.width,
        height: titleStringSize.height
      )
      // 6
      attributedTitle.draw(in: titleStringRect)
      // 7
      return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    func addTax(pageRect: CGRect) -> CGFloat {
      // 1
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
      // 2
      let titleAttributes: [NSAttributedString.Key: Any] =
        [NSAttributedString.Key.font: titleFont]
      // 3
      let attributedTitle = NSAttributedString(
        string: tax,
        attributes: titleAttributes
      )
      // 4
      let titleStringSize = attributedTitle.size()
      // 5
      let titleStringRect = CGRect(
        x: 495,
        y: 505,
        width: titleStringSize.width,
        height: titleStringSize.height
      )
      // 6
      attributedTitle.draw(in: titleStringRect)
      // 7
      return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    func addGrandTotal(pageRect: CGRect) -> CGFloat {
      // 1
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
      // 2
      let titleAttributes: [NSAttributedString.Key: Any] =
        [NSAttributedString.Key.font: titleFont]
      // 3
      let attributedTitle = NSAttributedString(
        string: grandtotal,
        attributes: titleAttributes
      )
      // 4
      let titleStringSize = attributedTitle.size()
      // 5
      let titleStringRect = CGRect(
        x: 495,
        y: 520,
        width: titleStringSize.width,
        height: titleStringSize.height
      )
      // 6
      attributedTitle.draw(in: titleStringRect)
      // 7
      return titleStringRect.origin.y + titleStringRect.size.height
    }
    

    // add nama perusahaan client
    func addClientCompany(pageRect: CGRect) -> CGFloat {
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(
            string: total,
            attributes: titleAttributes
        )
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(
            x: 150,
            y: 195,
            width: titleStringSize.width,
            height: titleStringSize.height
        )
      
        attributedTitle.draw(in: titleStringRect)
    
        return titleStringRect.origin.y + titleStringRect.size.height
    }

    // add alamat client
    func addClientAddres(pageRect: CGRect) -> CGFloat {
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(
            string: total,
            attributes: titleAttributes
        )
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(
            x: 150,
            y: 210,
            width: titleStringSize.width,
            height: titleStringSize.height
        )
      
        attributedTitle.draw(in: titleStringRect)
    
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    // add nomot telp client
    func addClientContact(pageRect: CGRect) -> CGFloat {
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(
            string: total,
            attributes: titleAttributes
        )
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(
            x: 150,
            y: 225,
            width: titleStringSize.width,
            height: titleStringSize.height
        )
      
        attributedTitle.draw(in: titleStringRect)
    
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    // add email client
    func addClientEmail(pageRect: CGRect) -> CGFloat {
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(
            string: total,
            attributes: titleAttributes
        )
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(
            x: 150,
            y: 240,
            width: titleStringSize.width,
            height: titleStringSize.height
        )
      
        attributedTitle.draw(in: titleStringRect)
    
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    // add nama perusahaan
    func addCompany(pageRect: CGRect) -> CGFloat {
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(
            string: "Busy Boss",
            attributes: titleAttributes
        )
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(
            x: 530,
            y: 100,
            width: titleStringSize.width,
            height: titleStringSize.height
        )
      
        attributedTitle.draw(in: titleStringRect)
    
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    // add alamat perusahaan
    func addCompanyAddress(pageRect: CGRect) -> CGFloat {
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(
            string: "Citraland CBD Boulevard, Surabaya",
            attributes: titleAttributes
        )
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(
            x: 370,
            y: 115,
            width: titleStringSize.width,
            height: titleStringSize.height
        )
      
        attributedTitle.draw(in: titleStringRect)
    
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    // add tlpn perusahaan
    func addCompanyContact(pageRect: CGRect) -> CGFloat {
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(
            string: "(031) 12345678",
            attributes: titleAttributes
        )
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(
            x: 494,
            y: 130,
            width: titleStringSize.width,
            height: titleStringSize.height
        )
      
        attributedTitle.draw(in: titleStringRect)
    
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    // add email perusahaan
    func addCompanyEmail(pageRect: CGRect) -> CGFloat {
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(
            string: "admin@busyboss.com",
            attributes: titleAttributes
        )
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(
            x: 452,
            y: 145,
            width: titleStringSize.width,
            height: titleStringSize.height
        )
      
        attributedTitle.draw(in: titleStringRect)
    
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    func addTerms1(pageRect: CGRect) -> CGFloat {
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(
            string: "1. Delivery will be made after payment 100% received",
            attributes: titleAttributes
        )
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(
            x: 20,
            y: 595,
            width: titleStringSize.width,
            height: titleStringSize.height
        )
      
        attributedTitle.draw(in: titleStringRect)
    
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    func addTerms2(pageRect: CGRect) -> CGFloat {
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(
            string: "2. Goods & Services Franco Surabaya",
            attributes: titleAttributes
        )
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(
            x: 20,
            y: 610,
            width: titleStringSize.width,
            height: titleStringSize.height
        )
      
        attributedTitle.draw(in: titleStringRect)
    
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    func addTerms3(pageRect: CGRect) -> CGFloat {
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(
            string: "3. Payment to BCA 010188888 a/n PT Boss Gak Perlu Repot",
            attributes: titleAttributes
        )
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(
            x: 20,
            y: 625,
            width: titleStringSize.width,
            height: titleStringSize.height
        )
      
        attributedTitle.draw(in: titleStringRect)
    
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    
 //Atur gambar
    func addImage(pageRect: CGRect) -> CGFloat {

      let maxHeight = pageRect.height * 0.1
      let maxWidth = pageRect.width * 0.2

      let aspectWidth = maxWidth / logo.size.width
      let aspectHeight = maxHeight / logo.size.height
      let aspectRatio = min(aspectWidth, aspectHeight)

      let scaledWidth = logo.size.width * aspectRatio
      let scaledHeight = logo.size.height * aspectRatio

      let imageRect = CGRect(
        x: 520,
        y: 15,
        width: scaledWidth,
        height: scaledHeight)

      logo.draw(in: imageRect)
      return imageRect.origin.y + imageRect.size.height
    }
}

