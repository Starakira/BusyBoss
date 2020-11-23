//
//  CloudKitError.swift
//  BusyBoss
//
//  Created by Yafet Sutanto on 22/11/20.
//

import Foundation
import CloudKit

class CloudKitError {
    
    static func getUserFriendlyDescription(error: Error) -> String {
        let nsError = error as! CKError
        
        switch nsError.code {
        case CKError.Code.networkUnavailable:
            return "Internet not avaliable. Please check your internet connection.\nError Code: \(nsError.code.rawValue)"
        case CKError.Code.permissionFailure:
            return "Access to database denied.\nError Code: \(nsError.code.rawValue)"
        default:
            return "The operation could not be completed.\nError Code: \(nsError.code.rawValue)"
        }
    }
}
