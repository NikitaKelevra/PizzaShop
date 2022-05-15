//
//  MainViewController.swift
//  PizzaShop
//
//  Created by Сперанский Никита on 25.04.2022.
//

/// ** READ ME
/// Это 2й пет-проект, который мы делаем с другом, который также заканчивал курсы Swiftbook
/// Есть желание сделать проект качественно со своим бэком, где будут храниться данные о товарах и куда будут отправляться запросы по доставке и авторизации
/// К сожалению сам пока нашел не достаточно информации, как граммотно разрабатывать проект на MVVM и что лучше использовать по той же передаче данных
/// Смотрел проекты с GitHub, многие делаются с использованием RxSwift, сам пока не касался этого.
/// Потому возникает вопрос. Стоит ли использовать его тут?
///
/// ** PS. Проект сырой и пока много хардкода
/// Чем больше изучаешь - тем больше вопросов, хотя все очень интересно))

import UIKit

// MARK: Основной VC
class MainViewController: UICollectionViewController {
    
    typealias DataSourse = UICollectionViewDiffableDataSource<ProductsList, Product>
    typealias Snapshot = NSDiffableDataSourceSnapshot<ProductsList, Product>
    
    // MARK: - Properties
    private var cellBuilder: CellBuildable!
    
    var dataSourse: DataSourse?
    
    var viewModel: MainViewModelProtocol! {
        didSet {
            viewModel.fetchProducts {
                self.reloadData()
            }
        }
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MainViewModel()
        
        setupCollectionView()
        createDataSourse()
        setupNavigationBar()
    }
    
    // MARK: - Init
    init() {
        super.init(collectionViewLayout: UICollectionViewLayout())
        cellBuilder = CellBuilder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Func
    /// Настройка `Collection View`
    private func setupCollectionView() {
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionView.register(UINib(nibName: String(describing: MainMenuCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: MainMenuCell.self))
        collectionView.register(UINib(nibName: String(describing: SpecialOfferCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: SpecialOfferCell.self))
        collectionView.register(UINib(nibName: String(describing: SectionHeader.self), bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: SectionHeader.self))
    }
    
    // MARK: - Diffable Data Source
    private func createDataSourse() {
        /// Настраивает ячейки в зависимости от секции
        dataSourse = DataSourse(collectionView: collectionView,
                                cellProvider: { [self] (collectionView, indexPath, _) -> UICollectionViewCell? in
            let section = viewModel.productsList[indexPath.section].section
            
            switch section {
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
        
        /// Настраивает заголовки к секциям
        dataSourse?.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: SectionHeader.self), for: indexPath) as? SectionHeader else { return nil }
            sectionHeader.viewModel = self.viewModel.sectionHeaderViewModel()
            return sectionHeader
        }
    }
    
    /// Перезагружает данные в CollectionView
    private func reloadData() {
        var snapshot = Snapshot()
        snapshot.appendSections(viewModel.productsList)
        for section in viewModel.productsList {
            snapshot.appendItems(section.items, toSection: section)
        }
        dataSourse?.apply(snapshot)
    }
    
    
    // MARK: - CollectionViewCompositionalLayout
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section = self.viewModel.productsList[sectionIndex]
            
            switch section.section {
            case .mainMenu:
                return self.createMainMenuSection()
            case .specialOffers:
                return self.createSpecialOfferSection()
            }
        }
        return layout
    }
    
    /// Создаем `layout` для секции `Основное меню`
    /// Позже необходимо сделать одну функцию с передачей типа секции
    private func createMainMenuSection() -> NSCollectionLayoutSection {
        /// Настройка `элемента` в группе
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0,
                                                          leading: 16,
                                                          bottom: 16,
                                                          trailing: 16)
        
        /// Настройка `группы` в секции
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(150))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: [item])
        
        /// Настройка секции
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 10,
                                                             leading: 0,
                                                             bottom: 10,
                                                             trailing: 0)
        
        /// Добавление заголовка
        let header = createSectionHeader()
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    /// Создаем `layout` для секции `Специальные предложения`
    func createSpecialOfferSection() -> NSCollectionLayoutSection {
        let padding: CGFloat = 16
        let widthDimension: CGFloat = (view.bounds.width - padding) / 3
        
        /// Настройка `элемента` в группе
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets.init(top: 10,
                                                                leading: padding,
                                                                bottom: 10,
                                                                trailing: 0)
        
        /// Настройка `группы` в секции
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .estimated(widthDimension),
                                                     heightDimension: .estimated(widthDimension * 1.25))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize,
                                                             subitems: [layoutItem])
        
        /// Настройка секции
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .continuous
        layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: 0,
                                                                   leading: 0,
                                                                   bottom: 0,
                                                                   trailing: 0)
        return layoutSection
    }
    
    /// Создаем `Заголовок` секции
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                             heightDimension: .estimated(50))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize,
                                                                              elementKind: UICollectionView.elementKindSectionHeader,
                                                                              alignment: .top)
        return layoutSectionHeader
    }
    

    // MARK: - Navigation Bar
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

