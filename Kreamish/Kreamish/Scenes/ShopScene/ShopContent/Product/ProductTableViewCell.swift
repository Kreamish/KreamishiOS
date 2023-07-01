//
//  ProductTableViewCell.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/05/18.
//

import UIKit

import iOSDropDown
import SnapKit

class ProductTableViewCell: UITableViewCell {
    static var id: String {
        NSStringFromClass(Self.self).components(separatedBy: ".").last ?? ""
    }
    static let cellHeight = 3000.0
    
    // swiftlint:disable line_length
    private let productList: [Product] = [
        Product(englishName: "LANCER Mens ACTIVE-100 Blue Running Shoe - 7 UK (ACTIVE-100NBL-MSTD-7)", brand: "Reebok", category: "Shoes", price: "119,900", imgUrl: "https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T2/images/I/81K-j6yqNXL._AC_UL320_.jpg"),
        Product(englishName: "Wilson mens KAOS Stroke 2.0 India Ink/White/Vivid Blue Tennis Shoe - 10 UK (WRS328850U105)", brand: "New Balance", category: "Shoes", price: "999,900", imgUrl: "https://m.media-amazon.com/images/I/81uis1XGjKL._AC_UL320_.jpg"),
        Product(englishName: "Men's Jordan 1 Retro High OG Rebellionaire Blk/Wht-Particle Grey (555088 036)", brand: "Nike", category: "Shoes", price: "6,299,300", imgUrl:"https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/61HcA++bNJL._AC_UL320_.jpg"),
        Product(englishName: "Nike Mens Jordan 3 Retro Basketball Shoes", brand: "Skechers", category: "Shoes", price: "6299300", imgUrl: "https://m.media-amazon.com/images/I/51tWQy69c6L._AC_UL320_.jpg"),
        Product(englishName: "Nike Men's Shoes Jordan 1 High Zoom Air CMFT Black Monarch CT0978-002", brand: "Nike", category: "Shoes", price: "6,299,000", imgUrl: "https://m.media-amazon.com/images/I/61IgNNMa0ZL._AC_UL320_.jpg"),
        Product(englishName: "Nike Jordan 1 Mid Pink Black", brand: "Under Armour", category: "Shoes", price: "6121000", imgUrl: "https://m.media-amazon.com/images/I/71cBbSQiQ0L._AC_UL320_.jpg"),
        Product(englishName: "LANCER Mens ACTIVE-100 Blue Running Shoe - 7 UK (ACTIVE-100NBL-MSTD-7)", brand: "Reebok", category: "Shoes", price: "119,900", imgUrl: "https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T2/images/I/81K-j6yqNXL._AC_UL320_.jpg"),
        Product(englishName: "Wilson mens KAOS Stroke 2.0 India Ink/White/Vivid Blue Tennis Shoe - 10 UK (WRS328850U105)", brand: "New Balance", category: "Shoes", price: "999,900", imgUrl: "https://m.media-amazon.com/images/I/81uis1XGjKL._AC_UL320_.jpg"),
        Product(englishName: "Men's Jordan 1 Retro High OG Rebellionaire Blk/Wht-Particle Grey (555088 036)", brand: "Nike", category: "Shoes", price: "6,299,300", imgUrl:"https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/61HcA++bNJL._AC_UL320_.jpg"),
        Product(englishName: "Nike Mens Jordan 3 Retro Basketball Shoes", brand: "Skechers", category: "Shoes", price: "6299300", imgUrl: "https://m.media-amazon.com/images/I/51tWQy69c6L._AC_UL320_.jpg"),
        Product(englishName: "Nike Men's Shoes Jordan 1 High Zoom Air CMFT Black Monarch CT0978-002", brand: "Nike", category: "Shoes", price: "6,299,000", imgUrl: "https://m.media-amazon.com/images/I/61IgNNMa0ZL._AC_UL320_.jpg"),
        Product(englishName: "Nike Jordan 1 Mid Pink Black", brand: "Under Armour", category: "Shoes", price: "6,121,000", imgUrl: "https://m.media-amazon.com/images/I/71cBbSQiQ0L._AC_UL320_.jpg")
    ]
    // swiftlint:disable line_length
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.text = "상품 " + "110,362"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return label
    }()

    let sortDropDown: DropDown = {
        let dropDown = DropDown()
        dropDown.optionArray = ["인기순", "즉시 구매가순", "즉시 판매가순", "관심 많은순", "발매일순"]
        dropDown.font = UIFont.systemFont(ofSize: 16, weight: .light)
        dropDown.text = dropDown.optionArray[0]
        dropDown.textAlignment = .left
        dropDown.isSearchEnable = false
        dropDown.checkMarkEnabled = false
        dropDown.selectedRowColor = .lightGray
        dropDown.selectedIndex = 0
        dropDown.arrowSize = 16
        dropDown.rowHeight = 60
        dropDown.listHeight = dropDown.rowHeight * CGFloat(dropDown.optionArray.count)
        return dropDown
    }()

    lazy var productCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = true
        collectionView.backgroundColor = .white
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.id)
        return collectionView
    }()
    
    private func configureUI() {
        self.contentView.addSubview(countLabel)
        self.contentView.addSubview(sortDropDown)
        self.contentView.addSubview(productCollectionView)
        countLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
        }
        sortDropDown.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(140)
            $0.height.equalTo(countLabel.snp.height)
        }
        productCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(countLabel.snp.bottom).offset(20)
            $0.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).inset(20)
            $0.centerX.equalToSuperview()
//            $0.height.lessThanOrEqualTo()
        }
    }
    
    func setUp() {
        self.configureUI()
    }
    
}

extension ProductTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.id, for: indexPath)
        guard let cell = cell as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.model = productList[indexPath.item]
        cell.setup()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected!")
    }
}

extension ProductTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 5
        //            let lineSpacing: CGFloat = 10
        let width: CGFloat = (collectionView.bounds.width - itemSpacing) / 2
        let height: CGFloat = width * 2.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

struct Product {
    let englishName: String
    let brand: String
    let category: String
    let price: String
    let imgUrl: String
}
