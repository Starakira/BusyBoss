//
//  CloudKitManager.swift
//  Busy Boss
//
//  Created by Muhammad Bangun Agung on 15/10/20.
//

import Foundation
import CloudKit
import AuthenticationServices

struct CloudKitManager {
    let privateDatabase = CKContainer(identifier: "iCloud.com.developeracademy.Busy-Boss").privateCloudDatabase
    let sharedDatabase = CKContainer(identifier: "iCloud.com.developeracademy.Busy-Boss").sharedCloudDatabase
    let publicDatabase = CKContainer(identifier: "iCloud.com.developeracademy.Busy-Boss").publicCloudDatabase
    
    let userRecordType = "User"
    
    let emailAddressKey = "emailAddress"
    let passwordKey = "password"
    let firstNameKey = "firstName"
    let lastNameKey = "lastName"
    let phoneNoKey = "phoneNo"
    
    let productRecordType = "Product"
    
    let productNameKey = "productName"
    let productPriceKey = "productPrice"
    let productQuantityKey = "productQuantity"
    
    let clientRecordType = "Client"
    
    private static var sharedDatabaseManager: CloudKitManager  = {
        let cloudkitManager = CloudKitManager()
        return cloudkitManager
    }()
    
    static func shared() -> CloudKitManager {
        return sharedDatabaseManager
    }
    
    // MARK: - User Functions
    func addUser(emailAddress: String, password: String, firstName: String, lastName: String, phoneNo:String, completionHandler: @escaping (_ error: Error?) -> Void){
        
        let userRecord = CKRecord(recordType: userRecordType)
        
        userRecord.setValue(firstName, forKey: firstNameKey)
        userRecord.setValue(lastName, forKey: lastNameKey)
        userRecord.setValue(emailAddress, forKey: emailAddressKey)
        userRecord.setValue(password, forKey: passwordKey)
        userRecord.setValue(phoneNo, forKey: phoneNoKey)
        
        publicDatabase.save(userRecord) {(savedRecord, error) in
            DispatchQueue.main.async {
                completionHandler(error);
            }
        }
    }
    
