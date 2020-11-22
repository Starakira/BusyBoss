//
//  Alert.swift
//  Final Project
//
//  Created by Yafet Sutanto on 13/10/19.
//  Copyright © 2019 Budi Sugiarto. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class Alert {
    
    static func showError(_ view: UIViewController,_ error: Error, completion: (() -> Void)? = nil) {
        let errorAlert = UIAlertController.init(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Dismiss", style: .cancel) { _ in
            errorAlert.dismiss(animated: true, completion: completion)
        }
        errorAlert.addAction(alertAction)
        view.present(errorAlert, animated: true)
    }
    
    static func showCloudKitError(_ view: UIViewController,_ error: Error, completion: (() -> Void)? = nil) {
        let errorMessage = CloudKitError.getUserFriendlyDescription(error: error)
        let errorAlert = UIAlertController.init(title: "Error", message: errorMessage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Dismiss", style: .cancel) { _ in
            errorAlert.dismiss(animated: true, completion: completion)
        }
        errorAlert.addAction(alertAction)
        view.present(errorAlert, animated: true)
    }
    
    static func showAlert(view: UIViewController, title: String, message: String, completion: (() -> Void)? = nil) {
        let errorAlert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Dismiss", style: .cancel) { _ in
            errorAlert.dismiss(animated: true, completion: completion)
        }
        errorAlert.addAction(alertAction)
        view.present(errorAlert, animated: true)
    }
    
    static func showConfirmation(view: UIViewController, title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .destructive) { _ in
            alert.dismiss(animated: true, completion: completion)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        view.present(alert, animated: true)
    }
    
    static func displayPendingAlert(title: String) -> UIAlertController {
            //create an alert controller
            let pending = UIAlertController(title: title, message: " \n \n \n", preferredStyle: .alert)
            
            //create an activity indicator
            let indicator = UIActivityIndicatorView(frame: pending.view.bounds.offsetBy(dx: 0, dy: 15))
            indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]

            //add the activity indicator as a subview of the alert controller's view
            pending.view.addSubview(indicator)
            indicator.isUserInteractionEnabled = false // required otherwise if there buttons in the UIAlertController you will not be able to press them
            indicator.startAnimating()
            
            return pending
        }
    
}
