//
//  favoritePopupCollectionViewCell.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/11/04.
//

import UIKit

class FavoritePopupCollectionViewCell: UICollectionViewCell {
    
    static var id: String {  // computed property. 메모리 공간 가지지 않음.
        NSStringFromClass(Self.self).components(separatedBy: ".").last ?? ""
    }
    
    private var size: Size? = nil
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.contentView.layer.borderColor = UIColor.black.cgColor
            } else {
                self.contentView.backgroundColor = .white
                self.lbText.textColor = .black
            }
        }
    }
    
    private lazy var lbText: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return label
    }()
    private lazy var btnIcon: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        button.tintColor = .black
        return button
    }()
    
    func setUp(size: Size?) {
        self.size = size
        lbText.text = self.size?.sizeString
        configureUI()
    }

    private func configureUI() {
        self.contentView.layer.cornerRadius = contentView.bounds.height / 4.0
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.systemGray5.cgColor
        
        contentView.addSubview(lbText)
        contentView.addSubview(btnIcon)
        
        lbText.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(8)
        }
        btnIcon.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(lbText.snp.bottom).offset(4)
        }
    }
}
