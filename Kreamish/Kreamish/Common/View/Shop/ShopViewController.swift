//
//  ShopBaseViewController.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/05/11.
//

import UIKit

class ShopViewController: UIViewController {
    
    lazy var searchBar: UITextField = { //검색창
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray6
        textField.placeholder = "브랜드명, 모델명, 모델번호 등"
        
        return textField
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: (statusBar?.frame.height)! + 10),
            
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let shopTapViewController = ShopTabViewController()
        addChild(shopTapViewController)
        shopTapViewController.view.frame = contentView.bounds
        contentView.addSubview(shopTapViewController.view)
        shopTapViewController.didMove(toParent: self)
    }
}
