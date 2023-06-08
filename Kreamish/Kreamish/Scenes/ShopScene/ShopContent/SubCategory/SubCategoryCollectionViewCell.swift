//
//  SubCategoryCollectionViewCell.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/06/04.
//

import UIKit

import SnapKit

class SubCategoryCollectionViewCell: UICollectionViewCell {
    static var id: String {  // computed property. 메모리 공간 가지지 않음.
        NSStringFromClass(Self.self).components(separatedBy: ".").last ?? ""
    }
    
    var model: SubCategory? {
        didSet {    // model의 값이 변경된 직후 호출.
            bind()
        }
    }
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private func configureUI() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
        
        // configureUI
        iconImageView.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(iconImageView.snp.width)
        })
        nameLabel.snp.makeConstraints({ make in
            make.top.equalTo(iconImageView.snp.bottom).offset(3)
            make.centerX.equalToSuperview()
        })
    }
    func setUp() {
        self.configureUI()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    private func bind() {
        if let model = model {
            DispatchQueue.global().async {
                if let url = URL(string: model.imgUrl){
                    let data = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.iconImageView.image = UIImage(data: data!)
                    }
                }
            }
            self.nameLabel.text = model.name
        }
    }
}
