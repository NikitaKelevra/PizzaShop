//
//  MainViewModel.swift
//  PizzaShop
//
//  Created by Сперанский Никита on 25.04.2022.
//

import Foundation

/// Протокол VM
///   - Parameters:
///     - products: продукция (Массив данных, получаемый из REST API
///     свойство временное, пока бд в стадии разработки)
///     - productsList: лист продукции
///     - tag: Передается при нажатии на кнопку в CollectionView заголовка.
///     Необходим для отображения выбранной категории товаров
protocol MainViewModelProtocol {
    var products: [Product] { get set }
    var productsList: [ProductsList] { get }
    var tag: Int { get }
    
    /// Получение данных продукции из REST API
    func fetchProducts(completion: @escaping() -> Void)
    
    /// Создание VM ячеек и заголовков
    func mainMenuCellViewModel(with indexPath: IndexPath) -> MainMenuCellViewModelProtocol
    func specialOfferCellViewModel(with indexPath: IndexPath) -> SpecialOfferCellViewModelProtocol
    func sectionHeaderViewModel() -> SectionHeaderViewModelProtocol
}

/// VM для `MainViewController`
final class MainViewModel: MainViewModelProtocol {
    var productsList: [ProductsList] = []
    var products: [Product] = [] {
        didSet {
            getSectionsList()
        }
    }
    var tag: Int = 0
    
    func fetchProducts(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchProducts { products in
            self.products = products
            completion()
        }
    }
    
    func mainMenuCellViewModel(with indexPath: IndexPath) -> MainMenuCellViewModelProtocol {
        let product = products[indexPath.row]
        return MainMenuCellViewModel.init(product)
    }
    
    func specialOfferCellViewModel(with indexPath: IndexPath) -> SpecialOfferCellViewModelProtocol {
        let product = products[indexPath.row]
        return SpecialOfferCellViewModel.init(product)
    }
    
    func sectionHeaderViewModel() -> SectionHeaderViewModelProtocol {
        
        return SectionHeaderViewModel.init()
    }
    
    /// Временная функция для получения `productsList`
    /// В задумке такой лист получать сразу из REST API
    private func getSectionsList() {
        var list: [ProductsList] = []
        let typesOfSections = TypeOfSection.allCases
        
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
            
            let section = ProductsList(type: .burger, section: type, items: items)
            list.append(section)
        }
        self.productsList = list
        
    }
}
