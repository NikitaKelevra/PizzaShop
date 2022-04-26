//
//  ProductProtocol.swift
//  PizzaShop
//
//  Created by Владимир Рубис on 26.04.2022.
//

import Foundation

protocol ProductProtocol {
    var name: String { get }
    var description: String { get }
    var ingredients: [String] { get }
    init(for product: Product)
}
