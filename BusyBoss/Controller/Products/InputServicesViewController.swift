//
//  InputServicesViewController.swift
//  Busy Boss
//
//  Created by richard santoso on 27/10/20.
//

import UIKit

class InputServicesViewController: UIViewController {
    @IBOutlet weak var servicesName: UITextField!
    @IBOutlet weak var servicesPrice: UITextField!
    @IBOutlet weak var servicesDescription: UITextField!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var product: Product?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           guard let button = sender as? UIBarButtonItem, button === addButton else {
               
               return
           }
        var product = Product(name: servicesName.text ?? "No name",
                               description: servicesDescription.text ?? "No description",
                               price: Double(servicesPrice.text ?? "0.0") ?? 0.0,
                               type: ProductType.services)
        
        CloudKitManager.shared().productCreate(product: product) {
            (recordID, error) in
            if let error = error {
                print(error.localizedDescription)
                Alert.showAlert(view: self, title: "Error creating product", message: "Error")
                return
            }
                if recordID == nil {
                    print("ID not created!")
                }
                else {
                    print("Creating client successful")
                    product.recordID = recordID
                    
                    self.product = product
                }
        }
          
          
       }
    
    /*    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension InputServicesViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
