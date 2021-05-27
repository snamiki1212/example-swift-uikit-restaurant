//
//  OrderTableViewController.swift
//  Restaurant
//
//  Created by shunnamiki on 2021/05/26.
//

import UIKit

class OrderTableViewController: UITableViewController {
    let cellID = "Order"
    var order = Order()
    var minutesToPrepare: Int = 0
    var minutesToPrepareOrder = 0
    lazy var submitButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(onClickSubmit))
        btn.title = "Submit"
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(tableView!,
           selector: #selector(UITableView.reloadData),
           name: MenuController.orderUpdatedNotification, object: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellID)
        
        
        // submit
        navigationItem.rightBarButtonItem = submitButton
    }
    
    override func tableView(_ tableView: UITableView,
       numberOfRowsInSection section: Int) -> Int {
        return MenuController.shared.order.menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt
       indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
                                                    self.cellID, for: indexPath)
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
    
    @objc func confirmOrder(){
        present(OrderConfirmationViewController(), animated: true, completion: nil)
//        self.navigationController?.pushViewController(, animated: true)
    }
    
    @objc func onClickSubmit(_ sender: Any) {
        let orderTotal =
           MenuController.shared.order.menuItems.reduce(0.0)
           { (result, menuItem) -> Double in
            return result + menuItem.price
        }
    
        let formattedTotal = MenuItem.priceFormatter.string(from:
           NSNumber(value: orderTotal)) ?? "\(orderTotal)"
    
        let alertController = UIAlertController(title: "Confirm Order", message: "You are about to submit your order with a total of \(formattedTotal)",
           preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Submit",
           style: .default, handler: { _ in
            self.uploadOrder()
        }))
    
        alertController.addAction(UIAlertAction(title: "Cancel",
           style: .cancel, handler: nil))
    
        present(alertController, animated: true, completion: nil)
    }

    func uploadOrder() {
        let menuIds = MenuController.shared.order.menuItems.map
           { $0.id }
        MenuController.shared.submitOrder(forMenuIDs: menuIds)
           { (result) in
            switch result {
            case .success(let minutesToPrepare):
                DispatchQueue.main.async {
                    self.minutesToPrepareOrder = minutesToPrepare
                    self.confirmOrder()
                }
            case .failure(let error):
                self.displayError(error, title: "Order Submission Failed")
            }
        }
    }
    
    func displayError(_ error: Error, title: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message:
               error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss",
               style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
