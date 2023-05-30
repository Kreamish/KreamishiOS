//
//  SubCategoryViewController.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/05/30.
//

import UIKit

class SubCategoryViewController: UIViewController {

    
    private lazy var subCategorycollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

struct SubCategory {
    let name: String
    let imgUrl: String
}
