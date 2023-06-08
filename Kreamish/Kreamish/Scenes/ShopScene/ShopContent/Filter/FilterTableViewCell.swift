//
//  FilterTableViewCell.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/06/06.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    
    static var id: String {
        NSStringFromClass(Self.self).components(separatedBy: ".").last ?? ""
    }
    static let cellHeight = 60.0
    
    private lazy var filterCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.allowsSelection = false
        collectionView.backgroundColor = .brown
        collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.id)
        return collectionView
    }()
    
    private func configureUI() {
        self.contentView.addSubview(filterCollectionView)
        filterCollectionView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }
    
    func setUp() {
        configureUI()
    }
}

extension FilterTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.id, for: indexPath) as? FilterCollectionViewCell {
            return cell
        } else {
            fatalError("DequeueReusableCell failed while casting")
        }
    }
    
}

extension FilterTableViewCell: UICollectionViewDelegateFlowLayout {
    
}
