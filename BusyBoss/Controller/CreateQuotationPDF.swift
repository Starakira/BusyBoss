//
//  CreateQuotationPDF.swift
//  BusyBoss
//
//  Created by Andre Marines ado Tena Uak on 30/11/20.
//

import UIKit
import PDFKit

class CreateQuotationPDF: NSObject {
    
    let Tax         : String
    let ClientnName : String
    let ClientPhone : String
    let Title       : String
    let ClientEmail : String
    let ClientAddres: String
    let Total       : String
    let Discount    : String
    let GrandTotal  : String
    let ClientCompany : String
    let Date        : String
    
    let terms = ["1. Above information is not an invoice and only estimate of service/goods described above.","2. Payment will be collected prior to provision of service/goods described in this quote",/*"3. Payment to BCA 010188888 a/n PT Boss Gak Perlu Repot","coba","data","lebih","6"*/]
    
    let normalattributes = [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
    let boldattributes = [ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
    let validattributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
    
    var pageCount = 0
    
    var products: [Product]!
    
    init(tax : String, clientname : String, clientphone : String, clientemail : String, clientaddress : String, title : String, total : String, grandtotal : String, discount : String, clientcompany : String, date : String) {
        
        self.Tax = tax
        self.ClientnName = clientname
        self.ClientEmail = clientemail
        self.ClientPhone = clientphone
        self.ClientAddres = clientaddress
        self.Title = title
        self.Total = total
        self.Discount = discount
        self.GrandTotal = grandtotal
        self.ClientCompany = clientcompany
        self.Date = date
    }
    
    func createFlyer(products: [Product]) -> Data
    {
        self.products = products
        
        let pdfMetaData = [
            kCGPDFContextCreator: "",
            kCGPDFContextAuthor: "",
            kCGPDFContextTitle: Title
        ]
        
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        let pageWidth = 8.5 * 72.0
        let pageHeight = 11 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        var firstPage = true
        var processDone = false
        var totalPageCount = 1
        
        let data = renderer.pdfData { (context) in
            
            var offsetY = 0
            var productNumber = 0
            
            while (!processDone) {
                if (firstPage) {
                    context.beginPage()
                    
                    //Header
                    addTitle(pageRect: pageRect)
                    addClientName(pageRect: pageRect)
                    addClientName(pageRect: pageRect)
                    addClientPhone(pageRect: pageRect)
                    addClientEmail(pageRect: pageRect)
                    addClientAddress(pageRect: pageRect)
                    addClientCompany(pageRect: pageRect)
                    addDocument(pageRect: pageRect)
                    //addImage(pageRect: pageRect)
                    addCompany(pageRect: pageRect)
                    addCompanyAddress(pageRect: pageRect)
                    addCompanyContact(pageRect: pageRect)
                    addCompanyEmail(pageRect: pageRect)
                    
                    let numbertext = "Number : "
                    numbertext.draw(at: CGPoint(x: 440, y: 75), withAttributes :normalattributes)
                    
                    addRecipientInfo(numberPage: totalPageCount)
                    addTableHeader(offset: 0)
                    
                    for index in 0...14{
                        if (self.products.count == 0) {
                            break
                        }
                        offsetY = offsetY + 20
                        
                        addProduct(product: self.products.remove(at: 0), offsetY: offsetY)
                        productNumber = productNumber + 1
                        let number = String(productNumber)
                        number.draw(at: CGPoint(x: 35, y: 355 + offsetY), withAttributes :normalattributes)
                    }
                    firstPage = false
                } else {
                    if (self.products.count == 0) {
                        addFooter(offset: offsetY)
                        processDone = true
                        return
                    }
                    context.beginPage()
                    
                    let targetNumber = productNumber + 23
                    
                    offsetY = offsetY - 175
                    addTableHeader(offset: -175)
                    
                    while (productNumber != (targetNumber+1) && products.count != 0) {
                        productNumber = productNumber + 1
                        offsetY = offsetY + 20
                        
                        addProduct(product: self.products.remove(at: 0), offsetY: offsetY)
                        
                        let number = String(productNumber)
                        number.draw(at: CGPoint(x: 35, y: 355 + offsetY), withAttributes :normalattributes)
                    }
                }
            }
        }
        return data
    }
    
    func addTitle(pageRect: CGRect) -> CGFloat {
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        
        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(
            string: Title,
            attributes: titleAttributes
        )
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(
            x: 150,
            y: 280,
            width: titleStringSize.width,
            height: titleStringSize.height
        )
        
        attributedTitle.draw(in: titleStringRect)
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    func addFooter (offset: Int) {
        let totalOffset = offset
        
        let Total = "Total"
        Total.draw(at: CGPoint(x: 400, y: 455 + totalOffset), withAttributes : boldattributes)
        
        let Discount = "Discount"
        Discount.draw(at: CGPoint(x: 400, y: 475 + totalOffset), withAttributes : boldattributes)
        
        let PPN = "PPN 10%"
        PPN.draw(at: CGPoint(x: 400, y: 495 + totalOffset), withAttributes : boldattributes)
        
        let GrandTotal = "Grand Total"
        GrandTotal.draw(at: CGPoint(x: 400, y: 515 + totalOffset), withAttributes : boldattributes)
        
        //Term
        var offsetX = 0
        
        for term in terms {
            offsetX = offsetX + 20
            term.draw(at: CGPoint(x: 20, y: 560 + offsetX), withAttributes :normalattributes)
        }
        
        let valid = "This offer valid until : "
        valid.draw(at: CGPoint(x: 20, y: 540),withAttributes : validattributes)
        
        let Terms = "Terms and Condition :"
        Terms.draw(at: CGPoint(x: 20, y: 565), withAttributes : normalattributes)
        
        //Sign
        offsetX = offsetX - 60
        
        let please = "Please confirm acceptance of this quotation"
        please.draw(at: CGPoint(x: 300, y: 645 + offsetX), withAttributes : normalattributes)
        
        let please2 = "by clicking here. (ini untuk apps clips)"
        please2.draw(at: CGPoint(x: 300, y: 660 + offsetX), withAttributes : normalattributes)
        
        let Sincerely = "Sincerely,"
        Sincerely.draw(at: CGPoint(x: 20, y: 660 + offsetX), withAttributes : boldattributes)
        
        let Signature = "Signature "
        Signature.draw(at: CGPoint(x: 300, y: 720 + offsetX), withAttributes : normalattributes)
        
        let titikdua = ":"
        titikdua.draw(at: CGPoint(x: 375, y: 720 + offsetX), withAttributes : normalattributes)
        
        let Name = "Name"
        Name.draw(at: CGPoint(x: 300, y: 740 + offsetX), withAttributes : normalattributes)
    
        titikdua.draw(at: CGPoint(x: 375, y: 740 + offsetX), withAttributes : normalattributes)
        
        let Position = "Position"
        Position.draw(at: CGPoint(x: 300, y: 760 + offsetX), withAttributes : normalattributes)
    
        titikdua.draw(at: CGPoint(x: 375, y: 760 + offsetX), withAttributes : normalattributes)
    }
    
    func addTableHeader(offset: Int) {
        let Nomor = "NO"
        Nomor.draw(at: CGPoint(x: 30, y: 340 + offset), withAttributes : boldattributes)
        
        let ProductName = "Product Name"
        ProductName.draw(at: CGPoint(x: 90, y: 340 + offset), withAttributes : boldattributes)
        
        let Unit = "Unit"
        Unit.draw(at: CGPoint(x: 240, y: 340 + offset), withAttributes : boldattributes)
        
        let Qty = "Qty"
        Qty.draw(at: CGPoint(x: 320, y: 340 + offset), withAttributes : boldattributes)
        
        let UnitPrice = "Unit Price"
        UnitPrice.draw(at: CGPoint(x: 390, y: 330 + offset), withAttributes : boldattributes)
        
        let IDR = "(IDR)"
        IDR.draw(at: CGPoint(x: 407, y: 350 + offset), withAttributes : boldattributes)
        
        let Amount = "Amount"
        Amount.draw(at: CGPoint(x: 500, y: 330 + offset), withAttributes : boldattributes)
        
        IDR.draw(at: CGPoint(x: 507, y: 350 + offset), withAttributes : boldattributes)
        
        let line = UIBezierPath()
        line.move(to: CGPoint(x: 20, y: 370 + offset))
        line.addLine(to: CGPoint(x: 590, y: 370 + offset))
        line.stroke()
    }
    
    func addProduct(product: Product, offsetY: Int) {
        let productText = product.name
        productText.draw(at: CGPoint(x: 90, y: 355 + offsetY), withAttributes :normalattributes)
        
        let unitText = product.unit ?? "n/a"
        unitText.draw(at: CGPoint(x: 235, y: 355 + offsetY), withAttributes :normalattributes)
        
        let quantityText = String(product.transactionQuantity ?? 0)
        quantityText.draw(at: CGPoint(x: 325, y: 355 + offsetY), withAttributes :normalattributes)
        
        let priceText = String(product.price)
        priceText.draw(at: CGPoint(x: 380, y: 355 + offsetY), withAttributes :normalattributes)
        
        let amountText = String(Double((product.transactionQuantity ?? 0)) * product.price)
        amountText.draw(at: CGPoint(x: 480, y: 355 + offsetY), withAttributes :normalattributes)
    }
    
    func addRecipientInfo(numberPage: Int) {
        let data = "To"
        data.draw(at: CGPoint(x: 20, y: 180), withAttributes : normalattributes)
        
        let titikdua = ":"
        titikdua.draw(at: CGPoint(x: 140, y: 180), withAttributes : normalattributes)
        
        let CompanyName = "Company Name"
        CompanyName.draw(at: CGPoint(x: 20, y: 200), withAttributes : normalattributes)
        
        titikdua.draw(at: CGPoint(x: 140, y: 200), withAttributes : normalattributes)
        
        let Address = "Address"
        Address.draw(at: CGPoint(x: 20, y: 220), withAttributes : normalattributes)
        
        titikdua.draw(at: CGPoint(x: 140, y: 220), withAttributes : normalattributes)
        
        let PhoneNumber = "Phone Number"
        PhoneNumber.draw(at: CGPoint(x: 20, y: 240), withAttributes : normalattributes)
        
        titikdua.draw(at: CGPoint(x: 140, y: 240), withAttributes : normalattributes)
        
        let Email = "Email"
        Email.draw(at: CGPoint(x: 20, y: 260), withAttributes : normalattributes)
        
        titikdua.draw(at: CGPoint(x: 140, y: 260), withAttributes : normalattributes)
        
        let TransactionTitle = "Transaction Title"
        TransactionTitle.draw(at: CGPoint(x: 20, y: 280), withAttributes : boldattributes)
        
        titikdua.draw(at: CGPoint(x: 140, y: 280), withAttributes : normalattributes)
        
        let Pages = "Pages"
        Pages.draw(at: CGPoint(x: 20, y: 300), withAttributes : boldattributes)
        
        titikdua.draw(at: CGPoint(x: 140, y: 300), withAttributes : normalattributes)
        
        let JumlahPages = "\(numberPage) Pages"
        JumlahPages.draw(at: CGPoint(x: 150, y: 300), withAttributes : boldattributes)
    }
    
    func addClientName(pageRect: CGRect) -> CGFloat {
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        
        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
        
        let attributedTitle = NSAttributedString(
            string: ClientnName,
            attributes: titleAttributes
        )
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(
            x: 150,
            y: 180,
            width: titleStringSize.width,
            height: titleStringSize.height
        )
        attributedTitle.draw(in: titleStringRect)
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    func addClientPhone(pageRect: CGRect) -> CGFloat {
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        
        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
        
        let attributedTitle = NSAttributedString(
            string: ClientPhone,
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
    
    
    func addClientEmail(pageRect: CGRect) -> CGFloat {
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        
        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
        
        let attributedTitle = NSAttributedString(
            string: ClientEmail,
            attributes: titleAttributes
        )
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(
            x: 150,
            y: 260,
            width: titleStringSize.width,
            height: titleStringSize.height
        )
        attributedTitle.draw(in: titleStringRect)
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    
    func addClientAddress(pageRect: CGRect) -> CGFloat {
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        
        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
        
        let attributedTitle = NSAttributedString(
            string: ClientAddres,
            attributes: titleAttributes
        )
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(
            x: 150,
            y: 220,
            width: titleStringSize.width,
            height: titleStringSize.height
        )
        attributedTitle.draw(in: titleStringRect)
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    func addClientCompany(pageRect: CGRect) -> CGFloat {
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        
        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
        
        let attributedTitle = NSAttributedString(
            string: ClientCompany,
            attributes: titleAttributes
        )
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(
            x: 150,
            y: 200,
            width: titleStringSize.width,
            height: titleStringSize.height
        )
        attributedTitle.draw(in: titleStringRect)
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
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
            x: 440,
            y: 40,
            width: titleStringSize.width,
            height: titleStringSize.height
        )
        attributedTitle.draw(in: titleStringRect)
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    // Atur gambar
    /*func addImage(pageRect: CGRect) -> CGFloat {
     let maxHeight = pageRect.height * 0.1
     let maxWidth = pageRect.width * 0.2
     let aspectWidth = maxWidth / Logo.size.width
     let aspectHeight = maxHeight / Logo.size.height
     let aspectRatio = min(aspectWidth, aspectHeight)
     let scaledWidth = Logo.size.width * aspectRatio
     let scaledHeight = Logo.size.height * aspectRatio
     let imageRect = CGRect(
     x: 20,
     y: 15,
     width: scaledWidth,
     height: scaledHeight)
     Logo.draw(in: imageRect)
     return imageRect.origin.y + imageRect.size.height
     }*/
    
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
            x: 20,
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
            x: 20,
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
            x: 20,
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
            x: 20,
            y: 145,
            width: titleStringSize.width,
            height: titleStringSize.height
        )
        attributedTitle.draw(in: titleStringRect)
        return titleStringRect.origin.y + titleStringRect.size.height
    }
}