    func authenticateUser(emailAddress: String, password: String, completionHandler: @escaping (_ currentUser: CKRecord?, _ error: Error?) -> Void) {
        let predicateEmail = NSPredicate(format: "\(emailAddressKey) = %@", emailAddress)
        let predicatePassword = NSPredicate(format: "\(passwordKey) = %@", password)
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateEmail, predicatePassword])
        let query = CKQuery(recordType: userRecordType, predicate: predicate)
        let operation = CKQueryOperation(query: query)
        //operation.desiredKeys = [emailAddressKey, passwordKey]
        
        var currentRecord:CKRecord?
        
        operation.recordFetchedBlock = {record in
            currentRecord = record
        }
        
        operation.queryCompletionBlock = {cursor, error in
            DispatchQueue.main.async {
                completionHandler(currentRecord, error)
            }
        }
        
        publicDatabase.add(operation)
    }
    
    func authenticateUserUsingSignInWithApple(user: User, credentials: ASAuthorizationAppleIDCredential, completionHandler: @escaping (_ user: User?,_ error: Error?) -> Void) {
        
        let predicateEmail = NSPredicate(format: "\(emailAddressKey) = %@", user.email)
        let query = CKQuery(recordType: userRecordType, predicate: predicateEmail)
        let operation = CKQueryOperation(query: query)
        //operation.desiredKeys = [emailAddressKey, passwordKey]
        
        var user:User?
        
        operation.recordFetchedBlock = {record in
            user = User(record: record)
        }
        
        operation.queryCompletionBlock = {cursor, error in
            DispatchQueue.main.async {
                completionHandler(user ,error)
            }
        }
        
        publicDatabase.add(operation)
    }
    
    func addProduct(product: Product, completionHandler: @escaping () -> Void){
        
        let productRecord = CKRecord(recordType: "Product")
        let userRecord = CKRecord(recordType: "User")
        let userReference = CKRecord.Reference(record: userRecord, action: CKRecord_Reference_Action.deleteSelf)
        
        productRecord.setValue(product.name, forKey: productNameKey)
        productRecord.setValue(product.price, forKey: productPriceKey)
        productRecord.setValue(product.quantity, forKey: productQuantityKey)
        productRecord.setValue(userReference, forKey: "userReference")
        
        publicDatabase.save(productRecord) {(savedRecord, error) in
            if error != nil{
                print(error!.localizedDescription)
            }
            else{
                DispatchQueue.main.async {
                    completionHandler();
                }
            }
        }
    }
    
    // MARK: - Client Functions
    
    func clientsFetchAll(completionHandler: @escaping (_ result: [Client], _ error: Error?) -> Void){
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Client", predicate: predicate)
        let operation = CKQueryOperation(query: query)
        
        var clients:[Client] = []
        
        operation.recordFetchedBlock = {record in
            let newClient = Client(record: record)
            clients.append(newClient)
        }
        
        operation.queryCompletionBlock = {cursor, error in
            DispatchQueue.main.async {
                completionHandler(clients, error)
            }
        }
        publicDatabase.add(operation)
    }
    
    func clientCreate(client: Client, completionHandler: @escaping (_ recordID: CKRecord.ID? ,_ error: Error?) -> Void){
        
        let clientRecord = CKRecord(recordType: "Client")
        
        clientRecord.setValue(client.firstName, forKey: Client.keyFirstName)
        clientRecord.setValue(client.lastName, forKey: Client.keyLastName)
        clientRecord.setValue(client.emailAddress, forKey: Client.keyEmailAddress)
        clientRecord.setValue(client.companyName, forKey: Client.keyCompanyName)
        clientRecord.setValue(client.companyAddress, forKey: Client.keyCompanyAddress)
        clientRecord.setValue(client.phoneNumber, forKey: Client.keyPhoneNo)
        
        publicDatabase.save(clientRecord) {(savedRecord, error) in
            DispatchQueue.main.async {
                completionHandler(savedRecord?.recordID ,error);
            }
        }
    }
    
    func clientEdit(client: Client, completionHandler: @escaping (_ recordID: CKRecord.ID? ,_ error: Error?) -> Void){
        
        let clientRecord = CKRecord(recordType: "Client", recordID: client.recordID!)
        
        clientRecord.setValue(client.firstName, forKey: Client.keyFirstName)
        clientRecord.setValue(client.lastName, forKey: Client.keyLastName)
        clientRecord.setValue(client.emailAddress, forKey: Client.keyEmailAddress)
        clientRecord.setValue(client.companyName, forKey: Client.keyCompanyName)
        clientRecord.setValue(client.companyAddress, forKey: Client.keyCompanyAddress)
        clientRecord.setValue(client.phoneNumber, forKey: Client.keyPhoneNo)
        
        publicDatabase.save(clientRecord) {(savedRecord, error) in
            DispatchQueue.main.async {
                completionHandler(savedRecord?.recordID ,error);
            }
        }
    }
    
    func clientDelete(client: Client, completionHandler: @escaping (_ recordID: CKRecord.ID?, _ error: Error?) -> Void){
        publicDatabase.delete(withRecordID: client.recordID!) { (recordID, error) in
            DispatchQueue.main.async {
                completionHandler(recordID ,error);
            }
        }
    }
    
    // MARK: - Transaction Functions
    func transactionCreate(transactionCode: String, transactionUser: String, transactionDescription: String, transactionStatus: String, transactionTotalValue: Double, transactionStockNumber: Int, transactionGoodName: String, transactionClientPhoneNumber: String, transactionClientAddress: String, transactionClientCompanyName: String, transactionServiceName: String, completionHandler: @escaping () -> Void){
        
        let transactionRecord = CKRecord(recordType: "Transaction")
        let userRecord = CKRecord(recordType: "User")
        let userReference = CKRecord.Reference(record: userRecord, action: CKRecord_Reference_Action.deleteSelf)
        
        transactionRecord.setValue(transactionCode, forKey: "clientFirstNameKey")
        transactionRecord.setValue(transactionUser, forKey: "clientLastNameKey")
        transactionRecord.setValue(transactionDescription, forKey: "clientEmailAddressKey")
        transactionRecord.setValue(transactionStatus, forKey: "clientCompanyNameKey")
        transactionRecord.setValue(transactionTotalValue, forKey: "clientCompanyAddressKey")
        transactionRecord.setValue(transactionGoodName, forKey: "clientPhoneNoKey")
        transactionRecord.setValue(transactionClientPhoneNumber, forKey: "clientCompanyAddressKey")
        transactionRecord.setValue(transactionClientAddress, forKey: "clientPhoneNoKey")
        transactionRecord.setValue(transactionClientCompanyName, forKey: "clientCompanyAddressKey")
        transactionRecord.setValue(transactionServiceName, forKey: "clientPhoneNoKey")
        
        transactionRecord.setValue(userReference, forKey: "userReference")
        
        publicDatabase.save(transactionRecord) {(savedRecord, error) in
            if error != nil{
                print(error!.localizedDescription)
            }
            else{
                DispatchQueue.main.async {
                    completionHandler();
                }
            }
        }
    }
    
    func transactionsFetchAll(completionHandler: @escaping (_ transactions: [Transaction], _ error: Error?) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Transaction", predicate: predicate)
        let operation = CKQueryOperation(query: query)
        
        var transactions:[Transaction] = []
        
        operation.recordFetchedBlock = {record in
            let transaction =  Transaction(record: record)
            transactions.append(transaction)
        }
        operation.queryCompletionBlock = {cursor, error in
            DispatchQueue.main.async {
                completionHandler(transactions, error)
            }
        }
        
        publicDatabase.add(operation)
    }
    
    // MARK: - Product Functions
    func showAllProduct(productName: String, productPrice: Double, productQuantity: Int) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Product", predicate: predicate)
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = [productNameKey, productPriceKey, productQuantityKey]
        
        productsName.removeAll()
        productsPrice.removeAll()
        productsQuantity.removeAll()
        
        operation.recordFetchedBlock = { record in
            productsName.append(record[self.productNameKey]!)
            productsQuantity.append(record[self.productPriceKey]!)
            productsPrice.append(record[self.productPriceKey]!)
        }
        operation.queryCompletionBlock = {cursor, error in
            DispatchQueue.main.async {
                print(productsName)
                print(productsQuantity)
                print(productsPrice)
            }
        }
        publicDatabase.add(operation)
    }

    /*
     func fetchID(completion: @escaping (String) -> Void){
     
     let query = CKQuery(recordType: "id", predicate: NSPredicate(value: true))//specify record
     
     let operation = CKQueryOperation(query: query)
     operation.desiredKeys = [emailAddress, "password"]
     
     var result: CKRecord?
     
     var user: User?
     
     operation.recordFetchedBlock  = { record in
     result = record
     user = User(name: record.recordID.recordName)
     }
     
     operation.queryCompletionBlock = { (cursor, error) in
     if (error != nil) {
     completion(result?.value(forKey: "emailAdress") as? String ?? "No Name")
     self.delegate?.OnUserFetched(user: user!)
     }
     else{
     print("error")
     }
     }
     
     publicDatabase.add(operation)
     
     }
     */
}
