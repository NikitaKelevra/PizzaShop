//
//  ProductsCellViewModel.swift
//  PizzaShop
//
//  Created by Владимир Рубис on 29.04.2022.
//

import Foundation
import UIKit

/// Протокол VM для `MenuSectionCell`
///   - Parameters:
///     - productName: название товара
///     - productDescription: описание товара
protocol MainMenuCellViewModelProtocol {
    var productName: String { get }
    var productDescription: String { get }
    
    /// Инициализатор (товар)
    init(_ product: Product)
}

/// VM для `MainMenuCell`
final class MainMenuCellViewModel: MainMenuCellViewModelProtocol {
    var productName: String {
        product.name
    }
    
    var productDescription: String {
        product.description
    }
    
    private let product: Product
    
    required init(_ product: Product) {
        self.product = product
    }
    
}
