//
//  EncryptionManager.swift
//  BusyBoss
//
//  Created by Yafet Sutanto on 05/12/20.
//

import Foundation
import CryptoKit

class EncryptionManager {
    private static var sharedEncryptionManager: EncryptionManager  = {
        let encryptionManager = EncryptionManager()
        return encryptionManager
    }()
    
    static func shared() -> EncryptionManager {
        return sharedEncryptionManager
    }
    
    func generateEncryptedString(inputString: String) -> String {
        let inputData = Data(inputString.utf8)
        let hashed = SHA256.hash(data: inputData)
        let hashString = hashed.compactMap { String(format: "%02x", $0) }.joined()
        return hashString
    }
}
