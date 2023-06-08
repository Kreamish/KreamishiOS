//
//  FilterTableViewCell.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/06/06.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    
    static var id: String {
        NSStringFromClass(Self.self).components(separatedBy: ".").last ?? ""
    }
    static let cellHeight = 70.0
    
    private let filterList: [String] = ["카테고리", "성별", "브랜드", "사이즈", "가격"]
    
    private lazy var filterCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.id)
        return collectionView
    }()
    
    private func configureUI() {
        self.contentView.addSubview(filterCollectionView)
        filterCollectionView.snp.makeConstraints {
            $0.leading.tr
            $0.height.equalToSuperview()
        }
    }
    
    func setUp() {
        self.configureUI()
    }
}

extension FilterTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.id, for: indexPath) as? FilterCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.model = filterList[indexPath.item]
        cell.setUp()
        return cell
    }
}

extension FilterTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.id, for: indexPath) as? FilterCollectionViewCell else {
            return .zero
        }
        cell.label.text = filterList[indexPath.item]
        cell.label.sizeToFit()  // sizeToFit() : 텍스트에 맞게 사이즈가 조절
        let width = cell.label.frame.width + 40
        let height: CGFloat = 40.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
}
