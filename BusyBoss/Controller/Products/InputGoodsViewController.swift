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
    var goods : [goodsStruct]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let GSManager : goodsStructManager = goodsStructManager ()
        goods = GSManager.goods
        // Do any additional setup after loading the view.
    }
    @IBAction func addItem(_ sender: Any) {
        let productPrice = Int(productPriceFields.text!)
        let productStock = Int(productStockFields.text!)
        goods.append(goodsStruct(productName: productNameField.text!, productPrice: productPrice!, productImage: addProductImage.image!, productStock: productStock!, productUnit: productUnitFields.text!, description: productDescription.text!))
        let vc = storyboard?.instantiateViewController(identifier: "products") as! ProductsViewController
                  self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func addImage(_ sender: Any) {
        let ivc = UIImagePickerController()
               ivc.sourceType = .photoLibrary
               ivc.delegate = self
               ivc.allowsEditing = true
               present(ivc, animated: true)
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
extension InputGoodsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerIsEdited")] as? UIImage{
            addProductImage.image = image
        }
    }
     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
       }
}
