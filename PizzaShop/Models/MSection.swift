//
//  MSection.swift
//  PizzaShop
//
//  Created by Владимир Рубис on 25.04.2022.
//

import Foundation

struct MSection: Decodable {
    let type: String
    let title: String
    let items: [Product]
}
