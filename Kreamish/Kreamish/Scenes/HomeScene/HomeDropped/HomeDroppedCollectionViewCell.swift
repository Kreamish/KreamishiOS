//
//  HomeDroppedCollectionViewCell.swift
//  Kreamish
//
//  Created by 안종표 on 2023/05/25.
//

import UIKit

import SnapKit

final class HomeDroppedCollectionViewCell: UICollectionViewCell {
    private lazy var goodsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var bookMarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        return button
    }()
    private lazy var goodsNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    private lazy var goodsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    private lazy var goodsPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    private lazy var immediatelyBuyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 9, weight: .thin)
        label.textAlignment = .left
        label.text = DroppedText.immediatelyText.rawValue
        return label
    }()
    func setUp(_ goodsImage: UIImage, _ goodsName: String, _ goodsDescription: String, _ goodsPrice: String) {
        self.goodsImageView.image = goodsImage
        self.goodsNameLabel.text = goodsName
        self.goodsDescriptionLabel.text = goodsDescription
        self.goodsPriceLabel.text = goodsPrice
    }
}
extension HomeDroppedCollectionViewCell {
    private func configureUI() {
        self.addSubview(self.goodsImageView)
        self.goodsImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        self.addSubview(self.bookMarkButton)
        self.bookMarkButton.snp.makeConstraints {
            $0.trailing.equalTo(self.goodsImageView.snp.trailing).inset(20)
            $0.bottom.equalTo(self.goodsImageView.snp.bottom).inset(15)
            $0.width.equalTo(40)
            $0.height.equalTo(40)
        }
        self.addSubview(self.goodsNameLabel)
        self.goodsNameLabel.snp.makeConstraints {
            $0.top.equalTo(self.goodsImageView.snp.bottom).offset(13)
            $0.leading.equalTo(self.goodsImageView.snp.leading).inset(5)
            $0.trailing.equalTo(self.goodsImageView.snp.trailing).inset(5)
        }
        self.addSubview(self.goodsDescriptionLabel)
        self.goodsDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(self.goodsNameLabel.snp.bottom).offset(6)
            $0.leading.equalTo(self.goodsNameLabel.snp.leading)
            $0.trailing.equalTo(self.goodsNameLabel.snp.trailing)
        }
        self.addSubview(self.goodsPriceLabel)
        self.goodsPriceLabel.snp.makeConstraints {
            $0.top.equalTo(self.goodsDescriptionLabel.snp.bottom).offset(13)
            $0.leading.equalTo(self.goodsNameLabel.snp.leading)
            $0.trailing.equalTo(self.goodsNameLabel.snp.trailing)
        }
        self.addSubview(self.immediatelyBuyLabel)
        self.immediatelyBuyLabel.snp.makeConstraints {
            $0.top.equalTo(self.goodsPriceLabel.snp.bottom)
            $0.leading.equalTo(self.goodsNameLabel.snp.leading)
            $0.trailing.equalTo(self.goodsNameLabel.snp.trailing)
        }
    }
}
