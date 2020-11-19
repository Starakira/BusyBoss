//
//  DummyTransaction.swift
//  BusyBoss
//
//  Created by Muhammad Bangun Agung on 19/11/20.
//

import Foundation
import CloudKit

struct DummyTransaction {
    
    var transactionNumber: String
    var description: String
    var status: TransactionStatus
    var approval: TransactionApproval
    var products: [Product]?
    var client: Client?
    var validityDate: Date
    var discount: Double?
    var tax: Double?
    var transactionTotalPrice: Double
}

public enum DummyTransactionStatus : String {
    case Ongoing
    case Canceled
    case Completed
    case Undefined
}

public enum DummyTransactionApproval : String {
    case Approved
    case Rejected
    case Undefined
}
