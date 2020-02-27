//
//  OrderViewModel.swift
//  Coffee-Order
//
//  Created by Ashutosh Purushottam on 25/02/20.
//  Copyright © 2020 Ashutosh Purushottam. All rights reserved.
//

import Foundation

struct OrderListViewModel {
    var ordersViewModel: [OrderViewModel]
    
    init() {
        self.ordersViewModel = [OrderViewModel]()
    }
    
    func orderViewModel(at index: Int) -> OrderViewModel {
        return self.ordersViewModel[index]
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.ordersViewModel.count
    }
    
    
    
}

struct OrderViewModel {
    var order: Order
    
    var name: String {
        return order.name
    }
    
    var email: String {
        return order.email
    }
    
    var type: String {
        return order.type.rawValue.capitalized
    }
    
    var size: String {
        return order.size.rawValue.capitalized
    }
}
