//
//  MainViewModel.swift
//  PizzaShop
//
//  Created by Сперанский Никита on 25.04.2022.
//

import UIKit

protocol MainViewModelProtocol {
    var products: [Product] { get set }
    var sections: [ProductsList] { get }
    func fetchProducts(completion: @escaping() -> Void)
    func numberOfItems() -> Int
    func mainMenuCellViewModel(with indexPath: IndexPath) -> MainMenuCellViewModelProtocol
    func specialOfferCellViewModel(with indexPath: IndexPath) -> SpecialOfferCellViewModelProtocol
    func sizeForItemAt(for view: UIView, with indexPath: IndexPath) -> CGSize
    
    func sectionHeaderViewModel(with indexPath: IndexPath) -> SectionHeaderViewModelProtocol
    //    func detailsViewModel(with indexPath: IndexPath) -> BurgerDetailsViewModelProtocol
}

final class MainViewModel: MainViewModelProtocol {
    var sections: [ProductsList] = []
    var products: [Product] = [] {
        didSet {
            var list: [ProductsList] = []
            let typesOfSections = TypeOfProducts.allCases
            typesOfSections.forEach { type in
                var items: [Product] = []
                if type == .specialOffers {
                    for index in 0..<products.count {
                        if index <= 6 {
                            items.append(products[index])
                        }
                    }
                } else {
                    for index in 0..<products.count {
                        if index >= 7 {
                            items.append(products[index])
                        }
                    }
                }
                
            let section = ProductsList(type: type, items: items)
            list.append(section)
        }
        self.sections = list
    }
}

func fetchProducts(completion: @escaping () -> Void) {
    NetworkManager.shared.fetchProducts { products in
        self.products = products
        completion()
    }
}

func numberOfItems() -> Int {
    products.count
}

func mainMenuCellViewModel(with indexPath: IndexPath) -> MainMenuCellViewModelProtocol {
    
    let product = products[indexPath.row]
    return MainMenuCellViewModel.init(product)
}

func specialOfferCellViewModel(with indexPath: IndexPath) -> SpecialOfferCellViewModelProtocol {
    
    let product = products[indexPath.row]
    return SpecialOfferCellViewModel.init(product)
}

func sizeForItemAt(for view: UIView, with indexPath: IndexPath) -> CGSize {
    
    let padding: CGFloat = 10
    let itemPerRow: CGFloat = 1
    
    let paddingWidth = padding * (itemPerRow + 1)
    let availableWidth = view.frame.width - paddingWidth
    let widthPerItem = availableWidth / itemPerRow
    
    return CGSize(width: widthPerItem, height: 150)
}

    func sectionHeaderViewModel(with indexPath: IndexPath) -> SectionHeaderViewModelProtocol {
        let Array = TypeOfProducts.allCases
        let section = Array[indexPath.section]
        return SectionHeaderViewModel.init(section: section)
    }

}
