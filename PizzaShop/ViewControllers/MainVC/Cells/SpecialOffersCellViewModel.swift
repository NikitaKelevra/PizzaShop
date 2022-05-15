//
//  SpecialOffersCellViewModel.swift
//  PizzaShop
//
//  Created by Владимир Рубис on 29.04.2022.
//

import Foundation

/// Протокол VM
///   - Parameters:
///     - specialOfferName: название спец-предложения
protocol SpecialOfferCellViewModelProtocol {
    var specialOfferName: String { get }
    /// Инициализатор (товар)
    init(_ product: Product)
}

/// VM для `SpecialOfferCell`
final class SpecialOfferCellViewModel: SpecialOfferCellViewModelProtocol {
    var specialOfferName: String {
        product.name /// Временно так
    }
    
    private let product: Product
    
    required init(_ product: Product) {
        self.product = product
    }
}
