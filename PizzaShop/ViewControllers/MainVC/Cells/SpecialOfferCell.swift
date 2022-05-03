//
//  SpecialOfferCell.swift
//  PizzaShop
//
//  Created by Владимир Рубис on 29.04.2022.
//

import UIKit

final class SpecialOfferCell: UICollectionViewCell {

    @IBOutlet weak var specialOfferImageView: UIImageView!
    
    var viewModel: SpecialOfferCellViewModelProtocol! {
        didSet {
            specialOfferImageView.image = UIImage(named: viewModel.specialOfferName)
            print(viewModel.specialOfferName)
        }
    }
}
