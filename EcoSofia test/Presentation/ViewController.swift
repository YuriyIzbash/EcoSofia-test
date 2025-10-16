//
//  ViewController.swift
//  EcoSofia test
//
//  Created by yuriy on 16. 10. 25.
//

import UIKit

final class ViewController: UIViewController {
    
    let viewModel = HomeViewModel()
    let homeView = HomeView()
    
    override func loadView() {
        view = homeView
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViews()
    }
    
    func setupCollectionViews() {
        homeView.topCollectionView.register(TopCircleCell.self, forCellWithReuseIdentifier: TopCircleCell.reuseID)
        homeView.topCollectionView.register(TopHeaderView.self,
                                   forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                   withReuseIdentifier: "TopHeaderView")
        homeView.topCollectionView.dataSource = self
        homeView.topCollectionView.delegate = self
        homeView.topCollectionView.isScrollEnabled = false
        homeView.topCollectionView.alwaysBounceVertical = false
        homeView.topCollectionView.showsVerticalScrollIndicator = false

        homeView.bottomCollectionView.register(BottomGridCell.self, forCellWithReuseIdentifier: BottomGridCell.reuseID)
        homeView.bottomCollectionView.dataSource = self
        homeView.bottomCollectionView.delegate = self
    }
}

