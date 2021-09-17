//
//  SampleCollectionView.swift
//  Combine-UIKit
//
//  Created by marcos.felipe.souza on 05/09/21.
//

import UIKit

class SampleCollectionView: UIViewController {
    
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
    private var datasource: UICollectionViewDiffableDataSource<Int, String>!
    
    private var values = ["Testando 1", "Testando 2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        addRightButton()
        view.backgroundColor = UIColor.systemBackground
    }
    
    private func addRightButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "GO", style: .plain, target: self, action: #selector(addMoreItem))
    }
    
    private func setupCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.secondarySystemBackground
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
                
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
        collectionView.register(ItemCollectionViewCell.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: "header")
        
        datasource = UICollectionViewDiffableDataSource<Int, String>(collectionView: collectionView) { collectionView, indexPath, model in
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as? ItemCollectionViewCell {                
                cell.textInput = model
                return cell
            }
            
            return UICollectionViewCell()
        }
        
        datasource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            
            if let cell = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "header", for: indexPath) as? ItemCollectionViewCell {
                cell.textInput = "Header One"
                cell.isHeader = true
                return cell
            }
            return nil
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([1])
        snapshot.appendItems(values, toSection: 1)

        datasource.apply(snapshot)
    }
    
    private func createCompositionalLayout_bkp() -> UICollectionViewCompositionalLayout {
        
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
//                                              heightDimension: .fractionalHeight(1.0))
        
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0))
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                               heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        group.interItemSpacing = .fixed(15)
        
        let section = NSCollectionLayoutSection(group: group)
//        section.interGroupSpacing = 15
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [headerElement]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
      let inset: CGFloat = 8

      // Large item on top
      let topItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(9/16))
      let topItem = NSCollectionLayoutItem(layoutSize: topItemSize)
      topItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

      // Bottom item
      let bottomItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
      let bottomItem = NSCollectionLayoutItem(layoutSize: bottomItemSize)
      bottomItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

      // Group for bottom item, it repeats the bottom item twice
      let bottomGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
      let bottomGroup = NSCollectionLayoutGroup.horizontal(layoutSize: bottomGroupSize, subitem: bottomItem, count: 2)

      // Combine the top item and bottom group
      let fullGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(9/16 + 0.5))
      let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: fullGroupSize, subitems: [topItem, bottomGroup])

      let section = NSCollectionLayoutSection(group: nestedGroup)

      let layout = UICollectionViewCompositionalLayout(section: section)

      return layout
    }
    
    @objc
    private func addMoreItem(){
        guard let lastItem = values.last else { return }
        
        let newValue = "Testando \(values.count + 1)"
        var snapshot = datasource.snapshot()
        snapshot.insertItems([newValue], beforeItem: lastItem)
        snapshot.appendItems(values, toSection: 1)
        datasource.apply(snapshot)
        
        values += ["Testando \(values.count + 1)"]
    }
}


