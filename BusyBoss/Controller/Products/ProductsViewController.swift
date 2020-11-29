//
//  ProductsViewController.swift
//  Busy Boss
//
//  Created by richard santoso on 27/10/20.
//

import UIKit

class ProductsViewController: UIViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var servicesView: UIView!
    @IBOutlet weak var goodsView: UIView!
    var goodsProducts: [Product] = []
    var servicesProducts: [Product] = []
    var goodsVC : GoodsViewController?
    var servicesVC : ServicesViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedClear(index: 0)
    }
    
    @IBAction func switchView(_ sender: UISegmentedControl) {
        segmentedClear(index: sender.selectedSegmentIndex)
    }
    
    func segmentedClear(index: Int) {
        if index == 0 {
            goodsView.isHidden = false
            servicesView.isHidden = true
        }
        else if index == 1{
            goodsView.isHidden = true
            servicesView.isHidden = false
        }
    }
    
    @IBAction func addProducts(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Product Type", message: "Please choose your product type", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Goods", style: .default, handler: { (_) in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "inputGoods") as! InputGoodsViewController
            vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(vc, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Services", style: .default, handler: { (_) in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "inputServices") as! InputServicesViewController
            vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(vc, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        print("hi")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? GoodsViewController{
            goodsVC = vc
        }
        
        if let vc = segue.destination as? ServicesViewController{
            servicesVC = vc
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func unwindToProduct(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? InputGoodsViewController {
            var newGoods = sourceViewController.product
            
            let pendingAction = Alert.displayPendingAlert(title: "Saving newGoods")
            self.present(pendingAction, animated: true, completion: nil)
            
            CloudKitManager.shared().productCreate(product: newGoods!) {
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
                    print("Creating product successful")
                    newGoods!.recordID = recordID
                    
                    self.goodsProducts.append(newGoods!)
                    self.goodsVC?.products.append(contentsOf: self.goodsProducts)
                    self.goodsVC!.goodsTableView.reloadData()
                    
                    pendingAction.dismiss(animated: true, completion: nil)
                }
            }
        } else if let sourceViewController = sender.source as? InputServicesViewController {
            var newServices = sourceViewController.product
            
            let pendingAction = Alert.displayPendingAlert(title: "Saving newServices")
            self.present(pendingAction, animated: true, completion: nil)
            
            CloudKitManager.shared().productCreate(product: newServices!) {
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
                    print("Creating product successful")
                    newServices!.recordID = recordID
                    
                    self.servicesProducts.append(newServices!)
                    self.servicesVC?.products.append(contentsOf: self.servicesProducts)
                    self.servicesVC!.servicesTableView.reloadData()
                    
                    pendingAction.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
