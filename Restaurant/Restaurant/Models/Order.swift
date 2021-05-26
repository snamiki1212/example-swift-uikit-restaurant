//
//  Order.swift
//  Restaurant
//
//  Created by shunnamiki on 2021/05/26.
//

import Foundation

struct Order: Codable {
    var menuItems: [MenuItem]

    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
}
