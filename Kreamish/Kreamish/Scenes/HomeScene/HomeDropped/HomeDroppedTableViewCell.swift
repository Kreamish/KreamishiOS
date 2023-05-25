//
//  HomeDroppedTableViewCell.swift
//  Kreamish
//
//  Created by 안종표 on 2023/05/25.
//

import UIKit

import SnapKit

final class HomeDroppedTableViewCell: UITableViewCell {
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.text = DroppedText.mainTitle.rawValue
        return label
    }()
    private lazy var subLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .thin)
        label.textColor = .lightGray
        label.text = DroppedText.mainTitle.rawValue
        return label
    }()
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
        collectionView.register(HomeDroppedCollectionViewCell.self,
                                forCellWithReuseIdentifier: "HomeDroppedCollectionViewCell")
        return collectionView
    }()
}
extension HomeDroppedTableViewCell {
    private func configureUI() {
        self.contentView.addSubview(self.collectionView)
        
    }
}

extension HomeDroppedTableViewCell: UICollectionViewDelegateFlowLayout {
    
}
extension HomeDroppedTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
}
