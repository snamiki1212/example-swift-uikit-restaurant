//
//  OrderTableViewController.swift
//  Restaurant
//
//  Created by shunnamiki on 2021/05/26.
//

import UIKit

class OrderTableViewController: UITableViewController {
    var order = Order()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(tableView!,
           selector: #selector(UITableView.reloadData),
           name: MenuController.orderUpdatedNotification, object: nil)
    }
    
    override func tableView(_ tableView: UITableView,
       numberOfRowsInSection section: Int) -> Int {
        return MenuController.shared.order.menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt
       indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
           "Order", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    func configure(_ cell: UITableViewCell, forItemAt indexPath:
       IndexPath) {
        let menuItem =
           MenuController.shared.order.menuItems[indexPath.row]
        cell.textLabel?.text = menuItem.name
        cell.detailTextLabel?.text =
           MenuItem.priceFormatter.string(from: NSNumber(value:
           menuItem.price))
    }
    
    override func tableView(_ tableView: UITableView,
       canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            MenuController.shared.order.menuItems.remove(at:
               indexPath.row)
        }
    }
    
}
