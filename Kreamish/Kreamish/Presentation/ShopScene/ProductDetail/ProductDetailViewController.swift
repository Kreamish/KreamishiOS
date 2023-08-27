//
//  ProductDetailViewController.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/08/21.
//

import UIKit

class ProductDetailViewController: UIViewController {

    var product: Product?
    
    private lazy var header: UIView = {
        let view = UIView(frame:.zero)
        view.backgroundColor = .blue
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemBackground
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .orange
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp(product: product!)
        configureUI()
    }
    
    func setUp(product: Product) {
        self.product = product
    }
    
    private func configureUI() {
        self.view.addSubview(header)
        self.view.addSubview(tableView)
        
        header.snp.makeConstraints {
            $0.top.equalToSuperview().inset((statusBar?.frame.height)!)
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualTo((statusBar?.frame.height)!)
            $0.height.lessThanOrEqualTo(100)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension ProductDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
