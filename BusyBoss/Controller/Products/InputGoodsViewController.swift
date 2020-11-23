//
//  InputGoodsViewController.swift
//  Busy Boss
//
//  Created by richard santoso on 27/10/20.
//

import UIKit

class InputGoodsViewController: UIViewController {
    @IBOutlet weak var addProductImage: UIImageView!
    @IBOutlet weak var productNameField: UITextField!
    @IBOutlet weak var productPriceFields: UITextField!
    @IBOutlet weak var productStockFields: UITextField!
    @IBOutlet weak var productUnitFields: UITextField!
    @IBOutlet weak var productDescription: UITextField!
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // Do any additional setup after loading the view.
    }
   
    @IBAction func addImage(_ sender: UIButton) {
        let ivc = UIImagePickerController()
               ivc.sourceType = .photoLibrary
               ivc.delegate = self
               ivc.allowsEditing = true
               present(ivc, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let button = sender as? UIBarButtonItem, button === addButton else {
            
            return
        }
        var product = Product(image: addProductImage.image,
                               name: productNameField.text ?? "No name",
                               description: productDescription.text ?? "No description",
                               price: Double(productPriceFields.text ?? "0.0") ?? 0.0,
                               stock: Int(productStockFields.text ?? "0") ?? 0,
                               unit: productUnitFields.text ?? "Undefined",
                               type: ProductType.goods)
        
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
}

extension InputGoodsViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension InputGoodsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            addProductImage.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
       }
}
