//
//  ProductsCellViewModel.swift
//  PizzaShop
//
//  Created by Владимир Рубис on 29.04.2022.
//

import Foundation
import UIKit

protocol MainMenuCellViewModelProtocol {
    var productName: String { get }
    var productDescription: String { get }
    init(_ product: Product)
}

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
