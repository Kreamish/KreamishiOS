//
//  BannerTableViewCell.swift
//  Kreamish
//
//  Created by 안종표 on 2023/05/13.
//

import UIKit

import SnapKit

final class BannerTableViewCell: UITableViewCell {
    private var imageList: [UIImage] = [
        UIImage(named: "Kream_1")!,
        UIImage(named: "Kream_2")!,
        UIImage(named: "Kream_3")!,
        UIImage(named: "Kream_4")!
    ]
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
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: "BannerCollectionViewCell")
        return collectionView
    }()

    func setUp() {
        self.configureUI()
    }
}

extension BannerTableViewCell {
    private func configureUI() {
        self.contentView.addSubview(collectionView)
        self.collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

extension BannerTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.width)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("클릭")
    }
}

extension BannerTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as? BannerCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setUp(self.imageList[indexPath.item])
        return cell
    }
}
