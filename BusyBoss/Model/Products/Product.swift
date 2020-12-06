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
    var image: UIImage?
    var name: String
    var description: String
    var price: Double
    var stock: Int?
    var unit: String?
    var transactionQuantity: Int?
    
    var type: ProductType
    
    static let keyImage = "image"
    static let keyName = "name"
    static let keyDescription = "description"
    static let keyPrice = "price"
    static let keyStock = "stock"
    static let keyUnit = "unit"
    static let keyType = "type"
    static let keyUserReference = "userReference"
}

extension Product {
    init(record: CKRecord) {
        let recordID = record.recordID
        let name = record[Product.keyName] as? String ?? "Name not defined"
        let description = record[Product.keyDescription] as? String ?? "No description"
        let price = record[Product.keyPrice] as? Double ?? 0
        let stock = record[Product.keyStock] as? Int ?? 0
        let unit = record[Product.keyUnit] as? String ?? "Unit not defined"
        let typeName = record[Product.keyType] as? String ?? ProductType.undefined.rawValue
        let image = ImageManager.convertToUIImage(file: record[Product.keyImage] as? CKAsset) ?? #imageLiteral(resourceName: "BusyBoss_Logo")
        
        var type: ProductType
        
        switch typeName.lowercased() {
        case ProductType.goods.rawValue:
            type = ProductType.goods
        case ProductType.services.rawValue:
            type = ProductType.services
        default:
            type = ProductType.undefined
        }
        
        self.init(recordID: recordID, image: image, name: name, description: description, price: price, stock: stock, unit: unit, type: type)
    }
}

enum ProductType: String {
    case goods
    case services
    case undefined
}
