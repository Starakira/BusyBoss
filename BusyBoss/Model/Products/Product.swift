//
//  Product.swift
//  BusyBoss
//
//  Created by Yafet Sutanto on 04/11/20.
//

import Foundation
import UIKit
import CloudKit

public struct Product {
    var recordID: CKRecord.ID?
    var name: String
    var price: Double
    var quantity: Int
    var transactionQuantity: Int?
    var image: UIImage?
    var type: ProductType
    
    static let keyImage = "image"
    static let keyName = "name"
    static let keyPrice = "price"
    static let keyQuantity = "quantity"
    static let keyType = "type"
    static let keyUserReference = "userReference"
}

extension Product {
    init(record: CKRecord) {
        let recordID = record.recordID
        let name = record[Product.keyName] as? String ?? "Name not defined"
        let price = record[Product.keyPrice] as? Double ?? 0
        let quantity = record[Product.keyQuantity] as? Int ?? 0
        let typeName = record[Product.keyType] as? String ?? ProductType.undefined.rawValue
        
        var type: ProductType
        
        switch typeName.lowercased() {
        case ProductType.goods.rawValue:
            type = ProductType.goods
        case ProductType.services.rawValue:
            type = ProductType.services
        default:
            type = ProductType.undefined
        }
        
        self.init(recordID: recordID, name: name, price: price, quantity: quantity, type: type)
    }
}

enum ProductType: String {
    case goods
    case services
    case undefined
}
