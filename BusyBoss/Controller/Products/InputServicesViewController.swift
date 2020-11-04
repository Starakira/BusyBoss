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
    var services : [serviceStruct]!
    override func viewDidLoad() {
        super.viewDidLoad()
        let SSManager : serviceStructManager = serviceStructManager ()
        services = SSManager.services
        // Do any additional setup after loading the view.
    
    }
    @IBAction func addButton(_ sender: Any) {
    let servicePrice = Int(servicesPrice.text!)
    services.append(serviceStruct(name: servicesName.text!, price: servicePrice!, description: servicesDescription.text!))
     let vc = storyboard?.instantiateViewController(identifier: "products") as! ProductsViewController
           self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
