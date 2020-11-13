//
//  CloudKitManager.swift
//  Busy Boss
//
//  Created by Muhammad Bangun Agung on 15/10/20.
//

import Foundation
import CloudKit

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
    
    let clientFirstNameKey = "clientFirstName"
    let clientLastNameKey = "clientLastName"
    let clientEmailAddressKey = "clientEmailAddress"
    let clientCompanyNameKey = "clientCompanyName"
    let clientCompanyAddressKey = "clientCompanyAddress"
    let clientPhoneNoKey = "clientPhoneNo"
    
    private static var sharedDatabaseManager: CloudKitManager  = {
      let cloudkitManager = CloudKitManager()
      return cloudkitManager
    }()
    
    static func shared() -> CloudKitManager {
        return sharedDatabaseManager
    }
    
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
        operation.desiredKeys = [emailAddressKey, passwordKey]
        
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
    
    func addProduct(productName: String, productPrice: Double, productQuantity: Int, completionHandler: @escaping () -> Void){
        
        let productRecord = CKRecord(recordType: "Product")
        let userRecord = CKRecord(recordType: "User")
        let userReference = CKRecord.Reference(record: userRecord, action: CKRecord_Reference_Action.deleteSelf)
        
        productRecord.setValue(productName, forKey: productNameKey)
        productRecord.setValue(productPrice, forKey: productPriceKey)
        productRecord.setValue(productQuantity, forKey: productQuantityKey)
        
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
    
    func addClient(clientFirstName: String, clientLastName: String, clientEmailAddress: String, clientCompanyName: String, clientCompanyAddress: String, clientPhoneNo: String, completionHandler: @escaping () -> Void){
        
        let clientRecord = CKRecord(recordType: "Client")
        
        clientRecord.setValue(clientFirstName, forKey: clientFirstNameKey)
        clientRecord.setValue(clientLastName, forKey: clientLastNameKey)
        clientRecord.setValue(clientEmailAddress, forKey: clientEmailAddressKey)
        clientRecord.setValue(clientCompanyName, forKey: clientCompanyNameKey)
        clientRecord.setValue(clientCompanyAddress, forKey: clientCompanyAddressKey)
        clientRecord.setValue(clientPhoneNo, forKey: clientPhoneNoKey)
        
        publicDatabase.save(clientRecord) {(savedRecord, error) in
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
    
    func addTransaction(transactionCode: String, transactionUser: String, transactionDescription: String, transactionStatus: String, transactionTotalValue: Double, transactionStockNumber: Int, transactionGoodName: String, transactionClientPhoneNumber: String, transactionClientAddress: String, transactionClientCompanyName: String, transactionServiceName: String, completionHandler: @escaping () -> Void){
        
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
    
    func showAllClients(clientFirstName: String, clientLastName: String, clientCompanyName: String, clientCompanyAddress: String, clientEmailAddress: String, clientPhoneNo: String){
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Client", predicate: predicate)
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = [clientFirstNameKey, clientLastNameKey, clientCompanyNameKey, clientCompanyAddressKey,clientEmailAddressKey, clientPhoneNoKey]
        clientsFirstName.removeAll()
        clientsLastName.removeAll()
        clientsCompanyName.removeAll()
        clientsCompanyAddress.removeAll()
        clientsEmailAddress.removeAll()
        clientsPhoneNo.removeAll()
        operation.recordFetchedBlock = {record in
            clientsFirstName.append(record[self.clientFirstNameKey]!)
            clientsLastName.append(record[self.clientLastNameKey]!)
            clientsCompanyName.append(record[self.clientCompanyNameKey]!)
            clientsCompanyAddress.append(record[self.clientCompanyAddressKey]!)
            clientsEmailAddress.append(record[self.clientEmailAddressKey]!)
            clientsPhoneNo.append(record[self.clientPhoneNoKey]!)
        }
        operation.queryCompletionBlock = {cursor, error in
            DispatchQueue.main.async {
                print(clientsFirstName)
                print(clientsLastName)
                print(clientsCompanyName)
                print(clientsCompanyAddress)
                print(clientsEmailAddress)
                print(clientsPhoneNo)
            }
        }
        
        publicDatabase.add(operation)
    }
    
    func showAllTransactions(transactionCode: String, transactionUser: String, transactionDescription: String, transactionStatus: String, transactionTotalValue: Double, transactionStockNumber: Int, transactionGoodName: String, transactionClientPhoneNumber: String, transactionClientAddress: String, transactionClientCompanyName: String, transactionServiceName: String){
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Transaction", predicate: predicate)
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = ["clientFirstNameKey", "clientLastNameKey", "clientCompanyNameKey", "clientCompanyAddressKey","clientEmailAddressKey", "clientPhoneNoKey"]
        transactionCodes.removeAll()
        transactionUsers.removeAll()
        transactionDescriptions.removeAll()
        transactionStatuses.removeAll()
        transactionTotalValues.removeAll()
        transactionStockNumbers.removeAll()
        transactionGoodNames.removeAll()
        transactionClientPhoneNumbers.removeAll()
        transactionClientAddresses.removeAll()
        transactionClientCompanyNames.removeAll()
        transactionServiceNames.removeAll()
        operation.recordFetchedBlock = {record in
            transactionCodes.append(record[self.clientFirstNameKey]!)
            transactionUsers.append(record[self.clientFirstNameKey]!)
            transactionDescriptions.append(record[self.clientFirstNameKey]!)
            transactionStatuses.append(record[self.clientFirstNameKey]!)
            transactionTotalValues.append(record[self.clientFirstNameKey]!)
            transactionStockNumbers.append(record[self.clientFirstNameKey]!)
            transactionGoodNames.append(record[self.clientFirstNameKey]!)
            transactionClientPhoneNumbers.append(record[self.clientFirstNameKey]!)
            transactionClientAddresses.append(record[self.clientFirstNameKey]!)
            transactionClientCompanyNames.append(record[self.clientFirstNameKey]!)
            transactionServiceNames.append(record[self.clientFirstNameKey]!)
        }
        operation.queryCompletionBlock = {cursor, error in
            DispatchQueue.main.async {
                print(clientsFirstName)
                print(clientsLastName)
                print(clientsCompanyName)
                print(clientsCompanyAddress)
                print(clientsEmailAddress)
                print(clientsPhoneNo)
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
