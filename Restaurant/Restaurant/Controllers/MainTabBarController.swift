//
//  MainTabBarController.swift
//  Restaurant
//
//  Created by shunnamiki on 2021/05/26.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let categoryVC: UINavigationController = {
            let vc = CategoryTableViewController()
            vc.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 0)
            return UINavigationController(rootViewController: vc)
        }()
        
        let orderVC: UINavigationController = {
            let vc = OrderTableViewController()
            vc.minutesToPrepare = 2
            vc.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)
            return UINavigationController(rootViewController: vc)
        }()
        
        viewControllers = [categoryVC, orderVC]
    }
}
