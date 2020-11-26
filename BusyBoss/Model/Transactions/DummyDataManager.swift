//
//  DummyDataManager.swift
//  Busy Boss
//
//  Created by Ryan Anslyno Khohari on 21/10/20.
//

import Foundation
import UIKit
public class DummyDataManager {
    var Dummy : [DummyDataTransaction]
    init() {
        let Dummy1 = DummyDataTransaction(transactionCode: 666, transactionUser: "bang jago", transactionDescription: "Tumbas kacang", transactionStatus: "OnGoing", transactionTotalValue: 999000, transactionStockNumber: 10, transactionGoodName: "Kacang2Kelinci", transactionImage: #imageLiteral(resourceName: "Foruminity_Logo_Icon"), transactionClientPhoneNumber: "14045", transactionClientAddress: "Candi Borobudur", transactionClientCompanyName: "Koplak Jaya", transactionServiceName: "Cukur Bulu Kaki")
        
        let Dummy2 = DummyDataTransaction(transactionCode: 999, transactionUser: "mas yus", transactionDescription: "kaos kaki", transactionStatus: "canceled", transactionTotalValue: 899000, transactionStockNumber: 9, transactionGoodName: "Kuaci Sambalado", transactionImage: #imageLiteral(resourceName: "EXPp0EPVAAERD2A.jpeg"), transactionClientPhoneNumber: "14022", transactionClientAddress: "Candi Prambanan", transactionClientCompanyName: "CV. Darsono", transactionServiceName: "Tukang Cuci Piring")
        
        Dummy = []
        Dummy.append(Dummy1)
        Dummy.append(Dummy2)
    }
}
