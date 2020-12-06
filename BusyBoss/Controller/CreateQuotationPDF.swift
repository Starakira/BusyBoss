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

    var yTotal = 0
    func createFlyer(products: [Product]?) -> Data {
        
        
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
      let data = renderer.pdfData { (context) in
        var x = 0
        
        
        // 6
        //setting font
        let normalattributes = [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        let boldattributes = [ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
        let validattributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        
        let term = ["1. Above information is not an invoice and only estimate of service/goods described above.","2. Payment will be collected prior to provision of service/goods described in this quote",/*"3. Payment to BCA 010188888 a/n PT Boss Gak Perlu Repot","coba","data","lebih","6"*/]
        
        guard var products = products else {return}
        //1 halaman
        if products.count <= 5 {
            
            context.beginPage()
            
            x = 1
            let numberpage = String(x)
            var a = 0
            var g = 0

            
            let Numbertext = "Number : "
            Numbertext.draw(at: CGPoint(x: 440, y: 75), withAttributes :normalattributes)
            
            for (index, product) in products.enumerated() {
                let tambah = a + 20
                let productText = product.name
                productText.draw(at: CGPoint(x: 90, y: 355 + tambah), withAttributes :normalattributes)
                
                let unitText = product.unit ?? "n/a"
                unitText.draw(at: CGPoint(x: 235, y: 355 + tambah), withAttributes :normalattributes)
                
                let quantityText = String(product.transactionQuantity ?? 0)
                quantityText.draw(at: CGPoint(x: 325, y: 355 + tambah), withAttributes :normalattributes)
                
                let priceText = String(product.price)
                priceText.draw(at: CGPoint(x: 380, y: 355 + tambah), withAttributes :normalattributes)
                
                let amountText = String(Double((product.transactionQuantity ?? 0)) * product.price)
                amountText.draw(at: CGPoint(x: 480, y: 355 + tambah), withAttributes :normalattributes)
                
                a = tambah
                let number = String(index+1)
                number.draw(at: CGPoint(x: 35, y: 355 + tambah), withAttributes :normalattributes)
                products.remove(at: 0)
                if index == 15{
                    break
                }
        }
        
        let data = "To"
        data.draw(at: CGPoint(x: 20, y: 180), withAttributes : normalattributes)
        
        let titikdua1 = ":"
        titikdua1.draw(at: CGPoint(x: 140, y: 180), withAttributes : normalattributes)
        
        let CompanyName = "Company Name"
        CompanyName.draw(at: CGPoint(x: 20, y: 200), withAttributes : normalattributes)
        
        let titikdua2 = ":"
        titikdua2.draw(at: CGPoint(x: 140, y: 200), withAttributes : normalattributes)
        
        let Address = "Address"
        Address.draw(at: CGPoint(x: 20, y: 220), withAttributes : normalattributes)
        
        let titikdua3 = ":"
        titikdua3.draw(at: CGPoint(x: 140, y: 220), withAttributes : normalattributes)
        
        let PhoneNumber = "Phone Number"
        PhoneNumber.draw(at: CGPoint(x: 20, y: 240), withAttributes : normalattributes)
        
        let titikdua4 = ":"
        titikdua4.draw(at: CGPoint(x: 140, y: 240), withAttributes : normalattributes)
        
        let Email = "Email"
        Email.draw(at: CGPoint(x: 20, y: 260), withAttributes : normalattributes)
        
        let titikdua5 = ":"
        titikdua5.draw(at: CGPoint(x: 140, y: 260), withAttributes : normalattributes)
        
        let TransactionTitle = "Transaction Title"
        TransactionTitle.draw(at: CGPoint(x: 20, y: 280), withAttributes : boldattributes)
        
        let titikdua6 = ":"
        titikdua6.draw(at: CGPoint(x: 140, y: 280), withAttributes : normalattributes)
        
        let Pages = "Pages"
        Pages.draw(at: CGPoint(x: 20, y: 300), withAttributes : boldattributes)
        
        let titikdua7 = ":"
        titikdua7.draw(at: CGPoint(x: 140, y: 300), withAttributes : normalattributes)
        
        let JumlahPages = numberpage + " Pages"
        JumlahPages.draw(at: CGPoint(x: 150, y: 300), withAttributes : boldattributes)
        
        
        
        // setting tampilan table
        let Nomor = "NO"
        Nomor.draw(at: CGPoint(x: 30, y: 340), withAttributes : boldattributes)
        
        let ProductName = "Product Name"
        ProductName.draw(at: CGPoint(x: 90, y: 340), withAttributes : boldattributes)
        
        let Unit = "Unit"
        Unit.draw(at: CGPoint(x: 240, y: 340), withAttributes : boldattributes)
        
        let Qty = "Qty"
        Qty.draw(at: CGPoint(x: 320, y: 340), withAttributes : boldattributes)
        
        let UnitPrice = "Unit Price"
        UnitPrice.draw(at: CGPoint(x: 390, y: 330), withAttributes : boldattributes)
        
        let IDR1 = "(IDR)"
        IDR1.draw(at: CGPoint(x: 407, y: 350), withAttributes : boldattributes)
        
        let Amount = "Amount"
        Amount.draw(at: CGPoint(x: 500, y: 330), withAttributes : boldattributes)
        
        let IDR2 = "(IDR)"
        IDR2.draw(at: CGPoint(x: 507, y: 350), withAttributes : boldattributes)
            
        
        let line = UIBezierPath()
            line.move(to: CGPoint(x: 20, y: 370))
            line.addLine(to: CGPoint(x: 590, y: 370))
            line.stroke()
            
            let totalProduct = products.count + 1
            
            let yOffset = 20
            let totalyOffset = yOffset * totalProduct
            yTotal = totalyOffset
            
        let Total = "Total"
        Total.draw(at: CGPoint(x: 400, y: 455 + totalyOffset), withAttributes : boldattributes)
        
        let Discount = "Discount"
        Discount.draw(at: CGPoint(x: 400, y: 475 + totalyOffset), withAttributes : boldattributes)
        
        let PPN = "PPN 10%"
        PPN.draw(at: CGPoint(x: 400, y: 495 + totalyOffset), withAttributes : boldattributes)
        
        let GrandTotal = "Grand Total"
        GrandTotal.draw(at: CGPoint(x: 400, y: 515 + totalyOffset), withAttributes : boldattributes)
            
            //add data ke PDF
            _ = addTitle(pageRect: pageRect)
            _ = addClientName(pageRect: pageRect)
            _ = addClientName(pageRect: pageRect)
            let clientphone = addClientPhone(pageRect: pageRect)
            let clientemail = addClientEmail(pageRect: pageRect)
            let clientaddres = addClientAddress(pageRect: pageRect)
            let clientcompany = addClientCompany(pageRect: pageRect)
            let documentName = addDocument(pageRect: pageRect)
//            let imageBottom = addImage(pageRect: pageRect)
            let company = addCompany(pageRect: pageRect)
            let address = addCompanyAddress(pageRect: pageRect)
            let phone = addCompanyContact(pageRect: pageRect)
            let email = addCompanyEmail(pageRect: pageRect)
            _ = addTotal(pageRect: pageRect)
            _ = addDiscount(pageRect: pageRect)
            _ = addTax(pageRect: pageRect)
            _ = addGrandtotal(pageRect: pageRect)
            
            if term.count <= 3 {
                
                for Term in term {
                    let tambah = g + 20
                    let Numbertext = Term
                    Numbertext.draw(at: CGPoint(x: 20, y: 560 + tambah), withAttributes :normalattributes)
                    g = tambah
                }
                
                // setting terms
                    
                let valid = "This offer valid until : "
                valid.draw(at: CGPoint(x: 20, y: 540),withAttributes : validattributes)

                let Terms = "Terms and Condition :"
                Terms.draw(at: CGPoint(x: 20, y: 565), withAttributes : normalattributes)

                //setting tanda tangan
                    let geser = g - 60
                    print(geser)
                    
                let please = "Please confirm acceptance of this quotation"
                please.draw(at: CGPoint(x: 300, y: 645 + geser), withAttributes : normalattributes)

                let please2 = "by clicking here. (ini untuk apps clips)"
                please2.draw(at: CGPoint(x: 300, y: 660 + geser), withAttributes : normalattributes)

                let Sincerely = "Sincerely,"
                Sincerely.draw(at: CGPoint(x: 20, y: 660 + geser), withAttributes : boldattributes)

                let Signature = "Signature "
                Signature.draw(at: CGPoint(x: 300, y: 720 + geser), withAttributes : normalattributes)

                let titikdua8 = ":"
                titikdua8.draw(at: CGPoint(x: 375, y: 720 + geser), withAttributes : normalattributes)

                let Name = "Name"
                Name.draw(at: CGPoint(x: 300, y: 740 + geser), withAttributes : normalattributes)

                let titikdua9 = ":"
                titikdua9.draw(at: CGPoint(x: 375, y: 740 + geser), withAttributes : normalattributes)

                let Position = "Signature"
                Position.draw(at: CGPoint(x: 300, y: 760 + geser), withAttributes : normalattributes)

                let titikdua0 = ":"
                titikdua0.draw(at: CGPoint(x: 375, y: 760 + geser), withAttributes : normalattributes)

            }else{
                context.beginPage()
                
                for Term in term {
                    let tambah = g + 20
                    let Numbertext = Term
                    Numbertext.draw(at: CGPoint(x: 20, y: 200 + tambah), withAttributes :normalattributes)
                    g = tambah
                }

                Numbertext.draw(at: CGPoint(x: 440, y: 75), withAttributes :normalattributes)

                let titletransaction = addTitle(pageRect: pageRect)
                let clientname = addClientName(pageRect: pageRect)
                let clientcompanyname = addClientName(pageRect: pageRect)
                let clientphone = addClientPhone(pageRect: pageRect)
                let clientemail = addClientEmail(pageRect: pageRect)
                let clientaddres = addClientAddress(pageRect: pageRect)
                let clientcompany = addClientCompany(pageRect: pageRect)
                let documentName = addDocument(pageRect: pageRect)
//                let imageBottom = addImage(pageRect: pageRect)
                let company = addCompany(pageRect: pageRect)
                let address = addCompanyAddress(pageRect: pageRect)
                let phone = addCompanyContact(pageRect: pageRect)
                let email = addCompanyEmail(pageRect: pageRect)

                // setting terms


                let valid = "This offer valid until : "
                valid.draw(at: CGPoint(x: 20, y: 180 ),withAttributes : validattributes)

                let Terms = "Terms and Condition :"
                Terms.draw(at: CGPoint(x: 20, y: 200 ), withAttributes : normalattributes)

            //setting tanda tangan
                let geser1 = g - 60
                print(geser1)

                let please = "Please confirm acceptance of this quotation"
                please.draw(at: CGPoint(x: 300, y: 280 + geser1), withAttributes : normalattributes)
                    print(please)
                let please2 = "by clicking here. (ini untuk apps clips)"
                please2.draw(at: CGPoint(x: 300, y: 300 + geser1), withAttributes : normalattributes)

                let Sincerely = "Sincerely,"
                Sincerely.draw(at: CGPoint(x: 20, y: 300 + geser1), withAttributes : boldattributes)

                let Signature = "Signature "
                Signature.draw(at: CGPoint(x: 300, y: 380 + geser1), withAttributes : normalattributes)

                let titikdua8 = ":"
                titikdua8.draw(at: CGPoint(x: 375, y: 380 + geser1), withAttributes : normalattributes)

                let Name = "Name"
                Name.draw(at: CGPoint(x: 300, y: 400 + geser1), withAttributes : normalattributes)

                let titikdua9 = ":"
                titikdua9.draw(at: CGPoint(x: 375, y: 400 + geser1), withAttributes : normalattributes)

                let Position = "Signature"
                Position.draw(at: CGPoint(x: 300, y: 420 + geser1), withAttributes : normalattributes)

                let titikdua0 = ":"
                titikdua0.draw(at: CGPoint(x: 375, y: 420 + geser1), withAttributes : normalattributes)

            }
      
        // 1 1/2 halaman
        } else if products.count >= 6 && products.count <= 15{
            
            context.beginPage()
            
            x = 2
            let numberpage = String(x)
            var a = 0
            var g = 0
            
            for (index, product) in products.enumerated() {
                let tambah = a + 20
                let productText = product.name
                productText.draw(at: CGPoint(x: 90, y: 355 + tambah), withAttributes :normalattributes)
                
                let unitText = product.unit ?? "n/a"
                unitText.draw(at: CGPoint(x: 235, y: 355 + tambah), withAttributes :normalattributes)
                
                let quantityText = String(product.transactionQuantity ?? 0)
                quantityText.draw(at: CGPoint(x: 325, y: 35 + tambah), withAttributes :normalattributes)
                
                let priceText = String(product.price)
                priceText.draw(at: CGPoint(x: 380, y: 355 + tambah), withAttributes :normalattributes)
                
                let amountText = String(Double((product.transactionQuantity ?? 0)) * product.price)
                amountText.draw(at: CGPoint(x: 480, y: 355 + tambah), withAttributes :normalattributes)
                
                a = tambah
                let number = String(index+1)
                number.draw(at: CGPoint(x: 35, y: 355 + tambah), withAttributes :normalattributes)
                products.remove(at: 0)
                if index == 15{
                    break
                }
            }
            let Numbertext = "Number : "
            Numbertext.draw(at: CGPoint(x: 440, y: 75), withAttributes :normalattributes)
            
            let data = "To"
            data.draw(at: CGPoint(x: 20, y: 180), withAttributes : normalattributes)
            
            let titikdua1 = ":"
            titikdua1.draw(at: CGPoint(x: 140, y: 180), withAttributes : normalattributes)
            
            let CompanyName = "Company Name"
            CompanyName.draw(at: CGPoint(x: 20, y: 200), withAttributes : normalattributes)
            
            let titikdua2 = ":"
            titikdua2.draw(at: CGPoint(x: 140, y: 200), withAttributes : normalattributes)
            
            let Address = "Address"
            Address.draw(at: CGPoint(x: 20, y: 220), withAttributes : normalattributes)
            
            let titikdua3 = ":"
            titikdua3.draw(at: CGPoint(x: 140, y: 220), withAttributes : normalattributes)
            
            let PhoneNumber = "Phone Number"
            PhoneNumber.draw(at: CGPoint(x: 20, y: 240), withAttributes : normalattributes)
            
            let titikdua4 = ":"
            titikdua4.draw(at: CGPoint(x: 140, y: 240), withAttributes : normalattributes)
            
            let Email = "Email"
            Email.draw(at: CGPoint(x: 20, y: 260), withAttributes : normalattributes)
            
            let titikdua5 = ":"
            titikdua5.draw(at: CGPoint(x: 140, y: 260), withAttributes : normalattributes)
            
            let TransactionTitle = "Transaction Title"
            TransactionTitle.draw(at: CGPoint(x: 20, y: 280), withAttributes : boldattributes)
            
            let titikdua6 = ":"
            titikdua6.draw(at: CGPoint(x: 140, y: 280), withAttributes : normalattributes)
            
            let Pages = "Pages"
            Pages.draw(at: CGPoint(x: 20, y: 300), withAttributes : boldattributes)
            
            let titikdua7 = ":"
            titikdua7.draw(at: CGPoint(x: 140, y: 300), withAttributes : normalattributes)
            
            let JumlahPages = numberpage + " Pages"
            JumlahPages.draw(at: CGPoint(x: 150, y: 300), withAttributes : boldattributes)
            
            
            
            // setting tampilan table
            let Nomor = "NO"
            Nomor.draw(at: CGPoint(x: 30, y: 340), withAttributes : boldattributes)
            
            let ProductName = "Product Name"
            ProductName.draw(at: CGPoint(x: 90, y: 340), withAttributes : boldattributes)
            
            let Unit = "Unit"
            Unit.draw(at: CGPoint(x: 240, y: 340), withAttributes : boldattributes)
            
            let Qty = "Qty"
            Qty.draw(at: CGPoint(x: 320, y: 340), withAttributes : boldattributes)
            
            let UnitPrice = "Unit Price"
            UnitPrice.draw(at: CGPoint(x: 390, y: 330), withAttributes : boldattributes)
            
            let IDR1 = "(IDR)"
            IDR1.draw(at: CGPoint(x: 407, y: 350), withAttributes : boldattributes)
            
            let Amount = "Amount"
            Amount.draw(at: CGPoint(x: 500, y: 330), withAttributes : boldattributes)
            
            let IDR2 = "(IDR)"
            IDR2.draw(at: CGPoint(x: 507, y: 350), withAttributes : boldattributes)
                
            
            let line = UIBezierPath()
            line.move(to: CGPoint(x: 20, y: 370))
            line.addLine(to: CGPoint(x: 590, y: 370))
            line.stroke()
                
            let tes = a - 80
            yTotal = tes

            let Total = "Total"
            Total.draw(at: CGPoint(x: 400, y: 460 + tes), withAttributes : boldattributes)

            let Discount = "Discount"
            Discount.draw(at: CGPoint(x: 400, y: 480 + tes), withAttributes : boldattributes)

            let PPN = "PPN 10%"
            PPN.draw(at: CGPoint(x: 400, y: 500 + tes), withAttributes : boldattributes)

            let GrandTotal = "Grand Total"
            GrandTotal.draw(at: CGPoint(x: 400, y: 520 + tes), withAttributes : boldattributes)
                
            let titletransaction = addTitle(pageRect: pageRect)
            let clientname = addClientName(pageRect: pageRect)
            let clientcompanyname = addClientName(pageRect: pageRect)
            let clientphone = addClientPhone(pageRect: pageRect)
            let clientemail = addClientEmail(pageRect: pageRect)
            let clientaddres = addClientAddress(pageRect: pageRect)
            let clientcompany = addClientCompany(pageRect: pageRect)
            let documentName = addDocument(pageRect: pageRect)
//            let imageBottom = addImage(pageRect: pageRect)
            let company = addCompany(pageRect: pageRect)
            let address = addCompanyAddress(pageRect: pageRect)
            let phone = addCompanyContact(pageRect: pageRect)
            let email = addCompanyEmail(pageRect: pageRect)
            _ = addTotal(pageRect: pageRect)
            _ = addDiscount(pageRect: pageRect)
            _ = addTax(pageRect: pageRect)
            _ = addGrandtotal(pageRect: pageRect)
            
            context.beginPage()
            
            Numbertext.draw(at: CGPoint(x: 440, y: 75), withAttributes :normalattributes)
            
            let documentNameP2 = addDocument(pageRect: pageRect)
//            let imageBottoP2m = addImage(pageRect: pageRect)
            let companyP2 = addCompany(pageRect: pageRect)
            let addressP2 = addCompanyAddress(pageRect: pageRect)
            let phoneP2 = addCompanyContact(pageRect: pageRect)
            let emailP2 = addCompanyEmail(pageRect: pageRect)
            
            // setting terms
            
            
            let valid = "This offer valid until : "
            valid.draw(at: CGPoint(x: 20, y: 180 ),withAttributes : validattributes)

            let Terms = "Terms and Condition :"
            Terms.draw(at: CGPoint(x: 20, y: 200 ), withAttributes : normalattributes)
            
            for Term in term {
                let tambah = g + 20
                let Numbertext = Term
                Numbertext.draw(at: CGPoint(x: 20, y: 200 + tambah), withAttributes :normalattributes)
                g = tambah
                
            }

            //setting tanda tangan
            let geser = g - 60
     
            let please = "Please confirm acceptance of this quotation"
            please.draw(at: CGPoint(x: 300, y: 280 + geser), withAttributes : normalattributes)
                print(please)
            let please2 = "by clicking here. (ini untuk apps clips)"
            please2.draw(at: CGPoint(x: 300, y: 300 + geser), withAttributes : normalattributes)

            let Sincerely = "Sincerely,"
            Sincerely.draw(at: CGPoint(x: 20, y: 300 + geser), withAttributes : boldattributes)

            let Signature = "Signature "
            Signature.draw(at: CGPoint(x: 300, y: 380 + geser), withAttributes : normalattributes)

            let titikdua8 = ":"
            titikdua8.draw(at: CGPoint(x: 375, y: 380 + geser), withAttributes : normalattributes)

            let Name = "Name"
            Name.draw(at: CGPoint(x: 300, y: 400 + geser), withAttributes : normalattributes)

            let titikdua9 = ":"
            titikdua9.draw(at: CGPoint(x: 375, y: 400 + geser), withAttributes : normalattributes)

            let Position = "Signature"
            Position.draw(at: CGPoint(x: 300, y: 420 + geser), withAttributes : normalattributes)

            let titikdua0 = ":"
            titikdua0.draw(at: CGPoint(x: 375, y: 420 + geser), withAttributes : normalattributes)
        }
        
        
        
        // 2 halaman
        else if products.count >= 16 && products.count <= 26{
            context.beginPage()
            x = 2
            let numberpage = String(x)
            var a = 0
            var g = 0

            
            for (index, product) in products.enumerated() {
                let tambah = a + 20
                let productText = product.name
                productText.draw(at: CGPoint(x: 90, y: 355 + tambah), withAttributes :normalattributes)
                
                let unitText = product.unit ?? "n/a"
                unitText.draw(at: CGPoint(x: 235, y: 355 + tambah), withAttributes :normalattributes)
                
                let quantityText = String(product.transactionQuantity ?? 0)
                quantityText.draw(at: CGPoint(x: 325, y: 355 + tambah), withAttributes :normalattributes)
                
                let priceText = String(product.price)
                priceText.draw(at: CGPoint(x: 380, y: 355 + tambah), withAttributes :normalattributes)
                
                let amountText = String(Double((product.transactionQuantity ?? 0)) * product.price)
                amountText.draw(at: CGPoint(x: 480, y: 355 + tambah), withAttributes :normalattributes)
                
                a = tambah
                let number = String(index+1)
                number.draw(at: CGPoint(x: 35, y: 355 + tambah), withAttributes :normalattributes)
                products.remove(at: 0)
                if index == 15{
                    break
                }
            }
            
            let Numbertext = "Number : "
            Numbertext.draw(at: CGPoint(x: 440, y: 75), withAttributes :normalattributes)
            
            let data = "To"
            data.draw(at: CGPoint(x: 20, y: 180), withAttributes : normalattributes)
            
            let titikdua1 = ":"
            titikdua1.draw(at: CGPoint(x: 140, y: 180), withAttributes : normalattributes)
            
            let CompanyName = "Company Name"
            CompanyName.draw(at: CGPoint(x: 20, y: 200), withAttributes : normalattributes)
            
            let titikdua2 = ":"
            titikdua2.draw(at: CGPoint(x: 140, y: 200), withAttributes : normalattributes)
            
            let Address = "Address"
            Address.draw(at: CGPoint(x: 20, y: 220), withAttributes : normalattributes)
            
            let titikdua3 = ":"
            titikdua3.draw(at: CGPoint(x: 140, y: 220), withAttributes : normalattributes)
            
            let PhoneNumber = "Phone Number"
            PhoneNumber.draw(at: CGPoint(x: 20, y: 240), withAttributes : normalattributes)
            
            let titikdua4 = ":"
            titikdua4.draw(at: CGPoint(x: 140, y: 240), withAttributes : normalattributes)
            
            let Email = "Email"
            Email.draw(at: CGPoint(x: 20, y: 260), withAttributes : normalattributes)
            
            let titikdua5 = ":"
            titikdua5.draw(at: CGPoint(x: 140, y: 260), withAttributes : normalattributes)
            
            let TransactionTitle = "Transaction Title"
            TransactionTitle.draw(at: CGPoint(x: 20, y: 280), withAttributes : boldattributes)
            
            let titikdua6 = ":"
            titikdua6.draw(at: CGPoint(x: 140, y: 280), withAttributes : normalattributes)
            
            let Pages = "Pages"
            Pages.draw(at: CGPoint(x: 20, y: 300), withAttributes : boldattributes)
            
            let titikdua7 = ":"
            titikdua7.draw(at: CGPoint(x: 140, y: 300), withAttributes : normalattributes)
            
            let JumlahPages = numberpage + " Pages"
            JumlahPages.draw(at: CGPoint(x: 150, y: 300), withAttributes : boldattributes)
            
            
            
            // setting tampilan table
            let Nomor = "NO"
            Nomor.draw(at: CGPoint(x: 30, y: 340), withAttributes : boldattributes)
            
            let ProductName = "Product Name"
            ProductName.draw(at: CGPoint(x: 90, y: 340), withAttributes : boldattributes)
            
            let Unit = "Unit"
            Unit.draw(at: CGPoint(x: 240, y: 340), withAttributes : boldattributes)
            
            let Qty = "Qty"
            Qty.draw(at: CGPoint(x: 320, y: 340), withAttributes : boldattributes)
            
            let UnitPrice = "Unit Price"
            UnitPrice.draw(at: CGPoint(x: 390, y: 330), withAttributes : boldattributes)
            
            let IDR1 = "(IDR)"
            IDR1.draw(at: CGPoint(x: 407, y: 350), withAttributes : boldattributes)
            
            let Amount = "Amount"
            Amount.draw(at: CGPoint(x: 500, y: 330), withAttributes : boldattributes)
            
            let IDR2 = "(IDR)"
            IDR2.draw(at: CGPoint(x: 507, y: 350), withAttributes : boldattributes)
                
            
            let line = UIBezierPath()
            line.move(to: CGPoint(x: 20, y: 370))
            line.addLine(to: CGPoint(x: 590, y: 370))
            line.stroke()
                
            
            let titletransaction = addTitle(pageRect: pageRect)
            let clientname = addClientName(pageRect: pageRect)
            let clientcompanyname = addClientName(pageRect: pageRect)
            let clientphone = addClientPhone(pageRect: pageRect)
            let clientemail = addClientEmail(pageRect: pageRect)
            let clientaddres = addClientAddress(pageRect: pageRect)
            let clientcompany = addClientCompany(pageRect: pageRect)
            let documentName = addDocument(pageRect: pageRect)
//            let imageBottom = addImage(pageRect: pageRect)
            let company = addCompany(pageRect: pageRect)
            let address = addCompanyAddress(pageRect: pageRect)
            let phone = addCompanyContact(pageRect: pageRect)
            let email = addCompanyEmail(pageRect: pageRect)
            context.beginPage()
            
            // setting tampilan table
            Nomor.draw(at: CGPoint(x: 30, y: 180), withAttributes : boldattributes)
            ProductName.draw(at: CGPoint(x: 90, y: 180), withAttributes : boldattributes)
            Unit.draw(at: CGPoint(x: 240, y: 180), withAttributes : boldattributes)
            Qty.draw(at: CGPoint(x: 320, y: 180), withAttributes : boldattributes)
            UnitPrice.draw(at: CGPoint(x: 390, y: 170), withAttributes : boldattributes)
            IDR1.draw(at: CGPoint(x: 407, y: 190), withAttributes : boldattributes)
            Amount.draw(at: CGPoint(x: 500, y: 170), withAttributes : boldattributes)
            IDR2.draw(at: CGPoint(x: 507, y: 190), withAttributes : boldattributes)
            
            var aPage1_1 = 0
            
            for (index, product) in products.enumerated() {
                let tambah = aPage1_1 + 20
                let productText = product.name
                productText.draw(at: CGPoint(x: 90, y: 200 + tambah), withAttributes :normalattributes)
                
                let unitText = product.unit ?? "n/a"
                unitText.draw(at: CGPoint(x: 235, y: 200 + tambah), withAttributes :normalattributes)
                
                let quantityText = String(product.transactionQuantity ?? 0)
                quantityText.draw(at: CGPoint(x: 325, y: 200 + tambah), withAttributes :normalattributes)
                
                let priceText = String(product.price)
                priceText.draw(at: CGPoint(x: 380, y: 200 + tambah), withAttributes :normalattributes)
                
                let amountText = String(Double((product.transactionQuantity ?? 0)) * product.price)
                amountText.draw(at: CGPoint(x: 480, y: 200 + tambah), withAttributes :normalattributes)
                
                aPage1_1 = tambah
                let number = String(index+1)
                number.draw(at: CGPoint(x: 35, y: 200 + tambah), withAttributes :normalattributes)
                products.remove(at: 0)
                if index == 26{
                    break
                }
            }
            let line1_1 = UIBezierPath()
            line1_1.move(to: CGPoint(x: 20, y: 210))
            line1_1.addLine(to: CGPoint(x: 590, y: 210))
            line1_1.stroke()
            
            let set1_1 = aPage1_1 - 200
            let Numbertext2 = "Number : "
            Numbertext2.draw(at: CGPoint(x: 440, y: 75), withAttributes :normalattributes)
            yTotal = set1_1
            let Total = "Total"
            let Discount = "Discount"
            let PPN = "PPN 10%"
            let GrandTotal = "Grand Total"
            
            Total.draw(at: CGPoint(x: 400, y: 440 + set1_1), withAttributes : boldattributes)
            Discount.draw(at: CGPoint(x: 400, y: 460 + set1_1), withAttributes : boldattributes)
            PPN.draw(at: CGPoint(x: 400, y: 480 + set1_1), withAttributes : boldattributes)
            GrandTotal.draw(at: CGPoint(x: 400, y: 500 + set1_1), withAttributes : boldattributes)

            let documentName2 = addDocument(pageRect: pageRect)
//            let logo = addImage(pageRect: pageRect)
            let company2 = addCompany(pageRect: pageRect)
            let address2 = addCompanyAddress(pageRect: pageRect)
            let phone2 = addCompanyContact(pageRect: pageRect)
            let email2 = addCompanyEmail(pageRect: pageRect)
            _ = addTotal(pageRect: pageRect)
            _ = addDiscount(pageRect: pageRect)
            _ = addTax(pageRect: pageRect)
            _ = addGrandtotal(pageRect: pageRect)
            
            if products.count <= 26 && term.count <= 10{
                
                let yTrem = aPage1_1 + 340
                for Term in term {
                    let tambah = g + 20
                    let Numbertext = Term
                    Numbertext.draw(at: CGPoint(x: 20, y: yTrem + tambah), withAttributes :normalattributes)
                    g = tambah
                }
                
                print(aPage1_1)
                print(yTrem)
                
                // setting terms
                let yValid = yTrem - 20
                let valid = "This offer valid until : "
                valid.draw(at: CGPoint(x: 20, y: yValid),withAttributes : validattributes)

                let Terms = "Terms and Condition :"
                Terms.draw(at: CGPoint(x: 20, y: yValid + 20), withAttributes : normalattributes)

                //setting tanda tangan
                    let geser = g - 60
                    print("disini")
                    
                let yTTD = yTrem + 85
                let please = "Please confirm acceptance of this quotation"
                please.draw(at: CGPoint(x: 300, y: yTTD + geser), withAttributes : normalattributes)

                let please2 = "by clicking here. (ini untuk apps clips)"
                please2.draw(at: CGPoint(x: 300, y: 15 + yTTD + geser), withAttributes : normalattributes)

                let Sincerely = "Sincerely,"
                Sincerely.draw(at: CGPoint(x: 20, y: 15 +  yTTD + geser), withAttributes : boldattributes)

                let Signature = "Signature "
                Signature.draw(at: CGPoint(x: 300, y: 60 +  yTTD + geser), withAttributes : normalattributes)

                let titikdua8 = ":"
                titikdua8.draw(at: CGPoint(x: 375, y: 60 +  yTTD + geser), withAttributes : normalattributes)

                let Name = "Name"
                Name.draw(at: CGPoint(x: 300, y: 75 +  yTTD + geser), withAttributes : normalattributes)

                let titikdua9 = ":"
                titikdua9.draw(at: CGPoint(x: 375, y: 75 +  yTTD + geser), withAttributes : normalattributes)

                let Position = "Signature"
                Position.draw(at: CGPoint(x: 300, y: 90 +  yTTD + geser), withAttributes : normalattributes)

                let titikdua0 = ":"
                titikdua0.draw(at: CGPoint(x: 375, y: 90 +  yTTD + geser), withAttributes : normalattributes)

            }else if products.count == 26 && term.count <= 3{
                
                
                let yTrem = aPage1_1 + 340
                for Term in term {
                    let tambah = g + 20
                    let Numbertext = Term
                    Numbertext.draw(at: CGPoint(x: 20, y: yTrem + tambah), withAttributes :normalattributes)
                    g = tambah
                }
                
                print(aPage1_1)
                print(yTrem)
                
                // setting terms
                let yValid = yTrem - 20
                let valid = "This offer valid until : "
                valid.draw(at: CGPoint(x: 20, y: yValid),withAttributes : validattributes)

                let Terms = "Terms and Condition :"
                Terms.draw(at: CGPoint(x: 20, y: yValid + 20), withAttributes : normalattributes)

                //setting tanda tangan
                    let geser = g - 60
                    
                let yTTD = yTrem + 85
                let please = "Please confirm acceptance of this quotation"
                please.draw(at: CGPoint(x: 300, y: yTTD + geser), withAttributes : normalattributes)

                let please2 = "by clicking here. (ini untuk apps clips)"
                please2.draw(at: CGPoint(x: 300, y: 15 + yTTD + geser), withAttributes : normalattributes)

                let Sincerely = "Sincerely,"
                Sincerely.draw(at: CGPoint(x: 20, y: 15 +  yTTD + geser), withAttributes : boldattributes)

                let Signature = "Signature "
                Signature.draw(at: CGPoint(x: 300, y: 60 +  yTTD + geser), withAttributes : normalattributes)

                let titikdua8 = ":"
                titikdua8.draw(at: CGPoint(x: 375, y: 60 +  yTTD + geser), withAttributes : normalattributes)

                let Name = "Name"
                Name.draw(at: CGPoint(x: 300, y: 75 +  yTTD + geser), withAttributes : normalattributes)

                let titikdua9 = ":"
                titikdua9.draw(at: CGPoint(x: 375, y: 75 +  yTTD + geser), withAttributes : normalattributes)

                let Position = "Signature"
                Position.draw(at: CGPoint(x: 300, y: 90 +  yTTD + geser), withAttributes : normalattributes)

                let titikdua0 = ":"
                titikdua0.draw(at: CGPoint(x: 375, y: 90 +  yTTD + geser), withAttributes : normalattributes)
                
            }
        
        }
        //2 1/2 halaman
        else if products.count >= 27 && products.count <= 39 {
            context.beginPage()
        
            print("halaman 2 1/2")
            
            x = 3
            let numberpage = String(x)
            var a = 0
            var g = 0
            
            for (index, product) in products.enumerated() {
                let tambah = a + 20
                let productText = product.name
                productText.draw(at: CGPoint(x: 90, y: 355 + tambah), withAttributes :normalattributes)
                
                let unitText = product.unit ?? "n/a"
                unitText.draw(at: CGPoint(x: 235, y: 355 + tambah), withAttributes :normalattributes)
                
                let quantityText = String(product.transactionQuantity ?? 0)
                quantityText.draw(at: CGPoint(x: 325, y: 355 + tambah), withAttributes :normalattributes)
                
                let priceText = String(product.price)
                priceText.draw(at: CGPoint(x: 380, y: 355 + tambah), withAttributes :normalattributes)
                
                let amountText = String(Double((product.transactionQuantity ?? 0)) * product.price)
                amountText.draw(at: CGPoint(x: 480, y: 355 + tambah), withAttributes :normalattributes)
                
                a = tambah
                let number = String(index+1)
                number.draw(at: CGPoint(x: 35, y: 355 + tambah), withAttributes :normalattributes)
                products.remove(at: 0)
                if index == 15{
                    break
                }
            }
            
            let Numbertext = "Number : "
            Numbertext.draw(at: CGPoint(x: 440, y: 75), withAttributes :normalattributes)
            
            let data = "To"
            data.draw(at: CGPoint(x: 20, y: 180), withAttributes : normalattributes)
            
            let titikdua1 = ":"
            titikdua1.draw(at: CGPoint(x: 140, y: 180), withAttributes : normalattributes)
            
            let CompanyName = "Company Name"
            CompanyName.draw(at: CGPoint(x: 20, y: 200), withAttributes : normalattributes)
            
            let titikdua2 = ":"
            titikdua2.draw(at: CGPoint(x: 140, y: 200), withAttributes : normalattributes)
            
            let Address = "Address"
            Address.draw(at: CGPoint(x: 20, y: 220), withAttributes : normalattributes)
            
            let titikdua3 = ":"
            titikdua3.draw(at: CGPoint(x: 140, y: 220), withAttributes : normalattributes)
            
            let PhoneNumber = "Phone Number"
            PhoneNumber.draw(at: CGPoint(x: 20, y: 240), withAttributes : normalattributes)
            
            let titikdua4 = ":"
            titikdua4.draw(at: CGPoint(x: 140, y: 240), withAttributes : normalattributes)
            
            let Email = "Email"
            Email.draw(at: CGPoint(x: 20, y: 260), withAttributes : normalattributes)
            
            let titikdua5 = ":"
            titikdua5.draw(at: CGPoint(x: 140, y: 260), withAttributes : normalattributes)
            
            let TransactionTitle = "Transaction Title"
            TransactionTitle.draw(at: CGPoint(x: 20, y: 280), withAttributes : boldattributes)
            
            let titikdua6 = ":"
            titikdua6.draw(at: CGPoint(x: 140, y: 280), withAttributes : normalattributes)
            
            let Pages = "Pages"
            Pages.draw(at: CGPoint(x: 20, y: 300), withAttributes : boldattributes)
            
            let titikdua7 = ":"
            titikdua7.draw(at: CGPoint(x: 140, y: 300), withAttributes : normalattributes)
            
            let JumlahPages = numberpage + " Pages"
            JumlahPages.draw(at: CGPoint(x: 150, y: 300), withAttributes : boldattributes)
            
            
            
            // setting tampilan table
            let Nomor = "NO"
            Nomor.draw(at: CGPoint(x: 30, y: 340), withAttributes : boldattributes)
            
            let ProductName = "Product Name"
            ProductName.draw(at: CGPoint(x: 90, y: 340), withAttributes : boldattributes)
            
            let Unit = "Unit"
            Unit.draw(at: CGPoint(x: 240, y: 340), withAttributes : boldattributes)
            
            let Qty = "Qty"
            Qty.draw(at: CGPoint(x: 320, y: 340), withAttributes : boldattributes)
            
            let UnitPrice = "Unit Price"
            UnitPrice.draw(at: CGPoint(x: 390, y: 330), withAttributes : boldattributes)
            
            let IDR1 = "(IDR)"
            IDR1.draw(at: CGPoint(x: 407, y: 350), withAttributes : boldattributes)
            
            let Amount = "Amount"
            Amount.draw(at: CGPoint(x: 500, y: 330), withAttributes : boldattributes)
            
            let IDR2 = "(IDR)"
            IDR2.draw(at: CGPoint(x: 507, y: 350), withAttributes : boldattributes)
                
            
            let line = UIBezierPath()
            line.move(to: CGPoint(x: 20, y: 370))
            line.addLine(to: CGPoint(x: 590, y: 370))
            line.stroke()

            let titletransaction = addTitle(pageRect: pageRect)
            let clientname = addClientName(pageRect: pageRect)
            let clientcompanyname = addClientName(pageRect: pageRect)
            let clientphone = addClientPhone(pageRect: pageRect)
            let clientemail = addClientEmail(pageRect: pageRect)
            let clientaddres = addClientAddress(pageRect: pageRect)
            let clientcompany = addClientCompany(pageRect: pageRect)
            let documentName = addDocument(pageRect: pageRect)
//            let imageBottom = addImage(pageRect: pageRect)
            let company = addCompany(pageRect: pageRect)
            let address = addCompanyAddress(pageRect: pageRect)
            let phone = addCompanyContact(pageRect: pageRect)
            let email = addCompanyEmail(pageRect: pageRect)
        
            //page2
            context.beginPage()
            Numbertext.draw(at: CGPoint(x: 440, y: 75), withAttributes :normalattributes)
            
            // setting tampilan table
            Nomor.draw(at: CGPoint(x: 30, y: 180), withAttributes : boldattributes)
            ProductName.draw(at: CGPoint(x: 90, y: 180), withAttributes : boldattributes)
            Unit.draw(at: CGPoint(x: 240, y: 180), withAttributes : boldattributes)
            Qty.draw(at: CGPoint(x: 320, y: 180), withAttributes : boldattributes)
            UnitPrice.draw(at: CGPoint(x: 390, y: 170), withAttributes : boldattributes)
            IDR1.draw(at: CGPoint(x: 407, y: 190), withAttributes : boldattributes)
            Amount.draw(at: CGPoint(x: 500, y:170), withAttributes : boldattributes)
            IDR2.draw(at: CGPoint(x: 507, y: 190), withAttributes : boldattributes)
            
            var aPage2 = 0
            for (index, product) in products.enumerated() {
                let tambah = aPage2 + 20
                let productText = product.name
                productText.draw(at: CGPoint(x: 90, y: 200 + tambah), withAttributes :normalattributes)
                
                let unitText = product.unit ?? "n/a"
                unitText.draw(at: CGPoint(x: 235, y: 200 + tambah), withAttributes :normalattributes)
                
                let quantityText = String(product.transactionQuantity ?? 0)
                quantityText.draw(at: CGPoint(x: 325, y: 200 + tambah), withAttributes :normalattributes)
                
                let priceText = String(product.price)
                priceText.draw(at: CGPoint(x: 380, y: 200 + tambah), withAttributes :normalattributes)
                
                let amountText = String(Double((product.transactionQuantity ?? 0)) * product.price)
                amountText.draw(at: CGPoint(x: 480, y: 200 + tambah), withAttributes :normalattributes)
                
                aPage2 = tambah
                let number = String(index+1)
                number.draw(at: CGPoint(x: 35, y: 200 + tambah), withAttributes :normalattributes)
                products.remove(at: 0)
                if index == 26{
                    break
                }
            }
                 
            let line2 = UIBezierPath()
            line2.move(to: CGPoint(x: 20, y: 210))
            line2.addLine(to: CGPoint(x: 590, y: 210))
            line2.stroke()
            
            let documentName2 = addDocument(pageRect: pageRect)
//            let logo = addImage(pageRect: pageRect)
            let company2 = addCompany(pageRect: pageRect)
            let address2 = addCompanyAddress(pageRect: pageRect)
            let phone2 = addCompanyContact(pageRect: pageRect)
            let email2 = addCompanyEmail(pageRect: pageRect)
            _ = addTotal(pageRect: pageRect)
            _ = addDiscount(pageRect: pageRect)
            _ = addTax(pageRect: pageRect)
            _ = addGrandtotal(pageRect: pageRect)
            
            let set = aPage2 - 240
            yTotal = set
            
            let Total = "Total"
            Total.draw(at: CGPoint(x: 400, y: 460 + set), withAttributes : boldattributes)

            let Discount = "Discount"
            Discount.draw(at: CGPoint(x: 400, y: 480 + set), withAttributes : boldattributes)
                
            let PPN = "PPN 10%"
            PPN.draw(at: CGPoint(x: 400, y: 500 + set), withAttributes : boldattributes)
            
            let GrandTotal = "Grand Total"
            GrandTotal.draw(at: CGPoint(x: 400, y: 520 + set), withAttributes : boldattributes)
            
            
            context.beginPage()
            
            for Term in term {
                let tambah = g + 20
                let Numbertext = Term
                Numbertext.draw(at: CGPoint(x: 20, y: 260 + tambah), withAttributes :normalattributes)
                g = tambah
                
            }
            
            Numbertext.draw(at: CGPoint(x: 440, y: 75), withAttributes :normalattributes)
            
            // setting terms
            let valid = "This offer valid until : "
            valid.draw(at: CGPoint(x: 20, y: 240),withAttributes : validattributes)

            let Terms = "Terms and Condition :"
            Terms.draw(at: CGPoint(x: 20, y: 265), withAttributes : normalattributes)

            //setting tanda tangan
                let set2 = g - 60
                
            let please = "Please confirm acceptance of this quotation"
            please.draw(at: CGPoint(x: 300, y: 360 + set2), withAttributes : normalattributes)

            let please2 = "by clicking here. (ini untuk apps clips)"
            please2.draw(at: CGPoint(x: 300, y: 380 + set2), withAttributes : normalattributes)

            let Sincerely = "Sincerely,"
            Sincerely.draw(at: CGPoint(x: 20, y: 380 + set2), withAttributes : boldattributes)

            let Signature = "Signature "
            Signature.draw(at: CGPoint(x: 300, y: 440 + set2), withAttributes : normalattributes)

            let titikdua8 = ":"
            titikdua8.draw(at: CGPoint(x: 375, y: 440 + set2), withAttributes : normalattributes)

            let Name = "Name"
            Name.draw(at: CGPoint(x: 300, y: 460 + set2), withAttributes : normalattributes)

            let titikdua9 = ":"
            titikdua9.draw(at: CGPoint(x: 375, y: 460 + set2), withAttributes : normalattributes)

            let Position = "Signature"
            Position.draw(at: CGPoint(x: 300, y: 480 + set2), withAttributes : normalattributes)

            let titikdua0 = ":"
            titikdua0.draw(at: CGPoint(x: 375, y: 480 + set), withAttributes : normalattributes)
            
            //add data ke PDF
            
            let documentName3 = addDocument(pageRect: pageRect)
//            let logo2 = addImage(pageRect: pageRect)
            let company3 = addCompany(pageRect: pageRect)
            let address3 = addCompanyAddress(pageRect: pageRect)
            let phone3 = addCompanyContact(pageRect: pageRect)
            let email3 = addCompanyEmail(pageRect: pageRect)
            
        }
        // halaman 3
        else if products.count >= 40 && products.count <= 50 {
            //Page 1
            context.beginPage()
            
            x = 3
            let numberpage = String(x)
            var a = 0
            var g = 0
            
            for (index, product) in products.enumerated() {
                let tambah = a + 20
                let productText = product.name
                productText.draw(at: CGPoint(x: 90, y: 355 + tambah), withAttributes :normalattributes)
                
                let unitText = product.unit ?? "n/a"
                unitText.draw(at: CGPoint(x: 235, y: 355 + tambah), withAttributes :normalattributes)
                
                let quantityText = String(product.transactionQuantity ?? 0)
                quantityText.draw(at: CGPoint(x: 325, y: 355 + tambah), withAttributes :normalattributes)
                
                let priceText = String(product.price)
                priceText.draw(at: CGPoint(x: 380, y: 355 + tambah), withAttributes :normalattributes)
                
                let amountText = String(Double((product.transactionQuantity ?? 0)) * product.price)
                amountText.draw(at: CGPoint(x: 480, y: 355 + tambah), withAttributes :normalattributes)
                
                a = tambah
                let number = String(index+1)
                number.draw(at: CGPoint(x: 35, y: 355 + tambah), withAttributes :normalattributes)
                products.remove(at: 0)
                if index == 15{
                    break
                }
            }
            
            let Numbertext = "Number : "
            Numbertext.draw(at: CGPoint(x: 440, y: 75), withAttributes :normalattributes)
            
            let data = "To"
            data.draw(at: CGPoint(x: 20, y: 180), withAttributes : normalattributes)
            
            let titikdua1 = ":"
            titikdua1.draw(at: CGPoint(x: 140, y: 180), withAttributes : normalattributes)
            
            let CompanyName = "Company Name"
            CompanyName.draw(at: CGPoint(x: 20, y: 200), withAttributes : normalattributes)
            
            let titikdua2 = ":"
            titikdua2.draw(at: CGPoint(x: 140, y: 200), withAttributes : normalattributes)
            
            let Address = "Address"
            Address.draw(at: CGPoint(x: 20, y: 220), withAttributes : normalattributes)
            
            let titikdua3 = ":"
            titikdua3.draw(at: CGPoint(x: 140, y: 220), withAttributes : normalattributes)
            
            let PhoneNumber = "Phone Number"
            PhoneNumber.draw(at: CGPoint(x: 20, y: 240), withAttributes : normalattributes)
            
            let titikdua4 = ":"
            titikdua4.draw(at: CGPoint(x: 140, y: 240), withAttributes : normalattributes)
            
            let Email = "Email"
            Email.draw(at: CGPoint(x: 20, y: 260), withAttributes : normalattributes)
            
            let titikdua5 = ":"
            titikdua5.draw(at: CGPoint(x: 140, y: 260), withAttributes : normalattributes)
            
            let TransactionTitle = "Transaction Title"
            TransactionTitle.draw(at: CGPoint(x: 20, y: 280), withAttributes : boldattributes)
            
            let titikdua6 = ":"
            titikdua6.draw(at: CGPoint(x: 140, y: 280), withAttributes : normalattributes)
            
            let Pages = "Pages"
            Pages.draw(at: CGPoint(x: 20, y: 300), withAttributes : boldattributes)
            
            let titikdua7 = ":"
            titikdua7.draw(at: CGPoint(x: 140, y: 300), withAttributes : normalattributes)
            
            let JumlahPages = numberpage + " Pages"
            JumlahPages.draw(at: CGPoint(x: 150, y: 300), withAttributes : boldattributes)
            
            
            
            // setting tampilan table
            let Nomor = "NO"
            Nomor.draw(at: CGPoint(x: 30, y: 340), withAttributes : boldattributes)
            
            let ProductName = "Product Name"
            ProductName.draw(at: CGPoint(x: 90, y: 340), withAttributes : boldattributes)
            
            let Unit = "Unit"
            Unit.draw(at: CGPoint(x: 240, y: 340), withAttributes : boldattributes)
            
            let Qty = "Qty"
            Qty.draw(at: CGPoint(x: 320, y: 340), withAttributes : boldattributes)
            
            let UnitPrice = "Unit Price"
            UnitPrice.draw(at: CGPoint(x: 390, y: 330), withAttributes : boldattributes)
            
            let IDR1 = "(IDR)"
            IDR1.draw(at: CGPoint(x: 407, y: 350), withAttributes : boldattributes)
            
            let Amount = "Amount"
            Amount.draw(at: CGPoint(x: 500, y: 330), withAttributes : boldattributes)
            
            let IDR2 = "(IDR)"
            IDR2.draw(at: CGPoint(x: 507, y: 350), withAttributes : boldattributes)
                
            
            let line = UIBezierPath()
            line.move(to: CGPoint(x: 20, y: 370))
            line.addLine(to: CGPoint(x: 590, y: 370))
            line.stroke()

            let titletransaction = addTitle(pageRect: pageRect)
            let clientname = addClientName(pageRect: pageRect)
            let clientcompanyname = addClientName(pageRect: pageRect)
            let clientphone = addClientPhone(pageRect: pageRect)
            let clientemail = addClientEmail(pageRect: pageRect)
            let clientaddres = addClientAddress(pageRect: pageRect)
            let documentName = addDocument(pageRect: pageRect)
            let clientcompany = addClientCompany(pageRect: pageRect)
//            let imageBottom = addImage(pageRect: pageRect)
            let company = addCompany(pageRect: pageRect)
            let address = addCompanyAddress(pageRect: pageRect)
            let phone = addCompanyContact(pageRect: pageRect)
            let email = addCompanyEmail(pageRect: pageRect)
        
            //page 2
            context.beginPage()
            Numbertext.draw(at: CGPoint(x: 440, y: 75), withAttributes :normalattributes)
            
            // setting tampilan table
            Nomor.draw(at: CGPoint(x: 30, y: 180), withAttributes : boldattributes)
            ProductName.draw(at: CGPoint(x: 90, y: 180), withAttributes : boldattributes)
            Unit.draw(at: CGPoint(x: 240, y: 180), withAttributes : boldattributes)
            Qty.draw(at: CGPoint(x: 320, y: 180), withAttributes : boldattributes)
            UnitPrice.draw(at: CGPoint(x: 390, y: 170), withAttributes : boldattributes)
            IDR1.draw(at: CGPoint(x: 407, y: 190), withAttributes : boldattributes)
            Amount.draw(at: CGPoint(x: 500, y:170), withAttributes : boldattributes)
            IDR2.draw(at: CGPoint(x: 507, y: 190), withAttributes : boldattributes)
            
            var aPage2 = 0
            for (index, product) in products.enumerated() {
                let tambah = aPage2 + 20
                let productText = product.name
                productText.draw(at: CGPoint(x: 90, y: 200 + tambah), withAttributes :normalattributes)
                
                let unitText = product.unit ?? "n/a"
                unitText.draw(at: CGPoint(x: 235, y: 200 + tambah), withAttributes :normalattributes)
                
                let quantityText = String(product.transactionQuantity ?? 0)
                quantityText.draw(at: CGPoint(x: 325, y: 200 + tambah), withAttributes :normalattributes)
                
                let priceText = String(product.price)
                priceText.draw(at: CGPoint(x: 380, y: 200 + tambah), withAttributes :normalattributes)
                
                let amountText = String(Double((product.transactionQuantity ?? 0)) * product.price)
                amountText.draw(at: CGPoint(x: 480, y: 200 + tambah), withAttributes :normalattributes)
                
                aPage2 = tambah
                let number = String(index+1)
                number.draw(at: CGPoint(x: 35, y: 200 + tambah), withAttributes :normalattributes)
                products.remove(at: 0)
                if index == 39{
                    break
                }
            }
                 
            let line2 = UIBezierPath()
            line2.move(to: CGPoint(x: 20, y: 210))
            line2.addLine(to: CGPoint(x: 590, y: 210))
            line2.stroke()
            
            let documentName2 = addDocument(pageRect: pageRect)
//            let logo = addImage(pageRect: pageRect)
            let company2 = addCompany(pageRect: pageRect)
            let address2 = addCompanyAddress(pageRect: pageRect)
            let phone2 = addCompanyContact(pageRect: pageRect)
            let email2 = addCompanyEmail(pageRect: pageRect)
            
            let set = aPage2 - 240
            
            
            //page 3
            context.beginPage()
            
            Nomor.draw(at: CGPoint(x: 30, y: 180), withAttributes : boldattributes)
            ProductName.draw(at: CGPoint(x: 90, y: 180), withAttributes : boldattributes)
            Unit.draw(at: CGPoint(x: 240, y: 180), withAttributes : boldattributes)
            Qty.draw(at: CGPoint(x: 320, y: 180), withAttributes : boldattributes)
            UnitPrice.draw(at: CGPoint(x: 390, y: 170), withAttributes : boldattributes)
            IDR1.draw(at: CGPoint(x: 407, y: 190), withAttributes : boldattributes)
            Amount.draw(at: CGPoint(x: 500, y: 170), withAttributes : boldattributes)
            IDR2.draw(at: CGPoint(x: 507, y: 190), withAttributes : boldattributes)
            
            var aPage1_1 = 0
            
            for (index, product) in products.enumerated() {
                let tambah = aPage1_1 + 20
                let productText = product.name
                productText.draw(at: CGPoint(x: 90, y: 200 + tambah), withAttributes :normalattributes)
                
                let unitText = product.unit ?? "n/a"
                unitText.draw(at: CGPoint(x: 235, y: 200 + tambah), withAttributes :normalattributes)
                
                let quantityText = String(product.transactionQuantity ?? 0)
                quantityText.draw(at: CGPoint(x: 325, y: 200 + tambah), withAttributes :normalattributes)
                
                let priceText = String(product.price)
                priceText.draw(at: CGPoint(x: 380, y: 200 + tambah), withAttributes :normalattributes)
                
                let amountText = String(Double((product.transactionQuantity ?? 0)) * product.price)
                amountText.draw(at: CGPoint(x: 480, y: 200 + tambah), withAttributes :normalattributes)
                
                aPage1_1 = tambah
                let number = String(index+1)
                number.draw(at: CGPoint(x: 35, y: 200 + tambah), withAttributes :normalattributes)
                products.remove(at: 0)
                if index == 50{
                    break
                }
            }
            let line1_1 = UIBezierPath()
            line1_1.move(to: CGPoint(x: 20, y: 210))
            line1_1.addLine(to: CGPoint(x: 590, y: 210))
            line1_1.stroke()
            
            let set1_1 = aPage1_1 - 200
            let Numbertext2 = "Number : "
            Numbertext2.draw(at: CGPoint(x: 440, y: 75), withAttributes :normalattributes)
            
            yTotal = set1_1
            let Total = "Total"
            let Discount = "Discount"
            let PPN = "PPN 10%"
            let GrandTotal = "Grand Total"
            
            Total.draw(at: CGPoint(x: 400, y: 440 + set1_1), withAttributes : boldattributes)
            Discount.draw(at: CGPoint(x: 400, y: 460 + set1_1), withAttributes : boldattributes)
            PPN.draw(at: CGPoint(x: 400, y: 480 + set1_1), withAttributes : boldattributes)
            GrandTotal.draw(at: CGPoint(x: 400, y: 500 + set1_1), withAttributes : boldattributes)

            let documentName3 = addDocument(pageRect: pageRect)
//            let logo3 = addImage(pageRect: pageRect)
            let company3 = addCompany(pageRect: pageRect)
            let address3 = addCompanyAddress(pageRect: pageRect)
            let phone3 = addCompanyContact(pageRect: pageRect)
            let email3 = addCompanyEmail(pageRect: pageRect)
            _ = addTotal(pageRect: pageRect)
            _ = addDiscount(pageRect: pageRect)
            _ = addTax(pageRect: pageRect)
            _ = addGrandtotal(pageRect: pageRect)
            
            if products.count <= 40 && term.count <= 10{
                
                let yTrem = aPage1_1 + 340
                for Term in term {
                    let tambah = g + 20
                    let Numbertext = Term
                    Numbertext.draw(at: CGPoint(x: 20, y: yTrem + tambah), withAttributes :normalattributes)
                    g = tambah
                }
                
                print(aPage1_1)
                print(yTrem)
                
                // setting terms
                let yValid = yTrem - 20
                let valid = "This offer valid until : "
                valid.draw(at: CGPoint(x: 20, y: yValid),withAttributes : validattributes)

                let Terms = "Terms and Condition :"
                Terms.draw(at: CGPoint(x: 20, y: yValid + 20), withAttributes : normalattributes)

                //setting tanda tangan
                    let geser = g - 60
                    print("disini")
                    
                let yTTD = yTrem + 85
                let please = "Please confirm acceptance of this quotation"
                please.draw(at: CGPoint(x: 300, y: yTTD + geser), withAttributes : normalattributes)

                let please2 = "by clicking here. (ini untuk apps clips)"
                please2.draw(at: CGPoint(x: 300, y: 15 + yTTD + geser), withAttributes : normalattributes)

                let Sincerely = "Sincerely,"
                Sincerely.draw(at: CGPoint(x: 20, y: 15 +  yTTD + geser), withAttributes : boldattributes)

                let Signature = "Signature "
                Signature.draw(at: CGPoint(x: 300, y: 60 +  yTTD + geser), withAttributes : normalattributes)

                let titikdua8 = ":"
                titikdua8.draw(at: CGPoint(x: 375, y: 60 +  yTTD + geser), withAttributes : normalattributes)

                let Name = "Name"
                Name.draw(at: CGPoint(x: 300, y: 75 +  yTTD + geser), withAttributes : normalattributes)

                let titikdua9 = ":"
                titikdua9.draw(at: CGPoint(x: 375, y: 75 +  yTTD + geser), withAttributes : normalattributes)

                let Position = "Signature"
                Position.draw(at: CGPoint(x: 300, y: 90 +  yTTD + geser), withAttributes : normalattributes)

                let titikdua0 = ":"
                titikdua0.draw(at: CGPoint(x: 375, y: 90 +  yTTD + geser), withAttributes : normalattributes)

            }else if products.count == 50 && term.count <= 3{
                
                
                let yTrem = aPage1_1 + 340
                for Term in term {
                    let tambah = g + 20
                    let Numbertext = Term
                    Numbertext.draw(at: CGPoint(x: 20, y: yTrem + tambah), withAttributes :normalattributes)
                    g = tambah
                }
                
                print(aPage1_1)
                print(yTrem)
                
                // setting terms
                let yValid = yTrem - 20
                let valid = "This offer valid until : "
                valid.draw(at: CGPoint(x: 20, y: yValid),withAttributes : validattributes)

                let Terms = "Terms and Condition :"
                Terms.draw(at: CGPoint(x: 20, y: yValid + 20), withAttributes : normalattributes)

                //setting tanda tangan
                    let geser = g - 60
                    print("disini 2")
                    
                let yTTD = yTrem + 85
                let please = "Please confirm acceptance of this quotation"
                please.draw(at: CGPoint(x: 300, y: yTTD + geser), withAttributes : normalattributes)

                let please2 = "by clicking here. (ini untuk apps clips)"
                please2.draw(at: CGPoint(x: 300, y: 15 + yTTD + geser), withAttributes : normalattributes)

                let Sincerely = "Sincerely,"
                Sincerely.draw(at: CGPoint(x: 20, y: 15 +  yTTD + geser), withAttributes : boldattributes)

                let Signature = "Signature "
                Signature.draw(at: CGPoint(x: 300, y: 60 +  yTTD + geser), withAttributes : normalattributes)

                let titikdua8 = ":"
                titikdua8.draw(at: CGPoint(x: 375, y: 60 +  yTTD + geser), withAttributes : normalattributes)

                let Name = "Name"
                Name.draw(at: CGPoint(x: 300, y: 75 +  yTTD + geser), withAttributes : normalattributes)

                let titikdua9 = ":"
                titikdua9.draw(at: CGPoint(x: 375, y: 75 +  yTTD + geser), withAttributes : normalattributes)

                let Position = "Signature"
                Position.draw(at: CGPoint(x: 300, y: 90 +  yTTD + geser), withAttributes : normalattributes)

                let titikdua0 = ":"
                titikdua0.draw(at: CGPoint(x: 375, y: 90 +  yTTD + geser), withAttributes : normalattributes)
                
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
    
    func addTotal(pageRect: CGRect) -> CGFloat {
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)

      let titleAttributes: [NSAttributedString.Key: Any] =
        [NSAttributedString.Key.font: titleFont]

      let attributedTitle = NSAttributedString(
        string: Total,
        attributes: titleAttributes
      )
      let titleStringSize = attributedTitle.size()
      let titleStringRect = CGRect(
        x: 500,
        y: CGFloat(455 + yTotal),
        width: titleStringSize.width,
        height: titleStringSize.height
      )
      attributedTitle.draw(in: titleStringRect)
      return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    func addDiscount(pageRect: CGRect) -> CGFloat {
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)

      let titleAttributes: [NSAttributedString.Key: Any] =
        [NSAttributedString.Key.font: titleFont]

      let attributedTitle = NSAttributedString(
        string: Discount,
        attributes: titleAttributes
      )
      let titleStringSize = attributedTitle.size()
      let titleStringRect = CGRect(
        x: 500,
        y: CGFloat(475 + yTotal),
        width: titleStringSize.width,
        height: titleStringSize.height
      )
      attributedTitle.draw(in: titleStringRect)
      return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    func addTax(pageRect: CGRect) -> CGFloat {
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)

      let titleAttributes: [NSAttributedString.Key: Any] =
        [NSAttributedString.Key.font: titleFont]

      let attributedTitle = NSAttributedString(
        string: Tax,
        attributes: titleAttributes
      )
      let titleStringSize = attributedTitle.size()
      let titleStringRect = CGRect(
        x: 500,
        y: CGFloat(495 + yTotal),
        width: titleStringSize.width,
        height: titleStringSize.height
      )
      attributedTitle.draw(in: titleStringRect)
      return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    func addGrandtotal(pageRect: CGRect) -> CGFloat {
        let titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)

      let titleAttributes: [NSAttributedString.Key: Any] =
        [NSAttributedString.Key.font: titleFont]

      let attributedTitle = NSAttributedString(
        string: GrandTotal,
        attributes: titleAttributes
      )
      let titleStringSize = attributedTitle.size()
      let titleStringRect = CGRect(
        x: 500,
        y: CGFloat(515 + yTotal),
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
