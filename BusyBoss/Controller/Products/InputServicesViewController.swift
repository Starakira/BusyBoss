//
//  InputServicesViewController.swift
//  Busy Boss
//
//  Created by richard santoso on 27/10/20.
//

import UIKit

class InputServicesViewController: UIViewController{
    @IBOutlet weak var servicesName: UITextField!
    @IBOutlet weak var servicesPrice: UITextField!
    @IBOutlet weak var servicesDescription: UITextField!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var service : serviceStruct?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        servicesName.delegate = self
        servicesPrice.delegate = self
        addButton.isEnabled = false
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           guard let button = sender as? UIBarButtonItem, button === addButton else {
               
               return
           }
        let servicePrice = Int(servicesPrice.text!)
        let newServices = serviceStruct(name: servicesName.text!, price: servicePrice!, description: servicesDescription.text ?? "no description")
        print(newServices)
        self.service = newServices
          
          
       }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let name = (servicesName.text! as String)
        let price = (servicesPrice.text! as String)
        
        if !name.isEmpty && !price.isEmpty{
            addButton?.isEnabled = true
            
        } else {
            addButton?.isEnabled = false
            
        }
        return true
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
