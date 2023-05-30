//
//  ProductViewController.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/05/18.
//

import UIKit

import SnapKit

class ProductViewController: UIViewController {
    
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
    
    lazy var productCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        return collectionView
    }()
    
    private func configure() {
        productCollectionView.allowsSelection = true
        productCollectionView.backgroundColor = .white
        
        productCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview()
            make.height.equalTo(4000)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(productCollectionView)
        
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        productCollectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.id)
        
        configure()
    }
    
}

extension ProductViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.id, for: indexPath)
        if let cell = cell as? ProductCollectionViewCell {
            cell.model = productList[indexPath.item]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected!")
    }
}

extension ProductViewController: UICollectionViewDelegateFlowLayout {
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
