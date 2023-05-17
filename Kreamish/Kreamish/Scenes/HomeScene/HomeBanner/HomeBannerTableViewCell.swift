//
//  BannerTableViewCell.swift
//  Kreamish
//
//  Created by 안종표 on 2023/05/13.
//

import UIKit

import SnapKit

final class HomeBannerTableViewCell: UITableViewCell {
    private var imageList: [UIImage] = [
        UIImage(named: "Kream_1")!,
        UIImage(named: "Kream_2")!,
        UIImage(named: "Kream_3")!,
        UIImage(named: "Kream_4")!
    ]
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
        collectionView.register(HomeBannerCollectionViewCell.self, forCellWithReuseIdentifier: "BannerCollectionViewCell")
        return collectionView
    }()
    private lazy var indicatorView: IndicatorView = {
        let indicatorView = IndicatorView()
        return indicatorView
    }()
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        indicatorViewWidth()
    }
    func setUp() {
        self.configureUI()
    }
}

extension HomeBannerTableViewCell {
    private func configureUI() {
        self.contentView.addSubview(collectionView)
        self.collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        self.contentView.addSubview(indicatorView)
        self.indicatorView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(30)
            $0.height.equalTo(4)
        }
    }
    private func indicatorViewWidth() {
        let allContentSizeWidth =
            self.collectionView.contentSize.width +
            self.collectionView.contentInset.left +
            self.collectionView.contentInset.right
        let showingWidth = self.collectionView.bounds.width
        self.indicatorView.trackViewWidthRatio = showingWidth / allContentSizeWidth
        self.indicatorView.layoutIfNeeded()
    }
}

extension HomeBannerTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.width)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scroll = scrollView.contentOffset.x + scrollView.contentInset.left
        let width = scrollView.contentSize.width + scrollView.contentInset.left + scrollView.contentInset.right
        let scrollRatio = scroll / width
        self.indicatorView.trackViewLeftOffsetRatio = scrollRatio
    }
}

extension HomeBannerTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageList.count
    }
    func collectionView
    (
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(
                    withReuseIdentifier: "BannerCollectionViewCell",
                    for: indexPath
                ) as? HomeBannerCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setUp(self.imageList[indexPath.item])
        return cell
    }
}
