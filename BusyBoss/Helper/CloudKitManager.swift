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
    
    func clientFetchOnce(clientID: CKRecord.ID ,completionHandler: @escaping (_ client: Client?, _ error: Error?) -> Void){
        let predicate = NSPredicate(format: "recordID = %@", clientID)
        let query = CKQuery(recordType: "Client", predicate: predicate)
        let operation = CKQueryOperation(query: query)
        
        var client: Client?
        
        operation.recordFetchedBlock = {record in
            client = Client(record: record)
        }
        
        operation.queryCompletionBlock = {cursor, error in
            DispatchQueue.main.async {
                completionHandler(client, error)
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
        
        modifyOperation.savePolicy = CKModifyRecordsOperation.RecordSavePolicy.changedKeys
        
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
        let userReference = CKRecord.Reference(recordID: (User.currentUser()?.recordID)!, action: CKRecord_Reference_Action.deleteSelf)
        let clientReference = CKRecord.Reference(recordID: transaction.client!.recordID!, action: CKRecord_Reference_Action.none)
        
        var productRecordIDs:[CKRecord.ID] = []
        
        for product in transaction.products ?? []{
            productRecordIDs.append(product.recordID!)
        }
        
        var productReferences: [CKRecord.Reference] = []
        
        for productRecord in productRecordIDs {
            let productReference = CKRecord.Reference(recordID: productRecord, action: CKRecord_Reference_Action.none)
            productReferences.append(productReference)
        }
        
        transactionRecord.setValue(transaction.transactionNumber, forKey: Transaction.keyTransactionNumber)
        transactionRecord.setValue(transaction.description, forKey: Transaction.keyDescription)
        transactionRecord.setValue(transaction.status.rawValue, forKey: Transaction.keyStatus)
        transactionRecord.setValue(transaction.validityDate, forKey: Transaction.keyValidityDate)
        transactionRecord.setValue(transaction.discount, forKey: Transaction.keyDiscount)
        transactionRecord.setValue(transaction.tax, forKey: Transaction.keyTax)
        transactionRecord.setValue(transaction.value, forKey: Transaction.keyValue)
        
        transactionRecord.setValue(userReference, forKey: Transaction.keyUserReference)
        transactionRecord.setValue(clientReference, forKey: Transaction.keyClientReference)
        transactionRecord.setValue(productReferences, forKey: Transaction.keyProductReferences)
        
        
        publicDatabase.save(transactionRecord) {(savedRecord, error) in
            DispatchQueue.main.async {
                completionHandler(savedRecord?.recordID, error);
            }
        }
    }
    
    func transactionAddRecordProducts(transaction: Transaction, completionHandler: @escaping (_ error: Error?) -> Void){
        var cloudkitError:Error?
        
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "transactionProductQuantityQueue")
        
        for product in transaction.products ?? []{
            
            group.enter()
            queue.async (group: group){
                let productQuantityPerTransaction = CKRecord(recordType: "Quantity");
                
                let transactionReference = CKRecord.Reference(recordID: transaction.recordID!, action: CKRecord_Reference_Action.deleteSelf)
                
                let productReference = CKRecord.Reference(recordID: product.recordID!, action: CKRecord_Reference_Action.none)
                
                productQuantityPerTransaction.setValue(transactionReference, forKey: "transactionReference")
                productQuantityPerTransaction.setValue(productReference, forKey: "productReference")
                productQuantityPerTransaction.setValue(product.transactionQuantity ?? 0 , forKey: "quantity")
                
                publicDatabase.save(productQuantityPerTransaction) { (savedRecord, error) in
                    group.leave()
                    cloudkitError = error;
                }
            }
            
            if cloudkitError != nil {
                break;
            }
        }
        
        group.notify(queue: .main) {
            completionHandler(cloudkitError);
        }
    }
    
    func transactionsFetchAll(completionHandler: @escaping (_ result: [Transaction], _ error: Error?) -> Void) {
        let reference = CKRecord.Reference(recordID: (User.currentUser()?.recordID)!, action: CKRecord_Reference_Action.none)
        let predicate = NSPredicate(format: "\(Transaction.keyUserReference) = %@", reference)
        let query = CKQuery(recordType: "Transaction", predicate: predicate)
        
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let operation = CKQueryOperation(query: query)
        
        var transactions: [Transaction] = []
        
        operation.recordFetchedBlock = {record in
            let newTransaction = Transaction(record: record)
            transactions.append(newTransaction)
        }
        
        operation.queryCompletionBlock = {cursor, error in
            DispatchQueue.main.async {
                completionHandler(transactions, error)
            }
        }
        publicDatabase.add(operation)
    }
    
    //Fetch only the total price of one transaction. Use this for Transaction Table View Cell
    func transactionFetchTotalPrice(transaction: Transaction, completionHandler: @escaping (_ totalPrice: Float, _ error: Error?) -> Void) {
        var total: Float = 0
        var cloudkitError:Error?
        
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "transactionFetchTotalPrice")
        
        for productReference in transaction.productReferences ?? [] {
            group.enter()
            queue.async (group: group){
                //Fetch only the price of individual product
                var price:Float = 0
                
                let predicate = NSPredicate(format: "recordID = %@", productReference.recordID)
                let query = CKQuery(recordType: "Product", predicate: predicate)
                let operation = CKQueryOperation(query: query)
                operation.desiredKeys = [Product.keyPrice]
                
                operation.recordFetchedBlock = { record in
                    price = record[Product.keyPrice] as? Float ?? 0
                }
                
                operation.queryCompletionBlock = {cursor, error in
                    cloudkitError = error
                    if (error == nil) {
                        group.enter()
                        queue.async (group: group){
                            //Fetch only the quantity of each product present in one transaction
                            transactionFetchProductQuantity(transactionID: transaction.recordID!, productID: productReference.recordID) { (quantity, error) in
                                cloudkitError = error
                                total += (price * Float(quantity))
                                group.leave()
                            }
                        }
                    }
                    group.leave()
                }
            }
            
            if cloudkitError != nil {
                break;
            }
        }
        
        group.notify(queue: .main) {
            completionHandler(total, cloudkitError)
        }
    }
    
    func transactionFetchProductQuantity(transactionID: CKRecord.ID, productID: CKRecord.ID, completionHandler: @escaping (_ totalQuantity: Int, _ error: Error?) -> Void) {
        var total: Int = 0
        
        let predicateTransactionID = NSPredicate(format: "recordID = %@", transactionID)
        let predicateProductID = NSPredicate(format: "recordID = %@", productID)
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateTransactionID, predicateProductID])
        let query = CKQuery(recordType: "Quantity", predicate: predicate)
        let operation = CKQueryOperation(query: query)
        
        operation.recordFetchedBlock = { record in
            total = record["quantity"] as? Int ?? 0
        }
        
        operation.queryCompletionBlock = {cursor, error in
            completionHandler(total, error)
        }
        
        publicDatabase.add(operation)
    }
    
    func transactionFetchClientName(clientID: CKRecord.ID, completionHandler: @escaping (_ clientName: String, _ error: Error?) -> Void){
        var clientName: String = ""
        
        let predicate = NSPredicate(format: "recordID = %@", clientID)
        let query = CKQuery(recordType: "Client", predicate: predicate)
        let operation = CKQueryOperation(query: query)
        
        operation.desiredKeys = [Client.keyFirstName, Client.keyLastName]
        
        operation.recordFetchedBlock = { record in
            clientName = (record["firstName"] as? String ?? "") + (record["lastName"] as? String ?? "")
        }
        
        operation.queryCompletionBlock = {cursor, error in
            DispatchQueue.main.async {
                completionHandler(clientName, error)
            }
        }
        
        publicDatabase.add(operation)
    }
    
    func transactionFetchAllProducts(transaction: Transaction, completionHandler: @escaping (_ products: [Product]?, _ error: Error?) -> Void) {
        var products: [Product] = []
        var cloudkitError:Error?
        
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "transactionFetchAllProducts")
        
        for productReference in  transaction.productReferences ?? []{
            group.enter()
            queue.async (group: group){
                var product: Product?
                
                productFetchOnce(productID: productReference.recordID) { (result, error) in
                    product = result
                    cloudkitError = error
                    if (error == nil) {
                        transactionFetchProductQuantity(transactionID: transaction.recordID!, productID: product!.recordID!) { (quantity, error) in
                            product!.transactionQuantity = quantity
                            cloudkitError = error
                            
                            products.append(product!)
                            group.leave()
                        }
                    }
                    else {
                        group.leave()
                    }
                }
            }
            if cloudkitError != nil {
                break;
            }
        }
        
        group.notify(queue: .main) {
            completionHandler(products, cloudkitError)
        }
    }
    
    // MARK: - Product Functions
    func productCreate(product: Product, completionHandler: @escaping (_ recordID: CKRecord.ID? ,_ error: Error?) -> Void){
        
        var productRecord = CKRecord(recordType: "Product")
        let userReference = CKRecord.Reference(recordID: (User.currentUser()?.recordID)!, action: CKRecord_Reference_Action.deleteSelf)
        
        if let productRecordID = product.recordID {
            productRecord = CKRecord(recordType: "Product", recordID: productRecordID)
        }
        
        productRecord.setValue(product.name, forKey: Product.keyName)
        productRecord.setValue(product.description, forKey: Product.keyDescription)
        productRecord.setValue(product.price, forKey: Product.keyPrice)
        productRecord.setValue(product.stock, forKey: Product.keyStock)
        productRecord.setValue(product.unit, forKey: Product.keyUnit)
        productRecord.setValue(product.type.rawValue, forKey: Product.keyType)
        productRecord.setValue(userReference, forKey: "userReference")
        
        if let productImage = product.image {
            let asset = ImageManager.convertToCKAsset(image: productImage)
            productRecord.setValue(asset, forKey: Product.keyImage)
        }
        
        publicDatabase.save(productRecord) {(savedRecord, error) in
            DispatchQueue.main.async {
                completionHandler(savedRecord?.recordID, error)
            }
        }
    }
    
    func productsFetchAll(completionHandler: @escaping (_ result: [Product], _ error: Error?) -> Void){
        let reference = CKRecord.Reference(recordID: (User.currentUser()?.recordID)!, action: CKRecord_Reference_Action.deleteSelf)
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
    
    func productFetchOnce(productID: CKRecord.ID ,completionHandler: @escaping (_ product: Product?, _ error: Error?) -> Void){
        let predicate = NSPredicate(format: "recordID = %@", productID)
        let query = CKQuery(recordType: "Product", predicate: predicate)
        let operation = CKQueryOperation(query: query)
        
        var product:Product?
        
        operation.recordFetchedBlock = {record in
            product = Product(record: record)
        }
        
        operation.queryCompletionBlock = {cursor, error in
            DispatchQueue.main.async {
                completionHandler(product, error)
            }
        }
        publicDatabase.add(operation)
    }
    
    func productEdit(product: Product, completionHandler: @escaping () -> Void){
        
        let productRecord = CKRecord(recordType: "Product", recordID: product.recordID!)
        
        productRecord.setValue(product.name, forKey: Product.keyName)
        productRecord.setValue(product.price, forKey: Product.keyPrice)
        productRecord.setValue(product.stock, forKey: Product.keyStock)
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
                completionHandler(recordID, error);
            }
        }
    }
}
