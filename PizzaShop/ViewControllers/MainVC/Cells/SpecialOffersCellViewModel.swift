//
//  SpecialOffersCellViewModel.swift
//  PizzaShop
//
//  Created by Владимир Рубис on 29.04.2022.
//

import Foundation

protocol SpecialOfferCellViewModelProtocol {
    var specialOfferName: String { get }
    init(_ product: Product)
}

final class SpecialOfferCellViewModel: SpecialOfferCellViewModelProtocol {
    var specialOfferName: String {
        product.name
    }
    
    private let product: Product
    
    required init(_ product: Product) {
        self.product = product
    }
}
