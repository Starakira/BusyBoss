//
//  User.swift
//  login
//
//  Created by richard santoso on 14/10/20.
//  Copyright © 2020 richard santoso. All rights reserved.
//

import Foundation
import AuthenticationServices

struct CurrentUser {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    
    init(credentials: ASAuthorizationAppleIDCredential){
        self.id = credentials.user
        self.firstName = credentials.fullName?.givenName ?? ""
        self.lastName = credentials.fullName?.familyName ?? ""
        self.email = credentials.email ?? ""
    }
    
}

extension CurrentUser: CustomDebugStringConvertible {
    var debugDescription: String {
        return """
        ID: \(id)
        Fist Name: \(firstName)
        Last Name: \(lastName)
        Email: \(email)
        """
    }
}
