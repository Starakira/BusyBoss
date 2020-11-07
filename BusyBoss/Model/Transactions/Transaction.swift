//
//  Transaction.swift
//  BusyBoss
//
//  Created by Yafet Sutanto on 06/11/20.
//

import Foundation

public struct Transaction {
    var UID:Int
    var user:String
    var description:String
    var status: TransactionStatus
    var products: [Product]?
    var client: Client
}

public enum TransactionStatus : String {
    case Ongoing
    case Canceled
    case Completed
}
