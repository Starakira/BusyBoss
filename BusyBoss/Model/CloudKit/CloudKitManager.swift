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
    
    private static var sharedDatabaseManager: CloudKitManager  = {
        let cloudkitManager = CloudKitManager()
        return cloudkitManager
    }()
    
    static func shared() -> CloudKitManager {
        return sharedDatabaseManager
    }
    
    // MARK: - User Functions
    func userCreate(user: User, completionHandler: @escaping (_ recordID: CKRecord.ID? ,_ error: Error?) -> Void){
        
        let userRecord = CKRecord(recordType: "User")
        
        userRecord.setValue(user.firstName, forKey: User.keyFirstName)
        userRecord.setValue(user.lastName, forKey: User.keyLastName)
        userRecord.setValue(user.email, forKey: User.keyEmail)
        userRecord.setValue(user.password, forKey: User.keyPassword)
        userRecord.setValue(user.phoneNumber, forKey: User.keyPhoneNumber)
        
        publicDatabase.save(userRecord) {(savedRecord, error) in
            DispatchQueue.main.async {
                completionHandler(savedRecord?.recordID ,error);
            }
        }
    }
    
    func authenticateUser(emailAddress: String, password: String, completionHandler: @escaping (_ currentUser: CKRecord?, _ error: Error?) -> Void) {
        let predicateEmail = NSPredicate(format: "\(User.keyEmail) = %@", emailAddress)
        let predicatePassword = NSPredicate(format: "\(User.keyPassword) = %@", password)
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateEmail, predicatePassword])
        let query = CKQuery(recordType: "User", predicate: predicate)
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
    
