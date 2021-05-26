//
//  MenuTableViewController.swift
//  Restaurant
//
//  Created by shunnamiki on 2021/05/26.
//

import UIKit

class MenuTableViewController: UITableViewController {
    let category: String
    var menuItems = [MenuItem]()
    let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        return formatter
    }()
    
    init?(coder: NSCoder, category: String) {
        self.category = category
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MenuController.shared.fetchMenuItems(forCategory: category) { (result) in
            switch result {
            case .success(let menuItems):
                self.updateUI(with: menuItems)
            case .failure(let error):
                self.displayError(error, title: "Failed to Fetch Menu Items for \(self.category)")
            }
        }
    }
    
    func updateUI(with menuItems: [MenuItem]) {
        DispatchQueue.main.async {
            self.menuItems = menuItems
            self.tableView.reloadData()
        }
    }

    func displayError(_ error: Error, title: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message:
               error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style:
               .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView,
       numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    override func tableView(_ tableView: UITableView,
       cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
           "MenuItem", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }

    func configure(_ cell: UITableViewCell, forItemAt indexPath:
       IndexPath) {
        let menuItem = menuItems[indexPath.row]
        cell.textLabel?.text = menuItem.name
//        cell.detailTextLabel?.text = "$\(menuItem.price)"
        cell.detailTextLabel?.text = priceFormatter.string(from: NSNumber(value: menuItem.price))
    }


    
    // TODO:
    func showMenuItem(){
        print("TODO")
//        let vc = MenuItemDetailViewController()
    }
    
}
