//
//  SectionHeaderViewModel.swift
//  PizzaShop
//
//  Created by Владимир Рубис on 04.05.2022.
//

import Foundation

/// Протокол VM 
protocol SectionHeaderViewModelProtocol {
    /// Создание VM ячеек
    func menuSectionCellViewModel(with indexPath: IndexPath) -> MenuSectionCellViewModelProtocol
}

/// VM для `SectionHeader`
final class SectionHeaderViewModel: SectionHeaderViewModelProtocol {
    
    private let sectionType: [TypeOfProducts] = TypeOfProducts.allCases
    
    func menuSectionCellViewModel(with indexPath: IndexPath) -> MenuSectionCellViewModelProtocol {
        let type = sectionType[indexPath.row]
        return MenuSectionCellViewModel.init(type)
    }
}
