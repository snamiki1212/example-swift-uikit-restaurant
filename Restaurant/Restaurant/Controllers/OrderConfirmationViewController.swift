//
//  OrderConfirmationViewController.swift
//  Restaurant
//
//  Created by shunnamiki on 2021/05/26.
//

import UIKit

class OrderConfirmationViewController: UIViewController {
    let minutesToPrepare: Int = 0
    var confirmationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmationLabel.text = "Thank you for your order! Your wait time is approximately \(minutesToPrepare) minutes."
    }
    
    // TODO:
//    @IBAction func unwindToOrderList(segue: UIStoryboardSegue) {
//        if segue.identifier == "dismissConfirmation" {
//            MenuController.shared.order.menuItems.removeAll()
//        }
//    }
}

