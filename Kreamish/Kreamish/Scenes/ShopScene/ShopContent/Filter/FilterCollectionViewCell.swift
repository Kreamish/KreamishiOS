//
//  FilterCollectionViewCell.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/06/06.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    static var id: String {  // computed property. 메모리 공간 가지지 않음.
        NSStringFromClass(Self.self).components(separatedBy: ".").last ?? ""
    }
    
    var model: String? {
        didSet {    // model의 값이 변경된 직후 호출.
            bind()
        }
    }
    
    var label: UILabel = {
        let label = UILabel()
        label.text = "카테고리"
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    private func setLabelText(text: String) {
        let attributedString = NSMutableAttributedString(string: "")
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "arrow.down")?.withTintColor(.systemGray3)
        attributedString.append(NSAttributedString(string: text + " "))
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        label.attributedText = attributedString
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func configureUI() {
        self.contentView.layer.cornerRadius = contentView.bounds.height / 2.3
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.systemGray5.cgColor
        self.contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func setUp() {
        self.configureUI()
    }
    
    private func bind() {
        if let model = model {
            setLabelText(text: model)
        }
    }
}
