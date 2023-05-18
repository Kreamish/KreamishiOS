//
//  BannerTableViewCell.swift
//  Kreamish
//
//  Created by 안종표 on 2023/05/13.
//

import Combine
import UIKit

import SnapKit

final class HomeBannerTableViewCell: UITableViewCell {
    private var subscription = Set<AnyCancellable>()
    private var viewModel: HomeViewModel?
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
        guard let viewModel = viewModel else {return IndicatorView()}
        let indicatorView = IndicatorView(viewModel: viewModel)
        return indicatorView
    }()
//    convenience init() {
//        self.init(frame: .zero)
//
//    }
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        self.bindWidthRatio(
            self.collectionView.contentSize.width,
            self.collectionView.contentInset.left,
            self.collectionView.contentInset.right,
            self.collectionView.bounds.width
        )
    }
    func setUp(viewModel: HomeViewModel) {
        self.viewModel = viewModel
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
    private func bindWidthRatio(
        _ contentSizeWidth: Double,
        _ contentInsetLeft: CGFloat,
        _ contentInsetRight: CGFloat,
        _ showingWidth: Double
    ) {
        guard let homeViewModel = self.viewModel else {return}
        homeViewModel.computeWidthRatio(
            contentSizeWidth,
            contentInsetLeft,
            contentInsetRight,
            showingWidth
        )
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
        guard let viewModel = viewModel else {return}
        viewModel.computeLeftOffsetRatio(
            scrollView.contentSize.width,
            scrollView.contentOffset.x,
            scrollView.contentInset.left,
            scrollView.contentInset.right
        )
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
