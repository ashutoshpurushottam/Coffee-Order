//
//  AddOrderViewModel.swift
//  Coffee-Order
//
//  Created by Ashutosh Purushottam on 25/02/20.
//  Copyright © 2020 Ashutosh Purushottam. All rights reserved.
//

import Foundation

struct AddOrderViewModel {

    var name: String?
    var email: String?
    var selectedType: String?
    var selectedSize: String?
    
    var types: [String] {
        return CoffeeType.allCases.map {$0.rawValue.capitalized }
    }
    
    var sizes: [String] {
        return CoffeeSize.allCases.map { $0.rawValue.capitalized }
    }
    
}
