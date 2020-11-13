//
//  Transaction.swift
//  BusyBoss
//
//  Created by Yafet Sutanto on 06/11/20.
//

import Foundation
import CloudKit

public struct Transaction {
    var recordID: CKRecord.ID?
    var transactionNumber: String
    var user: User
    var description: String
    var status: TransactionStatus
    var approval: TransactionApproval
    var products: [Product]?
    var client: Client?
    var discount: Double?
    var tax: Double?
    
    static let keyTransactionNumber = ""
    static let keyDescription = ""
    static let keyStatus = ""
    static let keyDiscount = 0.0
    static let keyTax = 0.0
    
    func getTotalProductPrices() -> Double {
        var total: Double = 0
        
        for product in products ?? []{
            total += product.price
        }
        return total
    }
}

extension Transaction {
    init(record: CKRecord) {
        let recordID = record.recordID
        let transactionNumber = ""
        let user = User.currentUser()
        let description = ""
        let discount = 0.0
        let tax = 0.0
        
        var status:TransactionStatus
        
        switch record["status"] as? String ?? "" {
        case TransactionStatus.Ongoing.rawValue:
            status = TransactionStatus.Ongoing
        case TransactionStatus.Canceled.rawValue:
            status = TransactionStatus.Canceled
        case TransactionStatus.Completed.rawValue:
            status = TransactionStatus.Completed
        default:
            status = TransactionStatus.Undefined
        }
        
        var approval: TransactionApproval
        
        switch record["approval"] as? String ?? "" {
        case TransactionApproval.Approved.rawValue:
            approval = TransactionApproval.Approved
        case TransactionApproval.Rejected.rawValue:
            approval = TransactionApproval.Rejected
        default:
            approval = TransactionApproval.Undefined
        }
        
        self.init(recordID: recordID, transactionNumber: transactionNumber, user: user!, description: description, status: status, approval: approval, discount: discount, tax: tax)
    }
    

}

public enum TransactionStatus : String {
    case Ongoing
    case Canceled
    case Completed
    case Undefined
}

public enum TransactionApproval : String {
    case Approved
    case Rejected
    case Undefined
}