//    func authenticateUserUsingSignInWithApple(user: User, credentials: ASAuthorizationAppleIDCredential, completionHandler: @escaping (_ user: User?,_ error: Error?) -> Void) {
//
//        let predicateEmail = NSPredicate(format: "\(emailAddressKey) = %@", user.email)
//        let query = CKQuery(recordType: userRecordType, predicate: predicateEmail)
//        let operation = CKQueryOperation(query: query)
//        //operation.desiredKeys = [emailAddressKey, passwordKey]
//
//        var user:User?
//
//        operation.recordFetchedBlock = {record in
//            user = User(record: record)
//        }
//
//        operation.queryCompletionBlock = {cursor, error in
//            DispatchQueue.main.async {
//                completionHandler(user ,error)
//            }
//        }
//
//        publicDatabase.add(operation)
//    }

    func productCreate(product: Product, completionHandler: @escaping () -> Void){
        
        let productRecord = CKRecord(recordType: "Product")
        let userRecord = CKRecord(recordType: "User")
        let userReference = CKRecord.Reference(record: userRecord, action: CKRecord_Reference_Action.deleteSelf)
        
        productRecord.setValue(product.name, forKey: Product.keyName)
        productRecord.setValue(product.price, forKey: Product.keyPrice)
        productRecord.setValue(product.quantity, forKey: Product.keyQuantity)
        productRecord.setValue(product.type, forKey: Product.keyType)
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
    
    func productsFetchAll(completionHandler: @escaping (_ result: [Product], _ error: Error?) -> Void){
        let reference = CKRecord.Reference(recordID: (User.currentUser()?.recordID)!, action: CKRecord_Reference_Action.none)
        let predicate = NSPredicate(format: "\(Product.keyUserReference) = %@", reference)
        let query = CKQuery(recordType: "Product", predicate: predicate)
        let operation = CKQueryOperation(query: query)
        
        var products:[Product] = []
        
        operation.recordFetchedBlock = {record in
            let newProduct = Product(record: record)
            products.append(newProduct)
        }
        
        operation.queryCompletionBlock = {cursor, error in
            DispatchQueue.main.async {
                completionHandler(products, error)
            }
        }
        publicDatabase.add(operation)
    }
    
    func productEdit(product: Product, completionHandler: @escaping () -> Void){
        
        let productRecord = CKRecord(recordType: "Product", recordID: product.recordID!)
        
        productRecord.setValue(product.name, forKey: Product.keyName)
        productRecord.setValue(product.price, forKey: Product.keyPrice)
        productRecord.setValue(product.quantity, forKey: Product.keyQuantity)
        productRecord.setValue(product.type, forKey: Product.keyType)
        
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
    
    func productDelete(product: Product, completionHandler: @escaping (_ recordID: CKRecord.ID?, _ error: Error?) -> Void){
        publicDatabase.delete(withRecordID: product.recordID!) { (recordID, error) in
            DispatchQueue.main.async {
                completionHandler(recordID ,error);
            }
        }
    }
    
    // MARK: - Client Functions
    
    func clientCreate(client: Client, completionHandler: @escaping (_ recordID: CKRecord.ID? ,_ error: Error?) -> Void){
        
        var clientRecord = CKRecord(recordType: "Client")
        let userReference = CKRecord.Reference(recordID: (User.currentUser()?.recordID)!, action: CKRecord_Reference_Action.deleteSelf)
        
        //If Client already exist in database
        if let clientRecordID = client.recordID {
            clientRecord = CKRecord(recordType: "Client", recordID: clientRecordID)
        }
        
        clientRecord.setValue(client.firstName, forKey: Client.keyFirstName)
        clientRecord.setValue(client.lastName, forKey: Client.keyLastName)
        clientRecord.setValue(client.emailAddress, forKey: Client.keyEmailAddress)
        clientRecord.setValue(client.companyName, forKey: Client.keyCompanyName)
        clientRecord.setValue(client.companyAddress, forKey: Client.keyCompanyAddress)
        clientRecord.setValue(client.phoneNumber, forKey: Client.keyPhoneNumber)
        clientRecord.setValue(userReference, forKey: "userReference")
        
        if let clientImage = client.image {
            let asset = ImageManager.convertToCKAsset(image: clientImage)
            clientRecord.setValue(asset, forKey: Client.keyImage)
        }
        
        publicDatabase.save(clientRecord) {(savedRecord, error) in
            DispatchQueue.main.async {
                completionHandler(savedRecord?.recordID ,error);
            }
        }
    }
    
    func clientsFetchAll(completionHandler: @escaping (_ result: [Client], _ error: Error?) -> Void){
        
        let reference = CKRecord.Reference(recordID: (User.currentUser()?.recordID)!, action: CKRecord_Reference_Action.none)
        let predicate = NSPredicate(format: "\(Client.keyUserReference) = %@", reference)
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
    
    func clientEdit(client: Client, completionHandler: @escaping (_ recordID: CKRecord.ID? ,_ error: Error?) -> Void){
        
        let clientRecord = CKRecord(recordType: "Client", recordID: client.recordID!)
        
        clientRecord.setValue(client.firstName, forKey: Client.keyFirstName)
        clientRecord.setValue(client.lastName, forKey: Client.keyLastName)
        clientRecord.setValue(client.emailAddress, forKey: Client.keyEmailAddress)
        clientRecord.setValue(client.companyName, forKey: Client.keyCompanyName)
        clientRecord.setValue(client.companyAddress, forKey: Client.keyCompanyAddress)
        clientRecord.setValue(client.phoneNumber, forKey: Client.keyPhoneNumber)
        
        if let clientImage = client.image {
            let data = clientImage.pngData();
            let url = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(NSUUID().uuidString+".dat")!
            do {
                try data!.write(to: url)
            } catch let e as NSError {
                print("Error! \(e.localizedDescription)");
            }
            clientRecord.setValue(CKAsset(fileURL: url), forKey: Client.keyImage)
        }
        
        let modifyOperation = CKModifyRecordsOperation(recordsToSave: [clientRecord])
        
        modifyOperation.modifyRecordsCompletionBlock = { editedRecord, editedRecordID, error in
            DispatchQueue.main.async {
                completionHandler(editedRecordID?.first, error)
            }
        }
        
        publicDatabase.add(modifyOperation)
    }
    
    func clientDelete(client: Client, completionHandler: @escaping (_ recordID: CKRecord.ID?, _ error: Error?) -> Void){
        publicDatabase.delete(withRecordID: client.recordID!) { (recordID, error) in
            DispatchQueue.main.async {
                completionHandler(recordID ,error);
            }
        }
    }
    
    // MARK: - Transaction Functions
    func transactionCreate(transaction: Transaction, completionHandler: @escaping (_  recordID: CKRecord.ID?, _ error: Error?) -> Void){
        
        let transactionRecord = CKRecord(recordType: "Transaction")
        let userReference = CKRecord.Reference(recordID: transaction.user.recordID!, action: CKRecord_Reference_Action.deleteSelf)
        let clientReference = CKRecord.Reference(recordID: transaction.client!.recordID!, action: CKRecord_Reference_Action.none)
        
        var productRecordIDs:[CKRecord.ID] = []
        
        for product in transaction.products ?? []{
            productRecordIDs.append(product.recordID!)
        }
        
        transactionRecord.setValue(transaction.transactionNumber, forKey: Transaction.keyTransactionNumber)
        transactionRecord.setValue(transaction.description, forKey: Transaction.keyDescription)
        transactionRecord.setValue(transaction.status.rawValue, forKey: Transaction.keyStatus)
        transactionRecord.setValue(transaction.discount, forKey: Transaction.keyDiscount)
        transactionRecord.setValue(transaction.tax, forKey: Transaction.keyTax)
        transactionRecord.setValue(transaction.validityDate, forKey: Transaction.keyValidityDate)
        transactionRecord.setValue(userReference, forKey: "userReference")
        transactionRecord.setValue(clientReference, forKey: "clientReference")
        transactionRecord.setValue(productRecordIDs, forKey: "productReferenceList")
        
        publicDatabase.save(transactionRecord) {(savedRecord, error) in
            if error != nil{
                print(error!.localizedDescription)
            }
            else{
                DispatchQueue.main.async {
                    completionHandler(savedRecord?.recordID, error);
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
    /*
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
    */

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
