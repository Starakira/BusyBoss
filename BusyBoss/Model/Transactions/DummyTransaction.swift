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

extension DummyTransaction {
    static let shared = DummyTransaction(transactionNumber: "", description: "", status: TransactionStatus.Undefined, approval: TransactionApproval.Undefined, products: [], client: Client.init(recordID: CKRecord.ID(), image: #imageLiteral(resourceName: "shiba icon new"), firstName: "", lastName: "", emailAddress: "", phoneNumber: "", companyName: "", companyAddress: ""), validityDate: Date(), discount: 0.0, tax: 0.0, transactionTotalPrice: 0.0)
    
    private init(transaction: DummyTransaction) {
        let transactionNumber = ""
        let description = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let validityDate = dateFormatter.date(from: "00/00/0000")
        
        let discount = 0.0
        let tax = 0.0
        
        var status: TransactionStatus
        
        switch transaction.status.rawValue {
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
        
        switch transaction.approval.rawValue {
        case TransactionApproval.Approved.rawValue:
            approval = TransactionApproval.Approved
        case TransactionApproval.Rejected.rawValue:
            approval = TransactionApproval.Rejected
        default:
            approval = TransactionApproval.Undefined
        }
        
        let transactionTotalPrice = 0.0
        
        self.init(transactionNumber: transactionNumber, description: description, status: status, approval: approval, validityDate: validityDate!, discount: discount, tax: tax, transactionTotalPrice: transactionTotalPrice)
    }
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
