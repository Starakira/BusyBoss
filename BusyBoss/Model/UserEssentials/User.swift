//
//  User.swift
//  login
//
//  Created by richard santoso on 14/10/20.
//  Copyright © 2020 richard santoso. All rights reserved.
//

import Foundation
import AuthenticationServices
import CloudKit

struct User {
    let recordID: CKRecord.ID?
    let firstName: String
    let lastName: String
    let email: String
    
    private static var user: User?
    
    static let keyFirstName = "firstName"
    static let keyLastName = "lastName"
    static let keyEmail = "emailAddress"
    static let keyPassword = "password"
    
    static func currentUser() -> User? {
        return user
    }
    
    static func setCurrentUser(user: User) {
        self.user = user
    }
}

extension User {
    init(credentials: ASAuthorizationAppleIDCredential){
        let firstName = credentials.fullName?.givenName ?? ""
        let lastName = credentials.fullName?.familyName ?? ""
        let email = credentials.email ?? ""
        
        self.init(recordID: nil, firstName: firstName, lastName: lastName, email: email)
    }
    
    init(record: CKRecord) {
        let recordID = record.recordID
        let firstName = record[User.keyFirstName] as? String ?? "No First Name"
        let lastName = record[User.keyLastName] as? String ?? "No Last Name"
        let email = record[User.keyEmail] as? String ?? "No Email"
        
        self.init(recordID: recordID, firstName: firstName, lastName: lastName, email: email)
    }
}

extension User: CustomDebugStringConvertible {
    var debugDescription: String {
        return """
        Fist Name: \(firstName)
        Last Name: \(lastName)
        Email: \(email)
        """
    }
}
