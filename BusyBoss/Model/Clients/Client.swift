//
//  Client.swift
//  BusyBoss
//
//  Created by Yafet Sutanto on 06/11/20.
//

import Foundation
import CloudKit
import UIKit

public struct Client {
    var recordID:CKRecord.ID?
    var image: UIImage?
    var firstName:String
    var lastName:String
    var emailAddress:String
    var phoneNumber:String
    var companyName:String
    var companyAddress:String
    
    static let keyImage = "clientImage"
    static let keyFirstName = "clientFirstName"
    static let keyLastName = "clientLastName"
    static let keyEmailAddress = "clientEmailAddress"
    static let keyPhoneNo = "clientPhoneNo"
    static let keyCompanyName = "clientCompanyName"
    static let keyCompanyAddress = "clientCompanyAddress"
}

extension Client {
    init(record: CKRecord) {
        let recordID = record.recordID
        let firstName = record[Client.keyFirstName] as? String ?? "No First Name"
        let lastName = record[Client.keyLastName] as? String ?? "No Last Name"
        let emailAddress = record[Client.keyEmailAddress] as? String ?? "No Email Address"
        let phoneNumber = record[Client.keyPhoneNo] as? String ?? "No Phone  Number"
        let companyName = record[Client.keyCompanyName] as? String ?? "No Company"
        let companyAddress = record[Client.keyCompanyAddress] as? String ?? "No Company Address"
        let image = record[Client.keyImage] as? UIImage ?? #imageLiteral(resourceName: "shiba icon new")
        
        self.init(recordID: recordID, image: image, firstName: firstName, lastName: lastName, emailAddress: emailAddress, phoneNumber: phoneNumber, companyName: companyName, companyAddress: companyAddress)
    }
}
