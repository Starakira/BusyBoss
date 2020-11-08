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
    var user:User
    var description:String
    var status: TransactionStatus
    var products: [Product]?
    var client: Client?
    
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
        let user = User.currentUser()
        let description = ""
        
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
        
        self.init(recordID: recordID, user: user!, description: description, status: status)
    }
    

}

public enum TransactionStatus : String {
    case Ongoing
    case Canceled
    case Completed
    case Undefined
}
