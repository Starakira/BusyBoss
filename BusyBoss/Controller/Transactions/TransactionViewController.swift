//
//  TransactionViewController.swift
//  Busy Boss
//
//  Created by Muhammad Bangun Agung on 15/10/20.
//

import UIKit

class TransactionViewController: UIViewController {

    @IBOutlet weak var TransactionSegmentedControl: UISegmentedControl!
    @IBOutlet weak var onGoingTransaction: UIView!
    @IBOutlet weak var completeTransaction: UIView!
    @IBOutlet weak var allTransaction: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func segmentedTransaction(_ sender: UISegmentedControl) {
        HideAll()
                if sender.selectedSegmentIndex == 0 {
                    onGoingTransaction.isHidden = false
                    
                }
                else if sender.selectedSegmentIndex == 1 {
                    onGoingTransaction.isHidden = true
                    completeTransaction.isHidden = false
                    allTransaction.isHidden = true
                }
                else if sender.selectedSegmentIndex == 2 {
                    onGoingTransaction.isHidden = true
                    completeTransaction.isHidden = true
                    allTransaction.isHidden = false
                }
    }
    
    func HideAll() {
        onGoingTransaction.isHidden = true
        completeTransaction.isHidden = true
        allTransaction.isHidden = true
    }
    
}

