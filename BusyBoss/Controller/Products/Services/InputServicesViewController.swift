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
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    /*    // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let button = sender as? UIBarButtonItem, button === addButton else {
            
            return
        }
        let product = Product(name: servicesName.text ?? "No name",
                              description: servicesDescription.text ?? "No description",
                              price: Double(servicesPrice.text ?? "0.0") ?? 0.0,
                              type: ProductType.services)
        
        self.product = product
    }
    
    
    
}

extension InputServicesViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
