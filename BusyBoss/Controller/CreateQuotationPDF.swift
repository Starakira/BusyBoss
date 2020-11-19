//
//  CreateQuotationPDF.swift
//  BusyBoss
//
//  Created by Andre Marines ado Tena Uak on 16/11/20.
//

import UIKit
import PDFKit

class CreateQuotationPDF: NSObject {
    
    let title: String
    let name: String
    let total : String
    let tax : String
    let discount : String
    let validdate : String
    let grandtotal : String
    let logo : UIImage
    /*let companyname : String
    let clientaddress : String
    let clientPhone : String
    let clientemail : String
    let alamat : String
    let nomottlpn: String
    let email : String
    let owner : String
    let jenis : String
    let perusahaan : String*/
    
    
    init(title: String, name: String, total : String, tax: String, discount : String, validdate : String, grandtotal : String, logo : UIImage/*, companytname : String, clientaddress : String, clientphone : String, clientemail : String, alamat : String, nomortlpn : String, email : String, owner : String, jenis : String, perusahaan : String*/) {
      self.title = title
      self.name = name
        self.total = total
        self.tax = tax
        self.discount = discount
        self.validdate = validdate
        self.grandtotal = grandtotal
        self.logo = logo
        /*self.companyname = companytname
        self.clientaddress = clientaddress
        self.clientPhone = clientphone
        self.clientemail = clientemail
        self.alamat = alamat
        self.nomottlpn = nomortlpn
        self.email = email
        self.owner = owner
        self.jenis = jenis
        self.perusahaan = perusahaan*/

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
        let normalattributes = [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        let boldattributes = [ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
        let validattributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        
        
        
        //setting tulisan pasti
        
        let Numbertext = "Number : "
        Numbertext.draw(at: CGPoint(x: 20, y: 75), withAttributes :normalattributes)
        
        let data = "To"
        data.draw(at: CGPoint(x: 20, y: 180), withAttributes : normalattributes)
        
        let titikdua1 = ":"
        titikdua1.draw(at: CGPoint(x: 140, y: 180), withAttributes : normalattributes)
        
        let CompanyName = "Company Name"
        CompanyName.draw(at: CGPoint(x: 20, y: 195), withAttributes : normalattributes)
        
        let titikdua2 = ":"
        titikdua2.draw(at: CGPoint(x: 140, y: 195), withAttributes : normalattributes)
        
        let Address = "Address"
        Address.draw(at: CGPoint(x: 20, y: 210), withAttributes : normalattributes)
        
        let titikdua3 = ":"
        titikdua3.draw(at: CGPoint(x: 140, y: 210), withAttributes : normalattributes)
        
        let PhoneNumber = "Phone Number"
        PhoneNumber.draw(at: CGPoint(x: 20, y: 225), withAttributes : normalattributes)
        
        let titikdua4 = ":"
        titikdua4.draw(at: CGPoint(x: 140, y: 225), withAttributes : normalattributes)
        
        let Email = "Email"
        Email.draw(at: CGPoint(x: 20, y: 240), withAttributes : normalattributes)
        
        let titikdua5 = ":"
        titikdua5.draw(at: CGPoint(x: 140, y: 240), withAttributes : normalattributes)
        
        let TransactionTitle = "Transaction Title"
        TransactionTitle.draw(at: CGPoint(x: 20, y: 265), withAttributes : boldattributes)
        
        let titikdua6 = ":"
        titikdua6.draw(at: CGPoint(x: 140, y: 265), withAttributes : normalattributes)
        
        let Pages = "Pages"
        Pages.draw(at: CGPoint(x: 20, y: 280), withAttributes : boldattributes)
        
        let titikdua7 = ":"
        titikdua7.draw(at: CGPoint(x: 140, y: 280), withAttributes : normalattributes)
        
        let JumlahPages = "1 Pages"
        JumlahPages.draw(at: CGPoint(x: 150, y: 280), withAttributes : boldattributes)
        
        
        
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
        Total.draw(at: CGPoint(x: 400, y: 475), withAttributes : normalattributes)
        
        let Discount = "Discount"
        Discount.draw(at: CGPoint(x: 400, y: 490), withAttributes : normalattributes)
        
        let PPN = "PPN 10%"
        PPN.draw(at: CGPoint(x: 400, y: 505), withAttributes : normalattributes)
        
        let GrandTotal = "Grand Total"
        GrandTotal.draw(at: CGPoint(x: 400, y: 520), withAttributes : boldattributes)
        
        // setting terms
        let valid = "This offer valid until : "
        valid.draw(at: CGPoint(x: 20, y: 560),withAttributes : validattributes)
        
        let Terms = "Terms and Condition :"
        Terms.draw(at: CGPoint(x: 20, y: 580), withAttributes : normalattributes)
        
        //setting tanda tangan
        let please = "Please confirm acceptance of this quotation"
        please.draw(at: CGPoint(x: 300, y: 640), withAttributes : normalattributes)
        
        let please2 = "by clicking here. (ini untuk apps clips)"
        please2.draw(at: CGPoint(x: 300, y: 655), withAttributes : normalattributes)
        
        let Sincerely = "Sincerely,"
        Sincerely.draw(at: CGPoint(x: 20, y: 665), withAttributes : boldattributes)
        
        let Signature = "Signature "
        Signature.draw(at: CGPoint(x: 300, y: 725), withAttributes : normalattributes)
        
        let titikdua8 = ":"
        titikdua8.draw(at: CGPoint(x: 375, y: 725), withAttributes : normalattributes)
        
        let Name = "Name"
        Name.draw(at: CGPoint(x: 300, y: 740), withAttributes : normalattributes)
        
        let titikdua9 = ":"
        titikdua9.draw(at: CGPoint(x: 375, y: 740), withAttributes : normalattributes)
        
        let Position = "Signature"
        Position.draw(at: CGPoint(x: 300, y: 755), withAttributes : normalattributes)
        
        let titikdua0 = ":"
        titikdua0.draw(at: CGPoint(x: 375, y: 755), withAttributes : normalattributes)
        
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
      }

      return data
    }

    // add title dokumen
    func addTitle(pageRect: CGRect) -> CGFloat {
        
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(
            string: title,
            attributes: titleAttributes
        )
        
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(
            x: 150,
            y: 265,
            width: titleStringSize.width,
            height: titleStringSize.height
        )
      
        attributedTitle.draw(in: titleStringRect)

        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    // add nama client
    func addName(pageRect: CGRect) -> CGFloat {
        
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
      
        let attributedTitle = NSAttributedString(
            string: name,
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
    
    // add jenis dokumen
    func addDocument(pageRect: CGRect) -> CGFloat {

        let titleFont = UIFont.systemFont(ofSize: 34.0, weight: .regular)
        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
      
        let attributedTitle = NSAttributedString(
            string: "Quotation",
            attributes: titleAttributes
        )
        
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(
            x: 20,
            y: 40,
            width: titleStringSize.width,
            height: titleStringSize.height
        )
        attributedTitle.draw(in: titleStringRect)
        
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    // add total
    func addTotal(pageRect: CGRect) -> CGFloat {
        
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(
            string: total,
            attributes: titleAttributes
        )
        
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(
            x: 495,
            y: 475,
            width: titleStringSize.width,
            height: titleStringSize.height
        )
      
        attributedTitle.draw(in: titleStringRect)
    
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    // add discount
    func addDiscount(pageRect: CGRect) -> CGFloat {
        
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(
            string: discount,
            attributes: titleAttributes
        )
        
        let titleStringSize = attributedTitle.size()

        let titleStringRect = CGRect(
            x: 495,
            y: 490,
            width: titleStringSize.width,
            height: titleStringSize.height
        )
        attributedTitle.draw(in: titleStringRect)

        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    // add total
    func addTax(pageRect: CGRect) -> CGFloat {
      
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
        
        let attributedTitle = NSAttributedString(
            string: tax,
            attributes: titleAttributes
        )
      
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(
            x: 495,
            y: 505,
            width: titleStringSize.width,
            height: titleStringSize.height
        )
      
        attributedTitle.draw(in: titleStringRect)

        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    // add grand total
    func addGrandTotal(pageRect: CGRect) -> CGFloat {

        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]

        let attributedTitle = NSAttributedString(
            string: grandtotal,
            attributes: titleAttributes
        )

        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(
            x: 495,
            y: 520,
            width: titleStringSize.width,
            height: titleStringSize.height
        )
     
        attributedTitle.draw(in: titleStringRect)
      
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
            string: total,
            attributes: titleAttributes
        )
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(
            x: 450,
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
            string: total,
            attributes: titleAttributes
        )
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(
            x: 450,
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
            string: total,
            attributes: titleAttributes
        )
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(
            x: 450,
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
            string: total,
            attributes: titleAttributes
        )
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(
            x: 450,
            y: 145,
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
