//
//  MenuSectionCell.swift
//  PizzaShop
//
//  Created by Владимир Рубис on 04.05.2022.
//

import UIKit

class MenuSectionCell: UICollectionViewCell {

    @IBOutlet weak var menuSectionButton: UIButton!
    
    var viewModel: MenuSectionCellViewModelProtocol! {
        didSet {
            menuSectionButton.setTitle(viewModel.title, for: .normal)
            print("\(viewModel.title) +++")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .green
    }

}
