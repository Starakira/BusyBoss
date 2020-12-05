//
//  SignatureViewController.swift
//  BusyBoss
//
//  Created by richard santoso on 05/12/20.
//

import UIKit

class SignatureViewController: UIViewController {
    @IBOutlet weak var ownerDirectorField: UITextField!
    @IBOutlet var signatureUIView: UIView!
    @IBOutlet weak var signatureUIImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.signatureUIView.layer.borderWidth = 1
        self.signatureUIView.layer.borderColor = UIColor.black.cgColor
        
        signatureUIImage.isHidden = false
    }
    
    func setSignature() {
        signatureUIImage.image = UIViewDraw.asImage(signatureUIView as! UIViewDraw)()
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        setSignature()
        print("Signature = \(String(describing: signatureUIImage.image))")
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
