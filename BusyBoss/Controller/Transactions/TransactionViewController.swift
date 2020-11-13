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
    
    func switchView( sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            onGoingTransaction.isHidden = false
            completeTransaction.isHidden = true
            allTransaction.isHidden = true
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
