//
//  Product.swift
//  PizzaShop
//
//  Created by Владимир Рубис on 25.04.2022.
//

import Foundation

struct Product: Decodable {
    var name: String
    var description: String
    var ingredients: [String]
}
