//
//  UIViewController.swift
//  Authentication
//
//  Created by Hoangtaiki on 8/2/18.
//  Copyright © 2018 toprating. All rights reserved.
//

import UIKit

extension UIViewController {

    func showMessage(title: String? = nil, message: String?) {
        let alertController = UIAlertController(title: title ?? "MaNaDr", message: message, preferredStyle: .alert)
        alertController.view.accessibilityIdentifier = "alertViewController"
        alertController.view.accessibilityValue = "\(message ?? "")"

        let closeAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alertController.addAction(closeAction)

        present(alertController, animated: true, completion: nil)
    }
}

