//
//  CellBuilder.swift
//  PizzaShop
//
//  Created by Владимир Рубис on 03.05.2022.
//

import UIKit

protocol CellBuildable {
    func configureCell(for cell: MainMenuCell,
                       with mainMenuCellViewModel: MainMenuCellViewModelProtocol)
    func configureCell(for cell: SpecialOfferCell,
                       with specialOfferCellViewModel: SpecialOfferCellViewModelProtocol)
}



final class CellBuilder {}

// MARK: - CellBuildable
extension CellBuilder: CellBuildable {
    func configureCell(for cell: MainMenuCell, with mainMenuCellViewModel: MainMenuCellViewModelProtocol) {
        cell.viewModel = mainMenuCellViewModel
        cell.backgroundColor = .blue
        cell.productImageView.contentMode = .scaleAspectFill
    }
    
    func configureCell(for cell: SpecialOfferCell, with specialOfferCellViewModel: SpecialOfferCellViewModelProtocol) {
        cell.viewModel = specialOfferCellViewModel
        
        cell.specialOfferImageView.contentMode = .scaleAspectFill
//        cell.specialOfferImageView.layer.cornerRadius = 15
        cell.backgroundColor = .green
        
    }
    
    private func setupSpecialOffer(cell: UITableViewCell) {
        
    }
}
