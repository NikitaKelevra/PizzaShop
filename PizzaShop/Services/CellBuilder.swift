//
//  CellBuilder.swift
//  PizzaShop
//
//  Created by Владимир Рубис on 03.05.2022.
//

import UIKit

/// Протокол строителя
protocol CellBuildable {
    /// Настраивает ячейки
    func configureCell(for cell: MainMenuCell,
                       with mainMenuCellViewModel: MainMenuCellViewModelProtocol)
    func configureCell(for cell: SpecialOfferCell,
                       with specialOfferCellViewModel: SpecialOfferCellViewModelProtocol)
}

/// Строитель ячеек
final class CellBuilder {}

// MARK: - CellBuildable
extension CellBuilder: CellBuildable {
    func configureCell(for cell: MainMenuCell, with mainMenuCellViewModel: MainMenuCellViewModelProtocol) {
        
        cell.viewModel = mainMenuCellViewModel
        
        cell.productImageView.contentMode = .scaleAspectFill
        cell.backgroundColor = .blue
    }
    
    func configureCell(for cell: SpecialOfferCell, with specialOfferCellViewModel: SpecialOfferCellViewModelProtocol) {
        
        cell.viewModel = specialOfferCellViewModel
        
        cell.specialOfferImageView.contentMode = .scaleAspectFill
        cell.backgroundColor = .green
        
    }
}
