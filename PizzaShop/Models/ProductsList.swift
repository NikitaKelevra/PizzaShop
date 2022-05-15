//
//  MSection.swift
//  PizzaShop
//
//  Created by Владимир Рубис on 25.04.2022.
//

import Foundation

enum TypeOfProducts: String, CaseIterable {
    case burger = "Бургеры"
    case pizza = "Пицца"
    case deserts = "Десерты"
    case sauses = "Соусы"
    case drinks = "Напитки"
}

enum TypeOfSection: String, CaseIterable {
    case specialOffers = "Особые предложения"
    case mainMenu = "Главное меню"
}

struct ProductsList: Hashable {
    let type: TypeOfProducts
    let section: TypeOfSection
    let items: [Product]
}
