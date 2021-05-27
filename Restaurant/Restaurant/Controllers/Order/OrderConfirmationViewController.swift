//
//  OrderConfirmationViewController.swift
//  Restaurant
//
//  Created by shunnamiki on 2021/05/26.
//

import UIKit

class OrderConfirmationViewController: UIViewController {
    let minutesToPrepare: Int = 0
    var confirmationLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // confirmation
        view.addSubview(confirmationLabel)
        confirmationLabel.text = "Thank you for your order! Your wait time is approximately \(minutesToPrepare) minutes."
        confirmationLabel.translatesAutoresizingMaskIntoConstraints = false
        confirmationLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        confirmationLabel.numberOfLines = 0
        NSLayoutConstraint.activate([
            confirmationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmationLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        MenuController.shared.order.menuItems.removeAll()
    }
}

