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
    var products: [Product] = []
    var goodsVC : GoodsViewController?
    var servicesVC : ServicesViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CloudKitManager.shared().productsFetchAll {
            (products, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                print("Fetching client successful")
                print("Clients = \(products.count)")
                self.products = products
            }
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func switchView(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            goodsView.isHidden = false
            servicesView.isHidden = true
        }
        else if sender.selectedSegmentIndex == 1{
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
            let newGoods = sourceViewController.product
            products.append(newGoods!)
            goodsVC?.products = products
            goodsVC!.goodsTableView.reloadData()
        }
        if let sourceViewController = sender.source as? InputServicesViewController {
            let newServices = sourceViewController.product
            products.append(newServices!)
            servicesVC?.products = products
            servicesVC!.sevicesTableView.reloadData()
        }
}

    
}
