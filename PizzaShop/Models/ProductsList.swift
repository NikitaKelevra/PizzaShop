//
//  MSection.swift
//  PizzaShop
//
//  Created by Владимир Рубис on 25.04.2022.
//

import Foundation

enum TypeOfProducts: CaseIterable {
    case specialOffers, mainMenu
}

struct ProductsList: Hashable {
    let type: TypeOfProducts
    let items: [Product]
}
