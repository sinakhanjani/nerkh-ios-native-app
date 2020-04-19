//
//  CurrencyViewModel.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/19/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import UIKit
import NetworkAPI

class CurrencyViewModel: NSObject {
    
    private var collectionView: UICollectionView! = nil
    private var view: UIView
    
    public lazy var dataSource: CurrencyDataSource = {
        let dataSource = CurrencyDataSource(data: [], collectionView: collectionView)
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
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
            let contentSize = layoutEnvironment.container.effectiveContentSize
            let columns = contentSize.width > 800 ? 2 : 1
            let spacing = CGFloat(10)
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(148))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
            group.interItemSpacing = .fixed(spacing)
            let section = NSCollectionLayoutSection(group: group)
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
