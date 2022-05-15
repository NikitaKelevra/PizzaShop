//
//  MenuSectionCellViewModel.swift
//  PizzaShop
//
//  Created by Владимир Рубис on 04.05.2022.
//

import Foundation

/// Протокол VM 
///   - Parameters:
///     - title: название категории товаров
///     - tag: для изменения списка товаров в CollectionView по выбранной категории
protocol MenuSectionCellViewModelProtocol {
    var title: String { get }
    var tag: Int { get }
    
    /// Инициализатор (Тип товаров)
    init(_ type: TypeOfProducts)
    
    /// ** При нажатии на кнопку tag этой кнопки должен будет передаться в основную VM, а затем перезагрузить CollectionView для отображения списка товаров другой категории **
    func menuSectionButtonTouch(_ tag: Int)
}

/// VM для `MenuSectionCell`
final class MenuSectionCellViewModel: MenuSectionCellViewModelProtocol {
    
    var title: String
    
    var tag: Int = 0
    
    init(_ type: TypeOfProducts) {
        self.title = type.rawValue
    }
    
    func menuSectionButtonTouch(_ tag: Int) {
        
    }
}
