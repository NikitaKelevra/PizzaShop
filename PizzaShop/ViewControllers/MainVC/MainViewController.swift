//
//  MainViewController.swift
//  PizzaShop
//
//  Created by Сперанский Никита on 25.04.2022.
//

import UIKit




class MainViewController: UICollectionViewController {

    // MARK: - Public properties
    var sections: [MSection] = []
    var products: [Product] = []
    
    // MARK: - Private properties
    
    private let reuseIdentifier = "Cell"
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkManager.shared.fetchProducts { products in
            self.products = products
            print(products[0].name)
        }
        
//        view.backgroundColor = .brown
        setupNavigationBar()
        setupCollectionView()
    }
    // MARK: - Init
    // initialized with a non-nil layout parameter for Collection View
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)

    
        return cell
    }



    // MARK: - UICollectionViewDelegateFlowLayout
    ///  Функция определяет конечный размер ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
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
//        collectionView.register(NewsWeekCell.self, forCellWithReuseIdentifier: reuseId)
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }


//        layout.itemSize = CGSize(width: widthOfItem(), height: widthOfItem())
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 10
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        layout.estimatedItemSize.width = widthOfItem()
    }
    
    /// Настройка `Navigation Bar`
    private func setupNavigationBar() {
        title = "NewsWeek"
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
