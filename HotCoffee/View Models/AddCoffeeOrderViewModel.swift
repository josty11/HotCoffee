//
//  AddCoffeOrderViewModel.swift
//  HotCoffee
//
//  Created by Татьяна on 23.05.2022.
//

import Foundation

struct AddCofeeOrderViewModel {
    var name: String?
    var email: String?
    
    var selectedType: String?
    var selectedSize: String?
    var types: [String] {
        return CoffeeType.allCases.map { $0.rawValue.capitalized }
    }
    var sizes: [String] {
        return CoffeeSize.allCases.map { $0.rawValue.capitalized }
    }
}
