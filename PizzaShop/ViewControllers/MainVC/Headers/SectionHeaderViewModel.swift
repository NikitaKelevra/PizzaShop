//
//  SectionHeaderViewModel.swift
//  PizzaShop
//
//  Created by Владимир Рубис on 04.05.2022.
//

import Foundation

protocol SectionHeaderViewModelProtocol {
    init(section: TypeOfProducts)
    func menuSectionCellViewModel() -> MenuSectionCellViewModelProtocol
}

final class SectionHeaderViewModel: SectionHeaderViewModelProtocol {
    
    private let section: TypeOfProducts
    
    init(section: TypeOfProducts) {
        self.section = section
    }
    
    func menuSectionCellViewModel() -> MenuSectionCellViewModelProtocol {
        return MenuSectionCellViewModel.init(section)
    }
}
