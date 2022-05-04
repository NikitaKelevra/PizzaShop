//
//  SectionHeader.swift
//  PizzaShop
//
//  Created by Владимир Рубис on 04.05.2022.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    
    @IBOutlet weak var menuSectionsView: UICollectionView!
    
    var viewModel: SectionHeaderViewModelProtocol! {
        didSet {
            self.menuSectionsView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        menuSectionsView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 200, height: 100), collectionViewLayout: UICollectionViewFlowLayout())
//        menuSectionsView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        menuSectionsView.delegate = self
        menuSectionsView.dataSource = self
        menuSectionsView.register(UINib(nibName: String(describing: MenuSectionCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: MenuSectionCell.self))
//        menuSectionsView.
        customizeElements()
        
    }
    
    
    private func customizeElements() {
        menuSectionsView.backgroundColor = .cyan
    }
}

extension SectionHeader: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MenuSectionCell.self), for: indexPath) as! MenuSectionCell
        
        cell.viewModel = viewModel.menuSectionCellViewModel()
        
        return cell
    }
}

extension SectionHeader: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 200, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
}
