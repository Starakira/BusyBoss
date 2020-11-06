//
//  ListProductBarangJasaNewTransactionViewController.swift
//  Busy Boss
//
//  Created by Ryan Anslyno Khohari on 28/10/20.
//

import UIKit

class ListProductBarangJasaNewTransactionViewController: UIViewController {
    @IBOutlet weak var ListBarangJasa: UISegmentedControl!
    @IBOutlet weak var segmentedBarangList: UIView!
    @IBOutlet weak var segmentedJasaList: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func SegmentedAddProductList(_ sender: UISegmentedControl) {
                if sender.selectedSegmentIndex == 0 {
                    segmentedBarangList.isHidden = false
                    segmentedJasaList.isHidden = true
                }
                else if sender.selectedSegmentIndex == 1 {
                    segmentedBarangList.isHidden = true
                    segmentedJasaList.isHidden = false
                }
            
    }
    




}
