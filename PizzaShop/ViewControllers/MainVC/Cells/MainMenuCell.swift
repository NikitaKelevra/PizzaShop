//
//  MainMenuCell.swift
//  PizzaShop
//
//  Created by Владимир Рубис on 29.04.2022.
//

import UIKit

final class MainMenuCell: UICollectionViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    var viewModel: MainMenuCellViewModelProtocol! {
        didSet {
            productImageView.image = UIImage(named: viewModel.productName)
            productNameLabel.text = viewModel.productName
            productDescriptionLabel.text = viewModel.productDescription
        }
    }
}
