//
//  ProductCollectionViewCell.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/05/18.
//

import UIKit

import SnapKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    static var id: String {  // computed property. 메모리 공간 가지지 않음.
        NSStringFromClass(Self.self).components(separatedBy: ".").last ?? ""
    }
    
    var model: Product? {
        didSet {    // model의 값이 변경된 직후 호출.
            bind()
        }
    }
    
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()
    private lazy var brandLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    private lazy var englishNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.numberOfLines = 2
        return label
    }()
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    private lazy var priceTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .gray
        label.text = "즉시 구매가"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(brandLabel)
        contentView.addSubview(englishNameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(priceTypeLabel)
        
        thumbnailImageView.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(10)
            make.width.equalToSuperview().inset(10)
            make.height.equalTo(thumbnailImageView.snp.width)
        })
        brandLabel.snp.makeConstraints({ make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(10)
        })
        englishNameLabel.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(brandLabel.snp.bottom).offset(10)
        })
        priceLabel.snp.makeConstraints({ make in
            make.leading.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(40)
        })
        priceTypeLabel.snp.makeConstraints({ make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(priceLabel.snp.bottom).offset(4)
        })
        
        contentView.backgroundColor = .systemGray6
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind() {
        if let model = model {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: URL(string: model.imgUrl)!)
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = UIImage(data: data!)
                }
            }
            brandLabel.text = model.brand
            englishNameLabel.text = model.englishName
            priceLabel.text = model.price + "원"
        }
    }
}
