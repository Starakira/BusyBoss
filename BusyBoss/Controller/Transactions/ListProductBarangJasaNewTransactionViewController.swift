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
        
        segmentedClear(index: 0)
    }
    
    @IBAction func SegmentedAddProductList(_ sender: UISegmentedControl) {
        segmentedClear(index: sender.selectedSegmentIndex)
    }
    
    func segmentedClear(index: Int) {
        if index == 0 {
            segmentedBarangList.isHidden = false
            segmentedJasaList.isHidden = true
        }
        else if index == 1 {
            segmentedBarangList.isHidden = true
            segmentedJasaList.isHidden = false
        }
    }



}
