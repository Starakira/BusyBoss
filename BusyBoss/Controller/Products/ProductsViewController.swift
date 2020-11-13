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
    var goods : [goodsStruct]!
    var services : [serviceStruct] = []
    var goodsVC = GoodsViewController()
    var servicesVC = ServicesViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let GSManager : goodsStructManager = goodsStructManager ()
        goods = GSManager.goods
        
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
     let alert = UIAlertController(title: "", message: "お願いします", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "グッズ", style: .default, handler: { (_) in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "inputGoods") as! InputGoodsViewController
            vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(vc, animated: true, completion: nil)
               }))
        alert.addAction(UIAlertAction(title: "サービス", style: .default, handler: { (_) in
             let vc = self.storyboard?.instantiateViewController(withIdentifier: "inputServices") as! InputServicesViewController
                       vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                       vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                       self.present(vc, animated: true, completion: nil)
               }))
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        print("hi")
        
    }

    // let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
       //let destVC = storyboard.instantiateViewController(withIdentifier: "destinationVC") as! MyViewController

       //destVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
       //destVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve

       //self.present(destVC, animated: true, completion: nil)

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
            let newGoods = sourceViewController.goods
            goods.append(newGoods!)
            self.goodsVC.goodsTableView.reloadData()
        }
        if let sourceViewController = sender.source as? InputServicesViewController {
            let newServices = sourceViewController.service
            services.append(newServices!)
            self.servicesVC.sevicesTableView.reloadData()
            
        }
}
   // func loadServices(completion:@escaping(()-())) {
        //
    //}
}
