//
//  MenuItemDetailViewController.swift
//  Restaurant
//
//  Created by shunnamiki on 2021/05/26.
//

import UIKit

let TAB_BAR_HEIGHT = 50

class MenuItemDetailViewController: UIViewController {
    var menuItem: MenuItem? {
        didSet{
            print("DID SET")
            updateUI()
        }
    }
    var titleLabel = UILabel()
    var nameLabel = UILabel()
    var imageView = UIImageView()
    var priceLabel = UILabel()
    var detailTextLabel = UILabel()
    var addToOrderButton = UIButton()

    override func viewDidLoad() {
        view.backgroundColor = .white
        
        // addToOrderButton
        view.addSubview(addToOrderButton)
        addToOrderButton.layer.cornerRadius = 5.0
        addToOrderButton.setTitle("Add to Order", for: .normal)
        addToOrderButton.translatesAutoresizingMaskIntoConstraints = false
        addToOrderButton.backgroundColor = .systemGreen
        NSLayoutConstraint.activate([
            addToOrderButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: CGFloat(-TAB_BAR_HEIGHT + -20)),
            addToOrderButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addToOrderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addToOrderButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    func updateUI() {
        guard let menuItem = menuItem else { fatalError("Invalid data about menuItem")}
        titleLabel.text = menuItem.name
        priceLabel.text = MenuItem.priceFormatter.string(from:
           NSNumber(value: menuItem.price))
        detailTextLabel.text = menuItem.detailText
        MenuController.shared.fetchImage(url: menuItem.imageURL)
           { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    func orderButtonTapped(_ sender: UIButton) {
        guard let menuItem = menuItem else { fatalError("Invalid data about menuItem")}
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.1,
            options: [],
            animations: {
                self.addToOrderButton.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                self.addToOrderButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            },
            completion: nil
        )
        
        MenuController.shared.order.menuItems.append(menuItem)
    }
}
