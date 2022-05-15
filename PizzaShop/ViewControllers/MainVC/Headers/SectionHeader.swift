//
//  SectionHeader.swift
//  PizzaShop
//
//  Created by Владимир Рубис on 04.05.2022.
//

import UIKit

// MARK: Класс, описывающий заголовок для секции Основное меню
final class SectionHeader: UICollectionReusableView {
    
    @IBOutlet weak var menuSectionsView: UICollectionView!
    
    var viewModel: SectionHeaderViewModelProtocol! {
        didSet {
            self.menuSectionsView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    /// Настройка `CollectionView`
    private func setup() {
        menuSectionsView.register(UINib(nibName: String(describing: MenuSectionCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: MenuSectionCell.self))
        menuSectionsView.delegate = self
        menuSectionsView.dataSource = self
        menuSectionsView.backgroundColor = .cyan
        
        if let layout = menuSectionsView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
}

// MARK: - UICollectionViewDataSource
extension SectionHeader: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MenuSectionCell.self), for: indexPath) as! MenuSectionCell
        
        cell.viewModel = viewModel.menuSectionCellViewModel(with: indexPath)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SectionHeader: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 150, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
}
