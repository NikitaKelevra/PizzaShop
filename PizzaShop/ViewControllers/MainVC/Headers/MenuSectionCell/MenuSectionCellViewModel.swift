//
//  MenuSectionCellViewModel.swift
//  PizzaShop
//
//  Created by Владимир Рубис on 04.05.2022.
//

import Foundation

protocol MenuSectionCellViewModelProtocol {
    var title: String { get }
    init(_ section: TypeOfProducts)
}

final class MenuSectionCellViewModel: MenuSectionCellViewModelProtocol {
    private let titles: [String] = ["Бургеры", "Пиццы", "Напитки", "Десерты", "Комбо"]
    
    var title: String {
        print(section.rawValue)
       return section.rawValue
        
    }
    
    private let section: TypeOfProducts
    
    init(_ section: TypeOfProducts) {
        self.section = section
    }
    
}
