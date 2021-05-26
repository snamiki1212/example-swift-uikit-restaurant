//
//  MenuItemDetailViewController.swift
//  Restaurant
//
//  Created by shunnamiki on 2021/05/26.
//

import UIKit

class MenuItemDetailViewController: UIViewController {

    let menuItem: MenuItem

    init?(coder: NSCoder, menuItem: MenuItem) {
        self.menuItem = menuItem
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
