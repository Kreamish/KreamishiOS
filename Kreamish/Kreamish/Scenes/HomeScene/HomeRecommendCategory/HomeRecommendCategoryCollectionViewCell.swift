//
//  HomeRecommendCategoryCollectionViewCell.swift
//  Kreamish
//
//  Created by 안종표 on 2023/05/24.
//

import UIKit

import SnapKit

final class HomeRecommendCategoryCollectionViewCell: UICollectionViewCell {
    private lazy var recommendImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        return label
    }()
    func setUp(_ image: UIImage, _ text: String) {
        self.configureUI()
        self.recommendImageView.image = image
        self.titleLabel.text = text
    }
}

extension HomeRecommendCategoryCollectionViewCell {
    private func configureUI() {
        self.addSubview(self.recommendImageView)
        self.recommendImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(5)
            $0.trailing.equalToSuperview().inset(5)
        }
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.recommendImageView.snp.bottom).offset(5)
            $0.leading.equalTo(self.recommendImageView)
            $0.trailing.equalTo(self.recommendImageView)
            $0.bottom.equalToSuperview()
        }
    }
}
