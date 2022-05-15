//
//  SpecialOfferCell.swift
//  PizzaShop
//
//  Created by Владимир Рубис on 29.04.2022.
//

import UIKit

// MARK: Класс, описывающий ячейку для секции Основное меню
final class SpecialOfferCell: UICollectionViewCell {

    @IBOutlet weak var specialOfferImageView: UIImageView!
    
    var viewModel: SpecialOfferCellViewModelProtocol! {
        didSet {
            specialOfferImageView.image = UIImage(named: viewModel.specialOfferName)
        }
    }
}
