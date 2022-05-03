//
//  MainViewController.swift
//  PizzaShop
//
//  Created by Сперанский Никита on 25.04.2022.
//

import UIKit

class MainViewController: UICollectionViewController {
    
    typealias DataSourse = UICollectionViewDiffableDataSource<ProductsList, Product>
    typealias Snapshot = NSDiffableDataSourceSnapshot<ProductsList, Product>
    
    // MARK: - Public properties
    private var cellBuilder: CellBuilder!
    
    var viewModel: MainViewModelProtocol! {
        didSet {
            viewModel.fetchProducts {
                self.reloadData()
            }
        }
    }
    
    var dataSourse: DataSourse?
    // MARK: - Private properties
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MainViewModel()
        setupCollectionView()
        
        createDataSourse()
        reloadData()
        setupNavigationBar()
    }
    // MARK: - Init
    // initialized with a non-nil layout parameter for Collection View
    init() {
        super.init(collectionViewLayout: UICollectionViewLayout())
        cellBuilder = CellBuilder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UICollectionViewDataSource
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        viewModel.sections.count
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        viewModel.sections[section].items.count
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let type = viewModel.sections[indexPath.section].type
//        switch type {
//        case .mainMenu:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MainMenuCell.self), for: indexPath) as! MainMenuCell
//
//            cellBuilder.configureCell(for: cell,
//                                      with: viewModel.mainMenuCellViewModel(with: indexPath))
//
//            return cell
//        case .specialOffers:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SpecialOfferCell.self), for: indexPath) as! SpecialOfferCell
//
//            cellBuilder.configureCell(for: cell,
//                                      with: viewModel.specialOfferCellViewModel(with: indexPath))
//
//            return cell
//        }
//    }
    
    func createDataSourse() {
        dataSourse = DataSourse(collectionView: collectionView,
                                cellProvider: { [self] (collectionView, indexPath, _) -> UICollectionViewCell? in
            
            switch viewModel.sections[indexPath.section].type {
            case .mainMenu:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MainMenuCell.self), for: indexPath) as! MainMenuCell

                cellBuilder.configureCell(for: cell,
                                               with: viewModel.mainMenuCellViewModel(with: indexPath))

                return cell
            case .specialOffers:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SpecialOfferCell.self), for: indexPath) as! SpecialOfferCell

                cellBuilder.configureCell(for: cell,
                                               with: viewModel.specialOfferCellViewModel(with: indexPath))

                return cell
            }
        })
    }
    
    func reloadData() {
        var snapshot = Snapshot()
        snapshot.appendSections(viewModel.sections)
        print(viewModel.sections.count)
        for section in viewModel.sections {
            print(section.type)
            
            snapshot.appendItems(section.items, toSection: section)
        }
        dataSourse?.apply(snapshot)
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section = self.viewModel.sections[sectionIndex]
            
            switch section.type {
                
            case .mainMenu:
                return self.createMainMenuSection()
            case .specialOffers:
                return self.createSpecialOfferSection()
            }
        }
        
        return layout
    }
    
    func createMainMenuSection() -> NSCollectionLayoutSection {
        let padding: CGFloat = 16
        
        let itemSize = NSCollectionLayoutSize( widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: padding, bottom: padding, trailing: padding)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(150))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 66, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
    func createSpecialOfferSection() -> NSCollectionLayoutSection {
        let padding: CGFloat = 16
        
        let widthDimension: CGFloat = (view.bounds.width - padding) / 3
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: padding, bottom: 0, trailing: 0)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .estimated(widthDimension), heightDimension: .estimated(widthDimension * 1.25))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .continuous
        layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: 66, leading: 0, bottom: 0, trailing: 0)
        
        return layoutSection
    }
    
    // MARK: - UICollectionViewDelegate
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
    
    // MARK: - Private Func
    /// Настройка `Collection View`
    private func setupCollectionView() {
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionView.register(UINib(nibName: String(describing: MainMenuCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: MainMenuCell.self))
        collectionView.register(UINib(nibName: String(describing: SpecialOfferCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: SpecialOfferCell.self))
    }
    
    /// Настройка `Navigation Bar`
    private func setupNavigationBar() {
        title = "PizzaShop"
        navigationController?.navigationBar.prefersLargeTitles = true
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor.brown
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}

