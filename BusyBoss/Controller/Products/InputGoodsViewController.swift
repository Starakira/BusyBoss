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
    var goods : goodsStruct!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
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
        let productPrice = Int(productPriceFields.text!)
        let productStock = Int(productStockFields.text!)
        let newGoods = goodsStruct(productName: productNameField.text!, productPrice: productPrice!, productImage: addProductImage.image!, productStock: productStock!, productUnit: productUnitFields.text!, description: productDescription.text!)
       
       self.goods = newGoods
    }



}
extension InputGoodsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            addProductImage.image = image
        }
    }
     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
       }
}
