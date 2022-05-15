//
//  MenuSectionCell.swift
//  PizzaShop
//
//  Created by Владимир Рубис on 04.05.2022.
//

import UIKit

// MARK: Класс, описывающий ячейки CollectionView в заголовке секции Основное меню
class MenuSectionCell: UICollectionViewCell {

    @IBOutlet weak var menuSectionButton: UIButton!
    
    var viewModel: MenuSectionCellViewModelProtocol! {
        didSet {
            menuSectionButton.setTitle(viewModel.title, for: .normal)
            menuSectionButton.tag = viewModel.tag
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .green
    }

    @IBAction func menuSectionButtonPressed(_ sender: UIButton) {
        viewModel.menuSectionButtonTouch(sender.tag)
    }
}
