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
        self.contentView.addSubview(self.mainLabel)
        self.mainLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        self.contentView.addSubview(self.subLabel)
        self.subLabel.snp.makeConstraints {
            $0.top.equalTo(self.mainLabel.snp.bottom)
            $0.leading.equalTo(self.mainLabel.snp.leading)
            $0.trailing.equalTo(self.mainLabel.snp.trailing)
        }
        self.contentView.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints {
            $0.top.equalTo(self.subLabel.snp.bottom).offset(13)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
extension HomeDroppedTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 1
    }
}
extension HomeDroppedTableViewCell: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        0
    }
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "HomeDroppedCollectionViewCell", for: indexPath
            ) as? HomeDroppedCollectionViewCell else { return UICollectionViewCell() }
//        cell.setUp(<#T##goodsImage: UIImage##UIImage#>, <#T##goodsName: String##String#>, <#T##goodsDescription: String##String#>, <#T##goodsPrice: String##String#>)
        return cell
    }
}
