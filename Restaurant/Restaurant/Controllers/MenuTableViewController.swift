//
//  MenuTableViewController.swift
//  Restaurant
//
//  Created by shunnamiki on 2021/05/26.
//

import UIKit

class MenuTableViewController: UIViewController {
    let category: String
    
    init?(coder: NSCoder, category: String) {
        self.category = category
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
