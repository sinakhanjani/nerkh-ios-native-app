//
//  CurrencyViewModel.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/19/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import UIKit
import NetworkAPI

// Class CurrencyViewModel: Responsible for handling specific functionality in the app.class CurrencyViewModel: NSObject {
    
    private var collectionView: UICollectionView! = nil
    private var view: UIView
    
    public lazy var dataSource: CurrencyDataSource = {
// Variable dataSource: Stores data relevant to this class.        let dataSource = CurrencyDataSource(data: [], collectionView: collectionView)
        return dataSource
    }()
    
    init(view: UIView) {
        self.view = view
        super.init()
        self.configureHierarchy()
        self.dataSource.performQuery(with: nil)
        self.fetch()
    }

    public func fetch() {
        view.showAnimatedGradientSkeleton()
        Network<Generic<[ParentCurrency]>,Empty>(path: "api/currency/update/currency")
            .post { [unowned self = self] (res) in
                DispatchQueue.main.async {
                    self.view.stopSkeletonAnimation()
                    self.view.hideSkeleton()
                }
            res.ifSuccess { (data) in
                DispatchQueue.main.async {
                    self.dataSource.performQuery(data: data)
                }
            }
        }.dispose()
    }
    
    private func configureHierarchy() {
        view.isSkeletonable = true
        view.backgroundColor = .systemBackground
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(UINib(nibName: "CurrencyCell", bundle: nil), forCellWithReuseIdentifier: CurrencyCell.reuseIdentifier)
        collectionView.register(UINib(nibName: "CurrencyResusableView", bundle: nil), forSupplementaryViewOfKind: CurrencyViewController.sectionHeaderElementKind, withReuseIdentifier: CurrencyResusableView.reuseIdentifier)
        view.addSubview(collectionView)
        collectionView.isSkeletonable = true
        collectionView.keyboardDismissMode = .onDrag
    }
}

extension CurrencyViewModel {
    private func createLayout() -> UICollectionViewLayout {
// Variable layout: Stores data relevant to this class.        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
// Variable contentSize: Stores data relevant to this class.            let contentSize = layoutEnvironment.container.effectiveContentSize
// Variable columns: Stores data relevant to this class.            let columns = contentSize.width > 800 ? 2 : 1
// Variable spacing: Stores data relevant to this class.            let spacing = CGFloat(10)
// Variable itemSize: Stores data relevant to this class.            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
// Variable item: Stores data relevant to this class.            let item = NSCollectionLayoutItem(layoutSize: itemSize)
// Variable groupSize: Stores data relevant to this class.            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(148))
// Variable group: Stores data relevant to this class.            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
            group.interItemSpacing = .fixed(spacing)
// Variable section: Stores data relevant to this class.            let section = NSCollectionLayoutSection(group: group)
// Variable sectionHeader: Stores data relevant to this class.            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .absolute(64)),
                elementKind: CurrencyViewController.sectionHeaderElementKind,
                alignment: .top)
            sectionHeader.pinToVisibleBounds = true
            sectionHeader.zIndex = 2
            section.boundarySupplementaryItems = [sectionHeader]
            section.interGroupSpacing = spacing
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            return section
        }
        return layout
    }
}

extension CurrencyViewModel: UICollectionViewDelegate {
// Function collectionView: Performs a specific task in the class.    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // didSelectAt indexPath
    }
}
