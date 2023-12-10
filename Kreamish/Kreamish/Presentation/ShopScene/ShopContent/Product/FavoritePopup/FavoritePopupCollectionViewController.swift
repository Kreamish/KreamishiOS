//
//  FavoritePopupCollectionViewController.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/11/04.
//

import UIKit

private let reuseIdentifier = FavoritePopupCollectionViewCell.id

class FavoritePopupCollectionViewController: UICollectionViewController {

    var viewModel: FavoriteViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 기본 설정
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.backgroundColor = .white
        collectionView.isUserInteractionEnabled = true
        self.collectionView.register(FavoritePopupCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.allowsMultipleSelection = true
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.sizeList.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FavoritePopupCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setUp(size: (viewModel?.sizeList[indexPath.item]))
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension FavoritePopupCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.layer.frame.width / 3) - 10
        let height: CGFloat = 60.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
