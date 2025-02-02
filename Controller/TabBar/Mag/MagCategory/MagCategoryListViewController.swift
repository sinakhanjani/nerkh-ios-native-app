//
//  MagCategoryListViewController.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/4/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import UIKit
import SkeletonView

// Class MagCategoryListViewController: Responsible for handling specific functionality in the app.class MagCategoryListViewController: TabBarViewController {
    
    enum Section {
        case main
    }

// Variable dataSource:: Stores data relevant to this class.    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
// Variable collectionView:: Stores data relevant to this class.    var collectionView: UICollectionView! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "News"
        configureHierarchy()
        configureDataSource()
    }
    
    override func setupUI() {
        super.setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUI()
    }
    
    // MARK: Method
    private func updateUI() {
        collectionView.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3.0) {
            self.view.stopSkeletonAnimation()
            self.view.hideSkeleton()
        }
    }
}

extension MagCategoryListViewController {

    //   +-----------------------------------------------------+
    //   | +---------------------------------+  +-----------+  |
    //   | |                                 |  |           |  |
    //   | |                                 |  |           |  |
    //   | |                                 |  |     1     |  |
    //   | |                                 |  |           |  |
    //   | |                                 |  |           |  |
    //   | |                                 |  +-----------+  |
    //   | |               0                 |                 |
    //   | |                                 |  +-----------+  |
    //   | |                                 |  |           |  |
    //   | |                                 |  |           |  |
    //   | |                                 |  |     2     |  |
    //   | |                                 |  |           |  |
    //   | |                                 |  |           |  |
    //   | +---------------------------------+  +-----------+  |
    //   +-----------------------------------------------------+

// Function createLayout: Performs a specific task in the class.    func createLayout() -> UICollectionViewLayout {
// Variable layout: Stores data relevant to this class.        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

// Variable leadingItem: Stores data relevant to this class.            let leadingItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                  heightDimension: .fractionalHeight(1.0)))
            leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

// Variable trailingItem: Stores data relevant to this class.            let trailingItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(0.7)))
            trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
// Variable trailingGroup: Stores data relevant to this class.            let trailingGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                   heightDimension: .fractionalHeight(1.0)),
                subitem: trailingItem, count: 2)

// Variable nestedGroup: Stores data relevant to this class.            let nestedGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(0.34)),
                subitems: [leadingItem, trailingGroup])
// Variable section: Stores data relevant to this class.            let section = NSCollectionLayoutSection(group: nestedGroup)
            return section

        }
        return layout
    }
}

extension MagCategoryListViewController {
// Function configureHierarchy: Performs a specific task in the class.   func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .clear
        collectionView.register(UINib(nibName: "MagCategoryCell", bundle: nil), forCellWithReuseIdentifier: MagCategoryCell.reuseIdentifier)
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
// Function configureDataSource: Performs a specific task in the class.    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource
            <Section, Int>(collectionView: collectionView) {
                (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            // Get a cell of the desired kind.
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MagCategoryCell.reuseIdentifier,
                for: indexPath) as? MagCategoryCell else { fatalError("Cannot create new cell") }
            // Return the cell.
            return cell
        }
        // initial data
// Variable snapshot: Stores data relevant to this class.        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(Array(0..<11))
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension MagCategoryListViewController: UICollectionViewDelegate {
// Function collectionView: Performs a specific task in the class.    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        present(MagViewController.create(), animated: true, completion: nil)
    }
    
// Function collectionView: Performs a specific task in the class.    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
// Variable configuration: Stores data relevant to this class.            let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil){ action in
// Variable viewMenu: Stores data relevant to this class.                let viewMenu = UIAction(title: "View", image: UIImage(systemName: "eye.fill"), identifier: UIAction.Identifier(rawValue: "view")) {_ in
                    //
                }
// Variable favorite: Stores data relevant to this class.                let favorite = UIAction(title: "Favorite", identifier: nil, state: .on, handler: { action in
                    //
                })
// Variable push: Stores data relevant to this class.                let push = UIAction(title: "Push", identifier: nil, discoverabilityTitle: nil, handler: { action in
                    //
                })
// Variable editMenu: Stores data relevant to this class.                let editMenu = UIMenu(title: "More", children: [favorite, push])
                return UIMenu(title: "", image: nil, identifier: nil, children: [viewMenu, editMenu])
            }
            return configuration
    }
}

