//
//  CreateReceiptPDF.swift
//  BusyBoss
//
//  Created by Andre Marines ado Tena Uak on 30/11/20.
//

import UIKit

class CreateReceiptPDF: NSObject {
    
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
    
    func createFlyer(products: [Product]?) -> Data {
        
      // 1
        let pdfMetaData = [
          kCGPDFContextCreator: "Flyer Builder",
          kCGPDFContextAuthor: "raywenderlich.com",
          kCGPDFContextTitle: Title
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
        
        var x = 0
        
        
        // 6
        //setting font
        let normalattributes = [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        let boldattributes = [ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
        let validattributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        let receipt = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        
        
        
        
        var term = ["1. Above information is not an invoice and only estimate of service/goods described above.","2. Payment will be collected prior to provision of service/goods described in this quote","3. Payment to BCA 010188888 a/n PT Boss Gak Perlu Repot"/*,"coba","data","lebih","6"*/]
        
        guard var products = products else {return}
        
        //1 halaman
        if products.count <= 5 {
            
            context.beginPage()
            
            x = 1
            let numberpage = String(x)
            var a = 0
            var c = 0
            var d = 0
            var e = 0
            var f = 0
            var index = 0
            var index3 = 0
            var index4 = 0
            var index5 = 0
            var index6 = 0
            
            let Numbertext = "Number : "
            Numbertext.draw(at: CGPoint(x: 440, y: 75), withAttributes :normalattributes)
            
            for (index, product) in products.enumerated() {
                let tambah = a + 20
                let productText = product.name
                productText.draw(at: CGPoint(x: 90, y: 480 + tambah), withAttributes :normalattributes)
                
                let unitText = product.unit ?? "n/a"
                unitText.draw(at: CGPoint(x: 235, y: 480 + tambah), withAttributes :normalattributes)
                
                let quantityText = String(product.transactionQuantity ?? 0)
                quantityText.draw(at: CGPoint(x: 325, y: 480 + tambah), withAttributes :normalattributes)
                
                let priceText = String(product.price)
                priceText.draw(at: CGPoint(x: 380, y: 480 + tambah), withAttributes :normalattributes)
                
                let amountText = String(Double((product.transactionQuantity ?? 0)) * product.price)
                amountText.draw(at: CGPoint(x: 480, y: 480 + tambah), withAttributes :normalattributes)
                
                a = tambah
                let number = String(index+1)
                number.draw(at: CGPoint(x: 35, y: 480 + tambah), withAttributes :normalattributes)
                products.remove(at: 0)
                if index == 10{
                    break
                }
            }
        
        
        let data = "To"
        data.draw(at: CGPoint(x: 20, y: 160), withAttributes : normalattributes)
        
        let titikdua1 = ":"
        titikdua1.draw(at: CGPoint(x: 140, y: 160), withAttributes : normalattributes)
        
        let CompanyName = "Company Name"
        CompanyName.draw(at: CGPoint(x: 20, y: 180), withAttributes : normalattributes)
        
        let titikdua2 = ":"
        titikdua2.draw(at: CGPoint(x: 140, y: 180), withAttributes : normalattributes)
        
        let Address = "Address"
        Address.draw(at: CGPoint(x: 20, y: 200), withAttributes : normalattributes)
        
        let titikdua3 = ":"
        titikdua3.draw(at: CGPoint(x: 140, y: 200), withAttributes : normalattributes)
        
        let PhoneNumber = "Phone Number"
        PhoneNumber.draw(at: CGPoint(x: 20, y: 220), withAttributes : normalattributes)
        
        let titikdua4 = ":"
        titikdua4.draw(at: CGPoint(x: 140, y: 220), withAttributes : normalattributes)
        
        let Email = "Email"
        Email.draw(at: CGPoint(x: 20, y: 240), withAttributes : normalattributes)
        
        let titikdua5 = ":"
        titikdua5.draw(at: CGPoint(x: 140, y: 240), withAttributes : normalattributes)
        
        let TransactionTitle = "Transaction Title"
        TransactionTitle.draw(at: CGPoint(x: 20, y: 260), withAttributes : boldattributes)
        
        let titikdua6 = ":"
        titikdua6.draw(at: CGPoint(x: 140, y: 260), withAttributes : normalattributes)
        
        let Pages = "Pages"
        Pages.draw(at: CGPoint(x: 20, y: 280), withAttributes : boldattributes)
        
        let titikdua7 = ":"
        titikdua7.draw(at: CGPoint(x: 140, y: 280), withAttributes : normalattributes)
        
        let JumlahPages = numberpage + " Pages"
        JumlahPages.draw(at: CGPoint(x: 150, y: 280), withAttributes : boldattributes)
        
            let We = "We would like to confirm we have received your payment"
            We.draw(at: CGPoint(x: 20, y: 320), withAttributes : receipt)
            
            let Amount = "Amount"
            Amount.draw(at: CGPoint(x: 20, y: 360), withAttributes : receipt)
            
            let say = "Say"
            say.draw(at: CGPoint(x: 20, y: 400), withAttributes : receipt)
            
            let order = "Order : "
            order.draw(at: CGPoint(x: 20, y: 440), withAttributes : receipt)
            
        
        
        // setting tampilan table
        let Nomor = "NO"
        Nomor.draw(at: CGPoint(x: 30, y: 460), withAttributes : boldattributes)
        
        let ProductName = "Product Name"
        ProductName.draw(at: CGPoint(x: 90, y: 460), withAttributes : boldattributes)
        
        let Unit = "Unit"
        Unit.draw(at: CGPoint(x: 240, y: 460), withAttributes : boldattributes)
        
        let Qty = "Qty"
        Qty.draw(at: CGPoint(x: 320, y: 460), withAttributes : boldattributes)
        
        let UnitPrice = "Unit Price"
        UnitPrice.draw(at: CGPoint(x: 390, y: 450), withAttributes : boldattributes)
        
        let IDR1 = "(IDR)"
        IDR1.draw(at: CGPoint(x: 407, y: 470), withAttributes : boldattributes)
        
        Amount.draw(at: CGPoint(x: 500, y: 450), withAttributes : boldattributes)
        
        let IDR2 = "(IDR)"
        IDR2.draw(at: CGPoint(x: 507, y: 470), withAttributes : boldattributes)
            
        
        let line = UIBezierPath()
            line.move(to: CGPoint(x: 20, y: 490))
            line.addLine(to: CGPoint(x: 590, y: 490))
            line.stroke()
            
            let totalProduct = products.count + 1
            
            let totalyOffset = a - 80
            print(totalyOffset)
            
        let Total = "Total"
        Total.draw(at: CGPoint(x: 400, y: 590 + totalyOffset), withAttributes : boldattributes)
        
        let Discount = "Discount"
        Discount.draw(at: CGPoint(x: 400, y: 610 + totalyOffset), withAttributes : boldattributes)
        
        let PPN = "PPN 10%"
        PPN.draw(at: CGPoint(x: 400, y: 630 + totalyOffset), withAttributes : boldattributes)
        
        let GrandTotal = "Grand Total"
        GrandTotal.draw(at: CGPoint(x: 400, y: 650 + totalyOffset), withAttributes : boldattributes)
            
            //add data ke PDF
            let toclient = addTitle(pageRect: pageRect)
            let companyname = addName(pageRect: pageRect)
            let clientphone = addClientPhone(pageRect: pageRect)
            let clientemail = addClientEmail(pageRect: pageRect)
            let clientaddres = addClientAddress(pageRect: pageRect)
            let documentName = addDocument(pageRect: pageRect)
            let clientcompany = addClientCompany(pageRect: pageRect)//            let imageBottom = addImage(pageRect: pageRect)
            let company = addCompany(pageRect: pageRect)
            let address = addCompanyAddress(pageRect: pageRect)
            let phone = addCompanyContact(pageRect: pageRect)
            let email = addCompanyEmail(pageRect: pageRect)
                    

                let Thanks = "Thank you for your purchase"
                Thanks.draw(at: CGPoint(x: 20, y: 660 + totalyOffset), withAttributes : boldattributes)
                
                let Sincerely = "Sincerely,"
                Sincerely.draw(at: CGPoint(x: 20, y: 680 + totalyOffset), withAttributes : boldattributes)

      
        // 1 1/2 halaman
        } else if products.count >= 6 && products.count <= 10{
            
            context.beginPage()
            
            x = 2
            let numberpage = String(x)
            var a = 0
            var c = 0
            var d = 0
            var e = 0
            var f = 0
            var index = 0
            var index3 = 0
            var index4 = 0
            var index5 = 0
            var index6 = 0
            
            let Numbertext = "Number : "
            Numbertext.draw(at: CGPoint(x: 440, y: 75), withAttributes :normalattributes)
            
            for (index, product) in products.enumerated() {
                let tambah = a + 20
                let productText = product.name
                productText.draw(at: CGPoint(x: 90, y: 480 + tambah), withAttributes :normalattributes)
                
                let unitText = product.unit ?? "n/a"
                unitText.draw(at: CGPoint(x: 235, y: 480 + tambah), withAttributes :normalattributes)
                
                let quantityText = String(product.transactionQuantity ?? 0)
                quantityText.draw(at: CGPoint(x: 325, y: 480 + tambah), withAttributes :normalattributes)
                
                let priceText = String(product.price)
                priceText.draw(at: CGPoint(x: 380, y: 480 + tambah), withAttributes :normalattributes)
                
                let amountText = String(Double((product.transactionQuantity ?? 0)) * product.price)
                amountText.draw(at: CGPoint(x: 480, y: 480 + tambah), withAttributes :normalattributes)
                
                a = tambah
                let number = String(index+1)
                number.draw(at: CGPoint(x: 35, y: 480 + tambah), withAttributes :normalattributes)
                products.remove(at: 0)
                if index == 10{
                    break
                }
            }
        
        
        let data = "To"
        data.draw(at: CGPoint(x: 20, y: 160), withAttributes : normalattributes)
        
        let titikdua1 = ":"
        titikdua1.draw(at: CGPoint(x: 140, y: 160), withAttributes : normalattributes)
        
        let CompanyName = "Company Name"
        CompanyName.draw(at: CGPoint(x: 20, y: 180), withAttributes : normalattributes)
        
        let titikdua2 = ":"
        titikdua2.draw(at: CGPoint(x: 140, y: 180), withAttributes : normalattributes)
        
        let Address = "Address"
        Address.draw(at: CGPoint(x: 20, y: 200), withAttributes : normalattributes)
        
        let titikdua3 = ":"
        titikdua3.draw(at: CGPoint(x: 140, y: 200), withAttributes : normalattributes)
        
        let PhoneNumber = "Phone Number"
        PhoneNumber.draw(at: CGPoint(x: 20, y: 220), withAttributes : normalattributes)
        
        let titikdua4 = ":"
        titikdua4.draw(at: CGPoint(x: 140, y: 220), withAttributes : normalattributes)
        
        let Email = "Email"
        Email.draw(at: CGPoint(x: 20, y: 240), withAttributes : normalattributes)
        
        let titikdua5 = ":"
        titikdua5.draw(at: CGPoint(x: 140, y: 240), withAttributes : normalattributes)
        
        let TransactionTitle = "Transaction Title"
        TransactionTitle.draw(at: CGPoint(x: 20, y: 260), withAttributes : boldattributes)
        
        let titikdua6 = ":"
        titikdua6.draw(at: CGPoint(x: 140, y: 260), withAttributes : normalattributes)
        
        let Pages = "Pages"
        Pages.draw(at: CGPoint(x: 20, y: 280), withAttributes : boldattributes)
        
        let titikdua7 = ":"
        titikdua7.draw(at: CGPoint(x: 140, y: 280), withAttributes : normalattributes)
        
        let JumlahPages = numberpage + " Pages"
        JumlahPages.draw(at: CGPoint(x: 150, y: 280), withAttributes : boldattributes)
        
            let We = "We would like to confirm we have received your payment"
            We.draw(at: CGPoint(x: 20, y: 320), withAttributes : receipt)
            
            let Amount = "Amount"
            Amount.draw(at: CGPoint(x: 20, y: 360), withAttributes : receipt)
            
            let say = "Say"
            say.draw(at: CGPoint(x: 20, y: 400), withAttributes : receipt)
            
            let order = "Order :"
            order.draw(at: CGPoint(x: 20, y: 440), withAttributes : receipt)
            
        
        
        // setting tampilan table
        let Nomor = "NO"
        Nomor.draw(at: CGPoint(x: 30, y: 460), withAttributes : boldattributes)
        
        let ProductName = "Product Name"
        ProductName.draw(at: CGPoint(x: 90, y: 460), withAttributes : boldattributes)
        
        let Unit = "Unit"
        Unit.draw(at: CGPoint(x: 240, y: 460), withAttributes : boldattributes)
        
        let Qty = "Qty"
        Qty.draw(at: CGPoint(x: 320, y: 460), withAttributes : boldattributes)
        
        let UnitPrice = "Unit Price"
        UnitPrice.draw(at: CGPoint(x: 390, y: 450), withAttributes : boldattributes)
        
        let IDR1 = "(IDR)"
        IDR1.draw(at: CGPoint(x: 407, y: 470), withAttributes : boldattributes)
        
        Amount.draw(at: CGPoint(x: 500, y: 450), withAttributes : boldattributes)
        
        let IDR2 = "(IDR)"
        IDR2.draw(at: CGPoint(x: 507, y: 470), withAttributes : boldattributes)
            
        
        let line = UIBezierPath()
            line.move(to: CGPoint(x: 20, y: 490))
            line.addLine(to: CGPoint(x: 590, y: 490))
            line.stroke()
            
            let totalyOffset = a - 100
            
            print("sini")
            print(totalyOffset)
            
        let Total = "Total"
        Total.draw(at: CGPoint(x: 400, y: 590 + totalyOffset), withAttributes : boldattributes)
        
        let Discount = "Discount"
        Discount.draw(at: CGPoint(x: 400, y: 610 + totalyOffset), withAttributes : boldattributes)
        
        let PPN = "PPN 10%"
        PPN.draw(at: CGPoint(x: 400, y: 630 + totalyOffset), withAttributes : boldattributes)
        
        let GrandTotal = "Grand Total"
        GrandTotal.draw(at: CGPoint(x: 400, y: 650 + totalyOffset), withAttributes : boldattributes)
            
            //add data ke PDF
            let toclient = addTitle(pageRect: pageRect)
            let companyname = addName(pageRect: pageRect)
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
                
            
            context.beginPage()
            
            Numbertext.draw(at: CGPoint(x: 440, y: 75), withAttributes :normalattributes)
            
            let documentNameP2 = addDocument(pageRect: pageRect)
//            let imageBottoP2m = addImage(pageRect: pageRect)
            let companyP2 = addCompany(pageRect: pageRect)
            let addressP2 = addCompanyAddress(pageRect: pageRect)
            let phoneP2 = addCompanyContact(pageRect: pageRect)
            let emailP2 = addCompanyEmail(pageRect: pageRect)
            
            
            let Thanks = "Thank you for your purchase"
            Thanks.draw(at: CGPoint(x: 20, y: 660), withAttributes : boldattributes)
            
            let Sincerely = "Sincerely,"
            Sincerely.draw(at: CGPoint(x: 20, y: 680), withAttributes : boldattributes)
            
        }
        
        
        
        // 2 halaman
        else if products.count >= 11 && products.count <= 26{
            context.beginPage()
            
            x = 2
            let numberpage = String(x)
            var a = 0
            var c = 0
            var d = 0
            var e = 0
            var f = 0
            var index = 0
            var index3 = 0
            var index4 = 0
            var index5 = 0
            var index6 = 0
            
            let Numbertext = "Number : "
            Numbertext.draw(at: CGPoint(x: 440, y: 75), withAttributes :normalattributes)
            
            for (index, product) in products.enumerated() {
                let tambah = a + 20
                let productText = product.name
                productText.draw(at: CGPoint(x: 90, y: 480 + tambah), withAttributes :normalattributes)
                
                let unitText = product.unit ?? "n/a"
                unitText.draw(at: CGPoint(x: 235, y: 480 + tambah), withAttributes :normalattributes)
                
                let quantityText = String(product.transactionQuantity ?? 0)
                quantityText.draw(at: CGPoint(x: 325, y: 480 + tambah), withAttributes :normalattributes)
                
                let priceText = String(product.price)
                priceText.draw(at: CGPoint(x: 380, y: 480 + tambah), withAttributes :normalattributes)
                
                let amountText = String(Double((product.transactionQuantity ?? 0)) * product.price)
                amountText.draw(at: CGPoint(x: 480, y: 480 + tambah), withAttributes :normalattributes)
                
                a = tambah
                let number = String(index+1)
                number.draw(at: CGPoint(x: 35, y: 480 + tambah), withAttributes :normalattributes)
                products.remove(at: 0)
                if index == 10{
                    break
                }
            }
            
            let data = "To"
            data.draw(at: CGPoint(x: 20, y: 160), withAttributes : normalattributes)
            
            let titikdua1 = ":"
            titikdua1.draw(at: CGPoint(x: 140, y: 160), withAttributes : normalattributes)
            
            let CompanyName = "Company Name"
            CompanyName.draw(at: CGPoint(x: 20, y: 180), withAttributes : normalattributes)
            
            let titikdua2 = ":"
            titikdua2.draw(at: CGPoint(x: 140, y: 180), withAttributes : normalattributes)
            
            let Address = "Address"
            Address.draw(at: CGPoint(x: 20, y: 200), withAttributes : normalattributes)
            
            let titikdua3 = ":"
            titikdua3.draw(at: CGPoint(x: 140, y: 200), withAttributes : normalattributes)
            
            let PhoneNumber = "Phone Number"
            PhoneNumber.draw(at: CGPoint(x: 20, y: 220), withAttributes : normalattributes)
            
            let titikdua4 = ":"
            titikdua4.draw(at: CGPoint(x: 140, y: 220), withAttributes : normalattributes)
            
            let Email = "Email"
            Email.draw(at: CGPoint(x: 20, y: 240), withAttributes : normalattributes)
            
            let titikdua5 = ":"
            titikdua5.draw(at: CGPoint(x: 140, y: 240), withAttributes : normalattributes)
            
            let TransactionTitle = "Transaction Title"
            TransactionTitle.draw(at: CGPoint(x: 20, y: 260), withAttributes : boldattributes)
            
            let titikdua6 = ":"
            titikdua6.draw(at: CGPoint(x: 140, y: 260), withAttributes : normalattributes)
            
            let Pages = "Pages"
            Pages.draw(at: CGPoint(x: 20, y: 280), withAttributes : boldattributes)
            
            let titikdua7 = ":"
            titikdua7.draw(at: CGPoint(x: 140, y: 280), withAttributes : normalattributes)
            
            let JumlahPages = numberpage + " Pages"
            JumlahPages.draw(at: CGPoint(x: 150, y: 280), withAttributes : boldattributes)
            
                let We = "We would like to confirm we have received your payment"
                We.draw(at: CGPoint(x: 20, y: 320), withAttributes : receipt)
                
                let Amount = "Amount"
                Amount.draw(at: CGPoint(x: 20, y: 360), withAttributes : receipt)
                
                let say = "Say"
                say.draw(at: CGPoint(x: 20, y: 400), withAttributes : receipt)
                
                let order = "Order : "
                order.draw(at: CGPoint(x: 20, y: 440), withAttributes : receipt)
                
            
            
            // setting tampilan table
            let Nomor = "NO"
            Nomor.draw(at: CGPoint(x: 30, y: 460), withAttributes : boldattributes)
            
            let ProductName = "Product Name"
            ProductName.draw(at: CGPoint(x: 90, y: 460), withAttributes : boldattributes)
            
            let Unit = "Unit"
            Unit.draw(at: CGPoint(x: 240, y: 460), withAttributes : boldattributes)
            
            let Qty = "Qty"
            Qty.draw(at: CGPoint(x: 320, y: 460), withAttributes : boldattributes)
            
            let UnitPrice = "Unit Price"
            UnitPrice.draw(at: CGPoint(x: 390, y: 450), withAttributes : boldattributes)
            
            let IDR1 = "(IDR)"
            IDR1.draw(at: CGPoint(x: 407, y: 470), withAttributes : boldattributes)
            
            Amount.draw(at: CGPoint(x: 500, y: 450), withAttributes : boldattributes)
            
            let IDR2 = "(IDR)"
            IDR2.draw(at: CGPoint(x: 507, y: 470), withAttributes : boldattributes)
                
            
            let line = UIBezierPath()
                line.move(to: CGPoint(x: 20, y: 490))
                line.addLine(to: CGPoint(x: 590, y: 490))
                line.stroke()
                
                let totalyOffset = a - 100
                
                print("sini2")
                print(totalyOffset)
                
                
            
            let toclient = addTitle(pageRect: pageRect)
            let companyname = addName(pageRect: pageRect)
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
            var cPage1_1 = 0
            var dPage1_1 = 0
            var ePage1_1 = 0
            var fPage1_1 = 0
            
            
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
            
            let Thanks = "Thank you for your purchase"
            Thanks.draw(at: CGPoint(x: 20, y: 660), withAttributes : boldattributes)
            
            let Sincerely = "Sincerely,"
            Sincerely.draw(at: CGPoint(x: 20, y: 680), withAttributes : boldattributes)
        
        }
        //2 1/2 halaman
        else if products.count >= 27 && products.count <= 34 {
            context.beginPage()
            
            x = 3
            let numberpage = String(x)
            var a = 0
            var c = 0
            var d = 0
            var e = 0
            var f = 0
            var index = 0
            var index3 = 0
            var index4 = 0
            var index5 = 0
            var index6 = 0
            
            let Numbertext = "Number : "
            Numbertext.draw(at: CGPoint(x: 440, y: 75), withAttributes :normalattributes)
            
            for (index, product) in products.enumerated() {
                let tambah = a + 20
                let productText = product.name
                productText.draw(at: CGPoint(x: 90, y: 480 + tambah), withAttributes :normalattributes)
                
                let unitText = product.unit ?? "n/a"
                unitText.draw(at: CGPoint(x: 235, y: 480 + tambah), withAttributes :normalattributes)
                
                let quantityText = String(product.transactionQuantity ?? 0)
                quantityText.draw(at: CGPoint(x: 325, y: 480 + tambah), withAttributes :normalattributes)
                
                let priceText = String(product.price)
                priceText.draw(at: CGPoint(x: 380, y: 480 + tambah), withAttributes :normalattributes)
                
                let amountText = String(Double((product.transactionQuantity ?? 0)) * product.price)
                amountText.draw(at: CGPoint(x: 480, y: 480 + tambah), withAttributes :normalattributes)
                
                a = tambah
                let number = String(index+1)
                number.draw(at: CGPoint(x: 35, y: 480 + tambah), withAttributes :normalattributes)
                products.remove(at: 0)
                if index == 10{
                    break
                }
            }
            
            let data = "To"
            data.draw(at: CGPoint(x: 20, y: 160), withAttributes : normalattributes)
            
            let titikdua1 = ":"
            titikdua1.draw(at: CGPoint(x: 140, y: 160), withAttributes : normalattributes)
            
            let CompanyName = "Company Name"
            CompanyName.draw(at: CGPoint(x: 20, y: 180), withAttributes : normalattributes)
            
            let titikdua2 = ":"
            titikdua2.draw(at: CGPoint(x: 140, y: 180), withAttributes : normalattributes)
            
            let Address = "Address"
            Address.draw(at: CGPoint(x: 20, y: 200), withAttributes : normalattributes)
            
            let titikdua3 = ":"
            titikdua3.draw(at: CGPoint(x: 140, y: 200), withAttributes : normalattributes)
            
            let PhoneNumber = "Phone Number"
            PhoneNumber.draw(at: CGPoint(x: 20, y: 220), withAttributes : normalattributes)
            
            let titikdua4 = ":"
            titikdua4.draw(at: CGPoint(x: 140, y: 220), withAttributes : normalattributes)
            
            let Email = "Email"
            Email.draw(at: CGPoint(x: 20, y: 240), withAttributes : normalattributes)
            
            let titikdua5 = ":"
            titikdua5.draw(at: CGPoint(x: 140, y: 240), withAttributes : normalattributes)
            
            let TransactionTitle = "Transaction Title"
            TransactionTitle.draw(at: CGPoint(x: 20, y: 260), withAttributes : boldattributes)
            
            let titikdua6 = ":"
            titikdua6.draw(at: CGPoint(x: 140, y: 260), withAttributes : normalattributes)
            
            let Pages = "Pages"
            Pages.draw(at: CGPoint(x: 20, y: 280), withAttributes : boldattributes)
            
            let titikdua7 = ":"
            titikdua7.draw(at: CGPoint(x: 140, y: 280), withAttributes : normalattributes)
            
            let JumlahPages = numberpage + " Pages"
            JumlahPages.draw(at: CGPoint(x: 150, y: 280), withAttributes : boldattributes)
            
                let We = "We would like to confirm we have received your payment"
                We.draw(at: CGPoint(x: 20, y: 320), withAttributes : receipt)
                
                let Amount = "Amount"
                Amount.draw(at: CGPoint(x: 20, y: 360), withAttributes : receipt)
                
                let say = "Say"
                say.draw(at: CGPoint(x: 20, y: 400), withAttributes : receipt)
                
                let order = "Order : "
                order.draw(at: CGPoint(x: 20, y: 440), withAttributes : receipt)
                
            
            
            // setting tampilan table
            let Nomor = "NO"
            Nomor.draw(at: CGPoint(x: 30, y: 460), withAttributes : boldattributes)
            
            let ProductName = "Product Name"
            ProductName.draw(at: CGPoint(x: 90, y: 460), withAttributes : boldattributes)
            
            let Unit = "Unit"
            Unit.draw(at: CGPoint(x: 240, y: 460), withAttributes : boldattributes)
            
            let Qty = "Qty"
            Qty.draw(at: CGPoint(x: 320, y: 460), withAttributes : boldattributes)
            
            let UnitPrice = "Unit Price"
            UnitPrice.draw(at: CGPoint(x: 390, y: 450), withAttributes : boldattributes)
            
            let IDR1 = "(IDR)"
            IDR1.draw(at: CGPoint(x: 407, y: 470), withAttributes : boldattributes)
            
            Amount.draw(at: CGPoint(x: 500, y: 450), withAttributes : boldattributes)
            
            let IDR2 = "(IDR)"
            IDR2.draw(at: CGPoint(x: 507, y: 470), withAttributes : boldattributes)
                
            
            let line = UIBezierPath()
                line.move(to: CGPoint(x: 20, y: 490))
                line.addLine(to: CGPoint(x: 590, y: 490))
                line.stroke()
            
            let toclient = addTitle(pageRect: pageRect)
            let companyname = addName(pageRect: pageRect)
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
                amountText.draw(at: CGPoint(x: 480, y: 290 + tambah), withAttributes :normalattributes)
                
                aPage2 = tambah
                let number = String(index+1)
                number.draw(at: CGPoint(x: 35, y: 200 + tambah), withAttributes :normalattributes)
                products.remove(at: 0)
                if index == 34{
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
            print(set)
            
            let Total = "Total"
            Total.draw(at: CGPoint(x: 400, y: 460 + set), withAttributes : boldattributes)

            let Discount = "Discount"
            Discount.draw(at: CGPoint(x: 400, y: 480 + set), withAttributes : boldattributes)
                
            let PPN = "PPN 10%"
            PPN.draw(at: CGPoint(x: 400, y: 500 + set), withAttributes : boldattributes)
            
            let GrandTotal = "Grand Total"
            GrandTotal.draw(at: CGPoint(x: 400, y: 520 + set), withAttributes : boldattributes)
            
            
            context.beginPage()
            
            let Thanks = "Thank you for your purchase"
            Thanks.draw(at: CGPoint(x: 20, y: 660), withAttributes : boldattributes)
            
            let Sincerely = "Sincerely,"
            Sincerely.draw(at: CGPoint(x: 20, y: 680), withAttributes : boldattributes)

            
            //add data ke PDF
            
            let documentName3 = addDocument(pageRect: pageRect)
//            let logo2 = addImage(pageRect: pageRect)
            let company3 = addCompany(pageRect: pageRect)
            let address3 = addCompanyAddress(pageRect: pageRect)
            let phone3 = addCompanyContact(pageRect: pageRect)
            let email3 = addCompanyEmail(pageRect: pageRect)
        }
        // halaman 3
        else if products.count >= 35 && products.count <= 50 {
            context.beginPage()
            
            x = 3
            let numberpage = String(x)
            var a = 0
            var c = 0
            var d = 0
            var e = 0
            var f = 0
            var index = 0
            var index3 = 0
            var index4 = 0
            var index5 = 0
            var index6 = 0
            
            let Numbertext = "Number : "
            Numbertext.draw(at: CGPoint(x: 440, y: 75), withAttributes :normalattributes)
            
            for (index, product) in products.enumerated() {
                let tambah = a + 20
                let productText = product.name
                productText.draw(at: CGPoint(x: 90, y: 480 + tambah), withAttributes :normalattributes)
                
                let unitText = product.unit ?? "n/a"
                unitText.draw(at: CGPoint(x: 235, y: 480 + tambah), withAttributes :normalattributes)
                
                let quantityText = String(product.transactionQuantity ?? 0)
                quantityText.draw(at: CGPoint(x: 325, y: 480 + tambah), withAttributes :normalattributes)
                
                let priceText = String(product.price)
                priceText.draw(at: CGPoint(x: 380, y: 480 + tambah), withAttributes :normalattributes)
                
                let amountText = String(Double((product.transactionQuantity ?? 0)) * product.price)
                amountText.draw(at: CGPoint(x: 480, y: 480 + tambah), withAttributes :normalattributes)
                
                a = tambah
                let number = String(index+1)
                number.draw(at: CGPoint(x: 35, y: 480 + tambah), withAttributes :normalattributes)
                products.remove(at: 0)
                if index == 10{
                    break
                }
            }
            
            let data = "To"
            data.draw(at: CGPoint(x: 20, y: 160), withAttributes : normalattributes)
            
            let titikdua1 = ":"
            titikdua1.draw(at: CGPoint(x: 140, y: 160), withAttributes : normalattributes)
            
            let CompanyName = "Company Name"
            CompanyName.draw(at: CGPoint(x: 20, y: 180), withAttributes : normalattributes)
            
            let titikdua2 = ":"
            titikdua2.draw(at: CGPoint(x: 140, y: 180), withAttributes : normalattributes)
            
            let Address = "Address"
            Address.draw(at: CGPoint(x: 20, y: 200), withAttributes : normalattributes)
            
            let titikdua3 = ":"
            titikdua3.draw(at: CGPoint(x: 140, y: 200), withAttributes : normalattributes)
            
            let PhoneNumber = "Phone Number"
            PhoneNumber.draw(at: CGPoint(x: 20, y: 220), withAttributes : normalattributes)
            
            let titikdua4 = ":"
            titikdua4.draw(at: CGPoint(x: 140, y: 220), withAttributes : normalattributes)
            
            let Email = "Email"
            Email.draw(at: CGPoint(x: 20, y: 240), withAttributes : normalattributes)
            
            let titikdua5 = ":"
            titikdua5.draw(at: CGPoint(x: 140, y: 240), withAttributes : normalattributes)
            
            let TransactionTitle = "Transaction Title"
            TransactionTitle.draw(at: CGPoint(x: 20, y: 260), withAttributes : boldattributes)
            
            let titikdua6 = ":"
            titikdua6.draw(at: CGPoint(x: 140, y: 260), withAttributes : normalattributes)
            
            let Pages = "Pages"
            Pages.draw(at: CGPoint(x: 20, y: 280), withAttributes : boldattributes)
            
            let titikdua7 = ":"
            titikdua7.draw(at: CGPoint(x: 140, y: 280), withAttributes : normalattributes)
            
            let JumlahPages = numberpage + " Pages"
            JumlahPages.draw(at: CGPoint(x: 150, y: 280), withAttributes : boldattributes)
            
                let We = "We would like to confirm we have received your payment"
                We.draw(at: CGPoint(x: 20, y: 320), withAttributes : receipt)
                
                let Amount = "Amount"
                Amount.draw(at: CGPoint(x: 20, y: 360), withAttributes : receipt)
                
                let say = "Say"
                say.draw(at: CGPoint(x: 20, y: 400), withAttributes : receipt)
                
                let order = "Order : "
                order.draw(at: CGPoint(x: 20, y: 440), withAttributes : receipt)
                
            
            
            // setting tampilan table
            let Nomor = "NO"
            Nomor.draw(at: CGPoint(x: 30, y: 460), withAttributes : boldattributes)
            
            let ProductName = "Product Name"
            ProductName.draw(at: CGPoint(x: 90, y: 460), withAttributes : boldattributes)
            
            let Unit = "Unit"
            Unit.draw(at: CGPoint(x: 240, y: 460), withAttributes : boldattributes)
            
            let Qty = "Qty"
            Qty.draw(at: CGPoint(x: 320, y: 460), withAttributes : boldattributes)
            
            let UnitPrice = "Unit Price"
            UnitPrice.draw(at: CGPoint(x: 390, y: 450), withAttributes : boldattributes)
            
            let IDR1 = "(IDR)"
            IDR1.draw(at: CGPoint(x: 407, y: 470), withAttributes : boldattributes)
            
            Amount.draw(at: CGPoint(x: 500, y: 450), withAttributes : boldattributes)
            
            let IDR2 = "(IDR)"
            IDR2.draw(at: CGPoint(x: 507, y: 470), withAttributes : boldattributes)
                
            
            let line = UIBezierPath()
                line.move(to: CGPoint(x: 20, y: 490))
                line.addLine(to: CGPoint(x: 590, y: 490))
                line.stroke()
            
            let toclient = addTitle(pageRect: pageRect)
            let companyname = addName(pageRect: pageRect)
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
                if index == 34{
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
            print(set)
            
            
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
            var cPage1_1 = 0
            var dPage1_1 = 0
            var ePage1_1 = 0
            var fPage1_1 = 0
            
            
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
            
            let Thanks = "Thank you for your purchase"
            Thanks.draw(at: CGPoint(x: 20, y: 520 + set1_1), withAttributes : boldattributes)
            
            let Sincerely = "Sincerely,"
            Sincerely.draw(at: CGPoint(x: 20, y: 540 + set1_1), withAttributes : boldattributes)
        }
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
        string: Title,
        attributes: titleAttributes
      )
      // 4
      let titleStringSize = attributedTitle.size()
      // 5
      let titleStringRect = CGRect(
        x: 160,
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
        y: 160,
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
        y: 220,
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
        y: 240,
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
        y: 200,
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
        y: 180,
        width: titleStringSize.width,
        height: titleStringSize.height
      )
      attributedTitle.draw(in: titleStringRect)
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
        string: "Receipt",
        attributes: titleAttributes
      )
      // 4
      let titleStringSize = attributedTitle.size()
      // 5
      let titleStringRect = CGRect(
        x: 440,
        y: 40,
        width: titleStringSize.width,
        height: titleStringSize.height
      )
      // 6
      attributedTitle.draw(in: titleStringRect)
      // 7
      return titleStringRect.origin.y + titleStringRect.size.height
    }
    

// Atur gambar
    /*func addImage(pageRect: CGRect) -> CGFloat {
      // 1
      let maxHeight = pageRect.height * 0.1
      let maxWidth = pageRect.width * 0.2
      // 2
      let aspectWidth = maxWidth / image.size.width
      let aspectHeight = maxHeight / image.size.height
      let aspectRatio = min(aspectWidth, aspectHeight)
      // 3
      let scaledWidth = image.size.width * aspectRatio
      let scaledHeight = image.size.height * aspectRatio
      // 4
//      let imageX = (pageRect.width - scaledWidth) / 2.0
      let imageRect = CGRect(
        x: 20,
        y: 15,
        width: scaledWidth,
        height: scaledHeight)
      // 5
      image.draw(in: imageRect)
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


