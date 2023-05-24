//
//  RecommendCategoryTableViewCell.swift
//  Kreamish
//
//  Created by 안종표 on 2023/05/24.
//

import UIKit

final class HomeRecommendCategoryTableViewCell: UITableViewCell {
    private let images: [UIImage] = [
        UIImage(systemName: "square.and.arrow.up")!,
        UIImage(systemName: "square.and.arrow.up.fill")!,
        UIImage(systemName: "square.and.arrow.up.circle")!,
        UIImage(systemName: "square.and.arrow.up.circle.fill")!
    ]
    private let texts: [String] = [
        "Test용 입니다1",
        "Test용 입니다2",
        "Test용 입니다3",
        "Test용 입니다4"
    ]
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = false
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
        collectionView.register(
            HomeRecommendCategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: "HomeRecommendCategoryCollectionViewCell"
        )
        return collectionView
    }()
    func setUp() {
        self.configureUI()
    }
}
extension HomeRecommendCategoryTableViewCell {
    private func configureUI() {
        self.contentView.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
extension HomeRecommendCategoryTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (self.collectionView.bounds.width / 5)
        return CGSize(width: width, height: width + 20)
    }
}

extension HomeRecommendCategoryTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "HomeRecommendCategoryCollectionViewCell",
            for: indexPath
        ) as? HomeRecommendCategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setUp(self.images[indexPath.item], self.texts[indexPath.item])
        return cell
    }
}
