//
//  BannerCollectionViewCell.swift
//  Kreamish
//
//  Created by 안종표 on 2023/05/13.
//

import UIKit

import SnapKit

final class BannerCollectionViewCell: UICollectionViewCell {
    private lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var separatorView: SeparatorView = {
        let view = SeparatorView()
        view.backgroundColor = .opaqueSeparator
        return view
    }()
    func setUp(_ bannerImage: UIImage) {
        self.bannerImageView.image = bannerImage
        self.configureUI()
    }
}

extension BannerCollectionViewCell {
    func configureUI() {
        [
            self.bannerImageView,
            self.separatorView
        ].forEach {
            self.addSubview($0)
        }
        self.bannerImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        self.separatorView.snp.makeConstraints {
            $0.height.equalTo(15)
            $0.leading.equalTo(self.bannerImageView.snp.leading).inset(15)
            $0.trailing.equalTo(self.bannerImageView.snp.trailing).inset(15)
            $0.bottom.equalTo(self.bannerImageView.snp.bottom).inset(30)
        }
    }
}
