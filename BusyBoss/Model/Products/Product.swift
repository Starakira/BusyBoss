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
    var recordID: CKRecord.ID
    var name: String
    var price: Double
    var quantity: Int
    var image: UIImage?
    var type: ProductType
}

extension Product {
    init(record: CKRecord) {
        let recordID = record.recordID
        let name = record["productName"] as? String ?? "Name not defined"
        let price = record["productPrice"] as? Double ?? 0
        let quantity = record["productQuantity"] as? Int ?? 0
        let typeName = record["productType"] as? String ?? ProductType.undefined.rawValue
        
        var type: ProductType
        
        switch typeName {
        case ProductType.goods.rawValue:
            type = ProductType.goods
        case ProductType.service.rawValue:
            type = ProductType.service
        default:
            type = ProductType.undefined
        }
        
        self.init(recordID: recordID, name: name, price: price, quantity: quantity, type: type)
    }
}

enum ProductType: String {
    case goods
    case service
    case undefined
}
