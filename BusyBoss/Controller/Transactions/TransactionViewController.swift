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
    
    @IBAction func segmentedTransaction(_ sender: UISegmentedControl) {
        HideAll()
        
        switch sender.selectedSegmentIndex {
        case 0:
            onGoingTransaction.isHidden = false
        case 1:
            completeTransaction.isHidden = false
        case 2:
            allTransaction.isHidden = false
        default:
            onGoingTransaction.isHidden = false
        }
    }
    
    func HideAll() {
        onGoingTransaction.isHidden = true
        completeTransaction.isHidden = true
        allTransaction.isHidden = true
    }
    
}

