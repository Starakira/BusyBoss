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
    
    var service : serviceStruct?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           guard let button = sender as? UIBarButtonItem, button === addButton else {
               
               return
           }
        let servicePrice = Int(servicesPrice.text!)
        let newServices = serviceStruct(name: servicesName.text!, price: servicePrice!, description: servicesDescription.text!)
        print(newServices)
        self.service = newServices
          
          
       }
    
    /*    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
