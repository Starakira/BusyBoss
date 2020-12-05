//
//  CreateInvoicePDF.swift
//  BusyBoss
//
//  Created by Andre Marines ado Tena Uak on 30/11/20.
//

import UIKit

class CreateInvoicePDF: NSObject {
    
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

    func createFlyer() -> Data {
        

        let pdfMetaData = [
          kCGPDFContextCreator: "Flyer Builder",
          kCGPDFContextAuthor: "raywenderlich.com",
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
        
        
        
        var produk = ["Kacang2Kelinci","Kuaci Sambalado","Kaos Kaki","Baju lengan Panjang","Celana Pendek"/*,"6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62"*/]
        var unit = ["Pieces","Pieces", "Pasang","Piece","Piece","Piece"]
        var data2 = ["5","5","5","5","5"]
        var price = ["100.000.000","100.000","100.000","100.000","100.000"]
        var amount = ["500.000.000","500.000","500.000","500.000","500.000"]
        var term = ["1. Above information is not an invoice and only estimate of service/goods described above.","2. Payment will be collected prior to provision of service/goods described in this quote","3. Payment to BCA 010188888 a/n PT Boss Gak Perlu Repot"/*,"coba","data","lebih","6"*/]
        
        //1 halaman
        if produk.count <= 5 {
            
            context.beginPage()
            
            x = 1
            let numberpage = String(x)
            var a = 0
            var c = 0
            var d = 0
            var e = 0
            var f = 0
            var g = 0
            var index = 0
            var index3 = 0
            var index4 = 0
            var index5 = 0
            var index6 = 0
            
            let Numbertext = "Number : "
            Numbertext.draw(at: CGPoint(x: 440, y: 75), withAttributes :normalattributes)
            
            for Product in produk{
                let tambah = a + 20
                let Numbertext = Product
                Numbertext.draw(at: CGPoint(x: 90, y: 355 + tambah), withAttributes :normalattributes)
                a = tambah
                index += 1
                let number = String(index)
                number.draw(at: CGPoint(x: 35, y: 355 + tambah), withAttributes :normalattributes)
                produk.remove(at: 0)
                    if index == 15{
                        break
                    }
            }
        
        for data in unit{
            let tambah = c + 20
            let Numbertext = data
            Numbertext.draw(at: CGPoint(x: 235, y: 355 + tambah), withAttributes :normalattributes)
            c = tambah
            unit.remove(at: 0)
            index3 += 1
            if index3 == 15{
                break
            }
        }
        
        for data in data2{
            let tambah = d + 20
            let Numbertext = data
            Numbertext.draw(at: CGPoint(x: 325, y: 355 + tambah), withAttributes :normalattributes)
            d = tambah
            data2.remove(at: 0)
            index4 += 1
            if index4 == 15{
                break
            }
        }
        
        for data in price{
            let tambah = e + 20
            let Numbertext = data
            Numbertext.draw(at: CGPoint(x: 380, y: 355 + tambah), withAttributes :normalattributes)
            e = tambah
            price.remove(at: 0)
            index5 += 1
            if index5 == 15{
                break
            }
        }
        
        for data in amount{
            let tambah = f + 20
            let Numbertext = data
            Numbertext.draw(at: CGPoint(x: 480, y: 355 + tambah), withAttributes :normalattributes)
            f = tambah
            amount.remove(at: 0)
            index6 += 1
            if index6 == 15{
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
            
            let totalProduct = produk.count + 1
            
            let yOffset = 20
            let totalyOffset = yOffset * totalProduct
            
        let Total = "Total"
        Total.draw(at: CGPoint(x: 400, y: 455 + totalyOffset), withAttributes : boldattributes)
        
        let Discount = "Discount"
        Discount.draw(at: CGPoint(x: 400, y: 475 + totalyOffset), withAttributes : boldattributes)
        
        let PPN = "PPN 10%"
        PPN.draw(at: CGPoint(x: 400, y: 495 + totalyOffset), withAttributes : boldattributes)
        
        let GrandTotal = "Grand Total"
        GrandTotal.draw(at: CGPoint(x: 400, y: 515 + totalyOffset), withAttributes : boldattributes)
            
            //add data ke PDF
            let titletransaction = addTitle(pageRect: pageRect)
            let clientname = addClientName(pageRect: pageRect)
            let clientcompanyname = addClientName(pageRect: pageRect)
            let clientphone = addClientPhone(pageRect: pageRect)
            let clientemail = addClientEmail(pageRect: pageRect)
            let clientaddres = addClientAddress(pageRect: pageRect)
            let documentName = addDocument(pageRect: pageRect)
//            let imageBottom = addImage(pageRect: pageRect)
            let company = addCompany(pageRect: pageRect)
            let address = addCompanyAddress(pageRect: pageRect)
            let phone = addCompanyContact(pageRect: pageRect)
            let email = addCompanyEmail(pageRect: pageRect)
            
            if term.count <= 3 {
                
                for Term in term {
                    let tambah = g + 20
                    let Numbertext = Term
                    Numbertext.draw(at: CGPoint(x: 20, y: 560 + tambah), withAttributes :normalattributes)
                    g = tambah
                }
                
                // setting terms
                    
                let valid = "Please make your payment before:"
                valid.draw(at: CGPoint(x: 20, y: 540),withAttributes : validattributes)

                let Terms = "Terms and Condition :"
                Terms.draw(at: CGPoint(x: 20, y: 565), withAttributes : normalattributes)

                //setting tanda tangan
                    let geser = g - 60
                    

                let Sincerely = "Sincerely,"
                Sincerely.draw(at: CGPoint(x: 20, y: 660 + geser), withAttributes : boldattributes)


            }else if term.count >= 10{
                context.beginPage()
                
                for Term in term {
                    let tambah = g + 20
                    let Numbertext = Term
                    Numbertext.draw(at: CGPoint(x: 20, y: 200 + tambah), withAttributes :normalattributes)
                    g = tambah
                }

                Numbertext.draw(at: CGPoint(x: 200, y: 75), withAttributes :normalattributes)

                let titletransaction = addTitle(pageRect: pageRect)
                let clientname = addClientName(pageRect: pageRect)
                let clientcompanyname = addClientName(pageRect: pageRect)
                let clientphone = addClientPhone(pageRect: pageRect)
                let clientemail = addClientEmail(pageRect: pageRect)
                let clientaddres = addClientAddress(pageRect: pageRect)
                let documentName = addDocument(pageRect: pageRect)
//                let imageBottom = addImage(pageRect: pageRect)
                let company = addCompany(pageRect: pageRect)
                let address = addCompanyAddress(pageRect: pageRect)
                let phone = addCompanyContact(pageRect: pageRect)
                let email = addCompanyEmail(pageRect: pageRect)

                // setting terms


                let valid = "Please make your payment before:"
                valid.draw(at: CGPoint(x: 20, y: 180 ),withAttributes : validattributes)

                let Terms = "Terms and Condition :"
                Terms.draw(at: CGPoint(x: 20, y: 200 ), withAttributes : normalattributes)

            //setting tanda tangan
                let geser1 = g - 60

                let Sincerely = "Sincerely,"
                Sincerely.draw(at: CGPoint(x: 20, y: 300 + geser1), withAttributes : boldattributes)

            }
      
        // 1 1/2 halaman
        } else if produk.count >= 6 && produk.count <= 15{
            
            context.beginPage()
            
            x = 2
            let numberpage = String(x)
            var a = 0
            var c = 0
            var d = 0
            var e = 0
            var f = 0
            var g = 0
            var index = 0
            var index3 = 0
            var index4 = 0
            var index5 = 0
            var index6 = 0
            
            for Product in produk{
                let tambah = a + 20
                let Numbertext = Product
                Numbertext.draw(at: CGPoint(x: 90, y: 360 + tambah), withAttributes :normalattributes)
                a = tambah
                index += 1
                let number = String(index)
                number.draw(at: CGPoint(x: 35, y: 360 + tambah), withAttributes :normalattributes)
                produk.remove(at: 0)
                    if index == 15{
                        break
                    }
            }
            

            
            for data in unit{
                let tambah = c + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 235, y: 360 + tambah), withAttributes :normalattributes)
                c = tambah
                unit.remove(at: 0)
                index3 += 1
                if index3 == 15{
                    break
                }
            }
            
            for data in data2{
                let tambah = d + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 325, y: 360 + tambah), withAttributes :normalattributes)
                d = tambah
                data2.remove(at: 0)
                index4 += 1
                if index4 == 15{
                    break
                }
            }
            
            for data in price{
                let tambah = e + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 380, y: 360 + tambah), withAttributes :normalattributes)
                e = tambah
                price.remove(at: 0)
                index5 += 1
                if index5 == 15{
                    break
                }
            }
            
            for data in amount{
                let tambah = f + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 480, y: 360 + tambah), withAttributes :normalattributes)
                f = tambah
                amount.remove(at: 0)
                index6 += 1
                if index6 == 15{
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
            let documentName = addDocument(pageRect: pageRect)
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
            
            // setting terms
            
            
            let valid = "Please make your payment before:"
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
     
            let Sincerely = "Sincerely,"
            Sincerely.draw(at: CGPoint(x: 20, y: 300 + geser), withAttributes : boldattributes)

        }
        
        
        
        // 2 halaman
        else if produk.count >= 16 && produk.count <= 26{
            context.beginPage()
            x = 2
            let numberpage = String(x)
            var a = 0
            var c = 0
            var d = 0
            var e = 0
            var f = 0
            var g = 0
            var index = 0
            var index3 = 0
            var index4 = 0
            var index5 = 0
            var index6 = 0
            
            for Product in produk{
                let tambah = a + 20
                let Numbertext = Product
                Numbertext.draw(at: CGPoint(x: 90, y: 360 + tambah), withAttributes :normalattributes)
                a = tambah
                index += 1
                let number = String(index)
                number.draw(at: CGPoint(x: 35, y: 360 + tambah), withAttributes :normalattributes)
                produk.remove(at: 0)
                    if index == 15{
                        break
                    }
            
            }
            
            
            for data in unit{
                let tambah = c + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 235, y: 360 + tambah), withAttributes :normalattributes)
                c = tambah
                unit.remove(at: 0)
                index3 += 1
                if index3 == 15{
                    break
                }
            }
            
            for data in data2{
                let tambah = d + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 325, y: 360 + tambah), withAttributes :normalattributes)
                d = tambah
                data2.remove(at: 0)
                index4 += 1
                if index4 == 15{
                    break
                }
            }
            
            for data in price{
                let tambah = e + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 380, y: 360 + tambah), withAttributes :normalattributes)
                e = tambah
                price.remove(at: 0)
                index5 += 1
                if index5 == 15{
                    break
                }
            }
            
            for data in amount{
                let tambah = f + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 480, y: 360 + tambah), withAttributes :normalattributes)
                f = tambah
                amount.remove(at: 0)
                index6 += 1
                if index6 == 15{
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
            
            
            for Product in produk{
                let tambah = aPage1_1 + 20
                let Numbertext = Product
                Numbertext.draw(at: CGPoint(x: 90, y: 200 + tambah), withAttributes :normalattributes)
                aPage1_1 = tambah
                index += 1
                let number = String(index)
                number.draw(at: CGPoint(x: 35, y: 200 + tambah), withAttributes :normalattributes)
                produk.remove(at: 0)
                    if index == 26{
                        break
                    }
            }
            
            for data in unit{
                let tambah = cPage1_1 + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 235, y: 360 + tambah), withAttributes :normalattributes)
                cPage1_1 = tambah
                unit.remove(at: 0)
                index3 += 1
                if index3 == 26{
                    break
                }
            }
            
            for data in data2{
                let tambah = dPage1_1 + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 325, y: 360 + tambah), withAttributes :normalattributes)
                dPage1_1 = tambah
                data2.remove(at: 0)
                index4 += 1
                if index4 == 26{
                    break
                }
            }
            
            for data in price{
                let tambah = ePage1_1 + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 380, y: 360 + tambah), withAttributes :normalattributes)
                ePage1_1 = tambah
                price.remove(at: 0)
                index5 += 1
                if index5 == 26{
                    break
                }
            }
            
            for data in amount{
                let tambah = fPage1_1 + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 480, y: 360 + tambah), withAttributes :normalattributes)
                fPage1_1 = tambah
                amount.remove(at: 0)
                index6 += 1
                if index6 == 26{
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
            
            if produk.count <= 26 && term.count <= 10{
                
                let yTrem = aPage1_1 + 340
                for Term in term {
                    let tambah = g + 20
                    let Numbertext = Term
                    Numbertext.draw(at: CGPoint(x: 20, y: yTrem + tambah), withAttributes :normalattributes)
                    g = tambah
                }
                
                // setting terms
                let yValid = yTrem - 20
                let valid = "Please make your payment before:"
                valid.draw(at: CGPoint(x: 20, y: yValid),withAttributes : validattributes)

                let Terms = "Terms and Condition :"
                Terms.draw(at: CGPoint(x: 20, y: yValid + 20), withAttributes : normalattributes)

                //setting tanda tangan
                    let geser = g - 60
                    
                let yTTD = yTrem + 85
                let Sincerely = "Sincerely,"
                Sincerely.draw(at: CGPoint(x: 20, y: 15 +  yTTD + geser), withAttributes : boldattributes)

            }else if produk.count == 26 && term.count <= 3{
                
                
                let yTrem = aPage1_1 + 340
                for Term in term {
                    let tambah = g + 20
                    let Numbertext = Term
                    Numbertext.draw(at: CGPoint(x: 20, y: yTrem + tambah), withAttributes :normalattributes)
                    g = tambah
                }
                
                // setting terms
                let yValid = yTrem - 20
                let valid = "Please make your payment before:"
                valid.draw(at: CGPoint(x: 20, y: yValid),withAttributes : validattributes)

                let Terms = "Terms and Condition :"
                Terms.draw(at: CGPoint(x: 20, y: yValid + 20), withAttributes : normalattributes)

                //setting tanda tangan
                    let geser = g - 60
                    
                let yTTD = yTrem + 85

                let Sincerely = "Sincerely,"
                Sincerely.draw(at: CGPoint(x: 20, y: 15 +  yTTD + geser), withAttributes : boldattributes)
                
            }
        
        }
        //2 1/2 halaman
        else if produk.count >= 27 && produk.count <= 39 {
            context.beginPage()
            
            x = 3
            let numberpage = String(x)
            var a = 0
            var c = 0
            var d = 0
            var e = 0
            var f = 0
            var g = 0
            var index = 0
            var index3 = 0
            var index4 = 0
            var index5 = 0
            var index6 = 0
            
            for Product in produk{
                let tambah = a + 20
                let Numbertext = Product
                Numbertext.draw(at: CGPoint(x: 90, y: 360 + tambah), withAttributes :normalattributes)
                a = tambah
                index += 1
                let number = String(index)
                number.draw(at: CGPoint(x: 35, y: 360 + tambah), withAttributes :normalattributes)
                produk.remove(at: 0)
                    if index == 15{
                        break
                    }
            
        }
            
            for data in unit{
                let tambah = c + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 235, y: 360 + tambah), withAttributes :normalattributes)
                c = tambah
                unit.remove(at: 0)
                index3 += 1
                if index3 == 15{
                    break
                }
            }
            
            for data in data2{
                let tambah = d + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 325, y: 360 + tambah), withAttributes :normalattributes)
                d = tambah
                data2.remove(at: 0)
                index4 += 1
                if index4 == 15{
                    break
                }
            }
            
            for data in price{
                let tambah = e + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 380, y: 360 + tambah), withAttributes :normalattributes)
                e = tambah
                price.remove(at: 0)
                index5 += 1
                if index5 == 15{
                    break
                }
            }
            
            for data in amount{
                let tambah = f + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 480, y: 360 + tambah), withAttributes :normalattributes)
                f = tambah
                amount.remove(at: 0)
                index6 += 1
                if index6 == 15{
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
            for Product in produk{
                let tambah = aPage2 + 20
                let Numbertext = Product
                Numbertext.draw(at: CGPoint(x: 90, y: 200 + tambah), withAttributes :normalattributes)
                aPage2 = tambah
                index += 1
                let number = String(index)
                number.draw(at: CGPoint(x: 35, y: 200 + tambah), withAttributes :normalattributes)
                produk.remove(at: 0)
                    if index == 39{
                        break
                    }
            
            }
            
            for data in unit{
                let tambah = c + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 235, y: 200 + tambah), withAttributes :normalattributes)
                c = tambah
                unit.remove(at: 0)
                index3 += 1
                if index3 == 39{
                    break
                }
            }
            
            for data in data2{
                let tambah = d + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 325, y: 200 + tambah), withAttributes :normalattributes)
                d = tambah
                data2.remove(at: 0)
                index4 += 1
                if index4 == 39{
                    break
                }
            }
            
            for data in price{
                let tambah = e + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 380, y: 200 + tambah), withAttributes :normalattributes)
                e = tambah
                price.remove(at: 0)
                index5 += 1
                if index5 == 39{
                    break
                }
            }
            
            for data in amount{
                let tambah = f + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 480, y: 200 + tambah), withAttributes :normalattributes)
                f = tambah
                amount.remove(at: 0)
                index6 += 1
                if index6 == 39{
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
            let valid = "Please make your payment before:"
            valid.draw(at: CGPoint(x: 20, y: 240),withAttributes : validattributes)

            let Terms = "Terms and Condition :"
            Terms.draw(at: CGPoint(x: 20, y: 265), withAttributes : normalattributes)

            //setting tanda tangan
                let set2 = g - 60
            let Sincerely = "Sincerely,"
            Sincerely.draw(at: CGPoint(x: 20, y: 380 + set2), withAttributes : boldattributes)

            //add data ke PDF
            
            let documentName3 = addDocument(pageRect: pageRect)
//            let logo2 = addImage(pageRect: pageRect)
            let company3 = addCompany(pageRect: pageRect)
            let address3 = addCompanyAddress(pageRect: pageRect)
            let phone3 = addCompanyContact(pageRect: pageRect)
            let email3 = addCompanyEmail(pageRect: pageRect)
        }
        // halaman 3
        else if produk.count >= 40 && produk.count <= 50 {
            //Page 1
            context.beginPage()
            
            x = 3
            let numberpage = String(x)
            var a = 0
            var c = 0
            var d = 0
            var e = 0
            var f = 0
            var g = 0
            var index = 0
            var index3 = 0
            var index4 = 0
            var index5 = 0
            var index6 = 0
            
            for Product in produk{
                let tambah = a + 20
                let Numbertext = Product
                Numbertext.draw(at: CGPoint(x: 90, y: 360 + tambah), withAttributes :normalattributes)
                a = tambah
                index += 1
                let number = String(index)
                number.draw(at: CGPoint(x: 35, y: 360 + tambah), withAttributes :normalattributes)
                produk.remove(at: 0)
                    if index == 15{
                        break
                    }
                
            }
            
            
            for data in unit{
                let tambah = c + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 235, y: 360 + tambah), withAttributes :normalattributes)
                c = tambah
                unit.remove(at: 0)
                index3 += 1
                if index3 == 15{
                    break
                }
            }
            
            for data in data2{
                let tambah = d + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 325, y: 360 + tambah), withAttributes :normalattributes)
                d = tambah
                data2.remove(at: 0)
                index4 += 1
                if index4 == 15{
                    break
                }
            }
            
            for data in price{
                let tambah = e + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 380, y: 360 + tambah), withAttributes :normalattributes)
                e = tambah
                price.remove(at: 0)
                index5 += 1
                if index5 == 15{
                    break
                }
            }
            
            for data in amount{
                let tambah = f + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 480, y: 360 + tambah), withAttributes :normalattributes)
                f = tambah
                amount.remove(at: 0)
                index6 += 1
                if index6 == 15{
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
            for Product in produk{
                let tambah = aPage2 + 20
                let Numbertext = Product
                Numbertext.draw(at: CGPoint(x: 90, y: 200 + tambah), withAttributes :normalattributes)
                aPage2 = tambah
                index += 1
                let number = String(index)
                number.draw(at: CGPoint(x: 35, y: 200 + tambah), withAttributes :normalattributes)
                produk.remove(at: 0)
                    if index == 39{
                        break
                    }
            
            }
            
            
            for data in unit{
                let tambah = c + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 235, y: 200 + tambah), withAttributes :normalattributes)
                c = tambah
                unit.remove(at: 0)
                index3 += 1
                if index3 == 39{
                    break
                }
            }
            
            for data in data2{
                let tambah = d + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 325, y: 200 + tambah), withAttributes :normalattributes)
                d = tambah
                data2.remove(at: 0)
                index4 += 1
                if index4 == 39{
                    break
                }
            }
            
            for data in price{
                let tambah = e + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 380, y: 200 + tambah), withAttributes :normalattributes)
                e = tambah
                price.remove(at: 0)
                index5 += 1
                if index5 == 39{
                    break
                }
            }
            
            for data in amount{
                let tambah = f + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 480, y: 200 + tambah), withAttributes :normalattributes)
                f = tambah
                amount.remove(at: 0)
                index6 += 1
                if index6 == 39{
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
            var cPage1_1 = 0
            var dPage1_1 = 0
            var ePage1_1 = 0
            var fPage1_1 = 0
            
            
            for Product in produk{
                let tambah = aPage1_1 + 20
                let Numbertext = Product
                Numbertext.draw(at: CGPoint(x: 90, y: 200 + tambah), withAttributes :normalattributes)
                aPage1_1 = tambah
                index += 1
                let number = String(index)
                number.draw(at: CGPoint(x: 35, y: 200 + tambah), withAttributes :normalattributes)
                produk.remove(at: 0)
                    if index == 62{
                        break
                    }
            }
            
            for data in unit{
                let tambah = cPage1_1 + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 235, y: 360 + tambah), withAttributes :normalattributes)
                cPage1_1 = tambah
                unit.remove(at: 0)
                index3 += 1
                if index3 == 62{
                    break
                }
            }
            
            for data in data2{
                let tambah = dPage1_1 + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 325, y: 360 + tambah), withAttributes :normalattributes)
                dPage1_1 = tambah
                data2.remove(at: 0)
                index4 += 1
                if index4 == 62{
                    break
                }
            }
            
            for data in price{
                let tambah = ePage1_1 + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 380, y: 360 + tambah), withAttributes :normalattributes)
                ePage1_1 = tambah
                price.remove(at: 0)
                index5 += 1
                if index5 == 62{
                    break
                }
            }
            
            for data in amount{
                let tambah = fPage1_1 + 20
                let Numbertext = data
                Numbertext.draw(at: CGPoint(x: 480, y: 360 + tambah), withAttributes :normalattributes)
                fPage1_1 = tambah
                amount.remove(at: 0)
                index6 += 1
                if index6 == 62{
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
            
            if produk.count <= 40 && term.count <= 10{
                
                let yTrem = aPage1_1 + 340
                for Term in term {
                    let tambah = g + 20
                    let Numbertext = Term
                    Numbertext.draw(at: CGPoint(x: 20, y: yTrem + tambah), withAttributes :normalattributes)
                    g = tambah
                }
                
                // setting terms
                let yValid = yTrem - 20
                let valid = "Please make your payment before:"
                valid.draw(at: CGPoint(x: 20, y: yValid),withAttributes : validattributes)

                let Terms = "Terms and Condition :"
                Terms.draw(at: CGPoint(x: 20, y: yValid + 20), withAttributes : normalattributes)

                //setting tanda tangan
                    let geser = g - 60
                    
                let yTTD = yTrem + 85

                let Sincerely = "Sincerely,"
                Sincerely.draw(at: CGPoint(x: 20, y: 15 +  yTTD + geser), withAttributes : boldattributes)

            }else if produk.count == 50 && term.count <= 3{
                
                
                let yTrem = aPage1_1 + 340
                for Term in term {
                    let tambah = g + 20
                    let Numbertext = Term
                    Numbertext.draw(at: CGPoint(x: 20, y: yTrem + tambah), withAttributes :normalattributes)
                    g = tambah
                }
                
                // setting terms
                let yValid = yTrem - 20
                let valid = "Please make your payment before:"
                valid.draw(at: CGPoint(x: 20, y: yValid),withAttributes : validattributes)

                let Terms = "Terms and Condition :"
                Terms.draw(at: CGPoint(x: 20, y: yValid + 20), withAttributes : normalattributes)

                //setting tanda tangan
                    let geser = g - 60
                    
                let yTTD = yTrem + 85

                let Sincerely = "Sincerely,"
                Sincerely.draw(at: CGPoint(x: 20, y: 15 +  yTTD + geser), withAttributes : boldattributes)
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
        x: 160,
        y: 180,
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
        x: 160,
        y: 195,
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
        string: ClientnName,
        attributes: titleAttributes
      )
      let titleStringSize = attributedTitle.size()
      let titleStringRect = CGRect(
        x: 160,
        y: 195,
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
        string: ClientnName,
        attributes: titleAttributes
      )
      let titleStringSize = attributedTitle.size()
      let titleStringRect = CGRect(
        x: 160,
        y: 195,
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
        string: ClientnName,
        attributes: titleAttributes
      )
      let titleStringSize = attributedTitle.size()
      let titleStringRect = CGRect(
        x: 160,
        y: 195,
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
        string: "Invoice",
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

