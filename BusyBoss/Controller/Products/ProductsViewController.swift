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
    override func viewDidLoad() {
        super.viewDidLoad()

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
     let alert = UIAlertController(title: "Title", message: "お願いします", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Goods", style: .default, handler: { (_) in
            self.performSegue(withIdentifier: "inputGoods", sender: self)
               }))
        alert.addAction(UIAlertAction(title: "Service", style: .default, handler: { (_) in
            self.performSegue(withIdentifier: "inputServices", sender: self)
               }))
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
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
