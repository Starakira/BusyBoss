//
//  goodsStructManager.swift
//  Busy Boss
//
//  Created by richard santoso on 27/10/20.
//

import Foundation
public class goodsStructManager{
    var goods : [goodsStruct]
    init() {
       goods = [
        goodsStruct(
            productName: "ini benda", productPrice: 69000, productImage: #imageLiteral(resourceName: "shiba icon new"), productStock: 69, productUnit: "pieces", description: "hai")
        
        ]
    }
}
