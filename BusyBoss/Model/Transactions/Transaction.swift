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
    var description: String
    var status: TransactionStatus
    var approval: TransactionApproval
    var products: [Product]?
    var productReferences: [CKRecord.Reference]?
    var client: Client?
    var validityDate: Date
    var discount: Double?
    var tax: Double?
    var value: Double
    
    static let keyTransactionNumber = "transactionNumber"
    static let keyDescription = "description"
    static let keyApproval = "approval"
    static let keyStatus = "status"
    static let keyDiscount = "discount"
    static let keyTax = "tax"
    static let keyValidityDate = "validityDate"
    static let keyUserReference = "userReference"
    static let keyClientReference = "clientReference"
    static let keyProductReferences = "productReferenceList"
    static let keyValue = "value"
    
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
        let transactionNumber = record[Transaction.keyTransactionNumber] as? String ?? "No Transaction Number"
        let description = record[Transaction.keyDescription] as? String ?? "No Description"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let validityDate = record[Transaction.keyValidityDate] as? Date ?? dateFormatter.date(from: "00/00/0000")
        
        let discount = record[Transaction.keyDiscount] as? Double ?? 0.0
        let tax = record[Transaction.keyTax] as? Double ?? 0.0
        
        let value = record[Transaction.keyValue] as? Double ?? 0.0
        
        let productReferences = record["productReferenceList"] as? [CKRecord.Reference] ?? []
        
        let statusName = record[Transaction.keyStatus] as? String ?? TransactionStatus.ongoing.rawValue
        let approvalName = record[Transaction.keyApproval] as? String ?? TransactionApproval.pending.rawValue
        
        var status:TransactionStatus
        
        switch statusName.lowercased() {
        case TransactionStatus.ongoing.rawValue:
            status = TransactionStatus.ongoing
        case TransactionStatus.canceled.rawValue:
            status = TransactionStatus.canceled
        case TransactionStatus.completed.rawValue:
            status = TransactionStatus.completed
        default:
            status = TransactionStatus.undefined
        }
        
        var approval: TransactionApproval
        
        switch approvalName.lowercased() {
        case TransactionApproval.approved.rawValue:
            approval = TransactionApproval.approved
        case TransactionApproval.rejected.rawValue:
            approval = TransactionApproval.rejected
        default:
            approval = TransactionApproval.pending
        }
        
        self.init(recordID: recordID, transactionNumber: transactionNumber, description: description, status: status, approval: approval, productReferences: productReferences, validityDate: validityDate ?? Date(), discount: discount, tax: tax, value: value)
    }
}

public enum TransactionStatus : String {
    case ongoing
    case canceled
    case completed
    case undefined
}

public enum TransactionApproval : String {
    case approved
    case rejected
    case pending
}
