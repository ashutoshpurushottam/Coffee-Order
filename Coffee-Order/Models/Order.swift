//
//  Order.swift
//  Coffee-Order
//
//  Created by Ashutosh Purushottam on 24/02/20.
//  Copyright © 2020 Ashutosh Purushottam. All rights reserved.
//

import Foundation

enum CoffeeType: String, Codable, CaseIterable {
    case cappuccino
    case lattee
    case espressino
    case cortado
}

enum CoffeeSize: String, Codable, CaseIterable {
    case small
    case medium
    case large
}

struct Order: Codable {

    let name: String
    let email: String
    let type: CoffeeType
    let size: CoffeeSize
    
    // Failabe initializer 
    init?(_ viewModel: AddOrderViewModel) {
        guard let name = viewModel.name,
            let email = viewModel.email,
            let type = CoffeeType(rawValue: viewModel.selectedType!.lowercased()),
            let size = CoffeeSize(rawValue: viewModel.selectedSize!.lowercased()) else {
                return nil
        }
        
        self.name = name
        self.email = email
        self.type = type
        self.size = size
        
    }
}

extension Order {
    
    static var all: Resource<[Order]> = {

        guard let url = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else {
            fatalError("URL was malformed")
        }
        
        return Resource<[Order]>(url: url)

    }()
    
    static func create(_ viewModel: AddOrderViewModel) -> Resource<Order?> {
        
        let order = Order(viewModel)
        guard let url = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else {
            fatalError("URL was malformed")
        }
        
        guard let data = try? JSONEncoder().encode(order) else {
            fatalError("JSONEncoding of order failed")
        }
        
        var resource = Resource<Order?>(url: url)
        resource.httpMethod = .POST
        resource.body = data
        
        return resource
        
    }
}
