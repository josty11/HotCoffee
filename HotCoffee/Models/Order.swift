//
//  Order.swift
//  HotCoffee
//
//  Created by Татьяна on 22.05.2022.
//

import Foundation

enum CoffeeType: String, Codable {
    case cappuccino
    case latte
    case espresso
    
}

enum CoffeeSize: String, Codable {
    case small
    case medium
    case large
}


struct Order: Codable {
    let name: String
    let email: String
    let type: CoffeeType
    let size: CoffeeSize
}
