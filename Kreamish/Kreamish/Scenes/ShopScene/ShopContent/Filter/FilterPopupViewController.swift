//
//  FilterPopupViewController.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/06/25.
//

import UIKit

import Pageboy
import SnapKit
import Tabman

class FilterPopupViewController: DimmedViewController {

    private let selectedIndex: Int
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.alignment = .fill
        return view
    }()
    private lazy var navBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "필터"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()
    private lazy var contentViewController: UIViewController = {
        return FilterPopupContentViewController(index: selectedIndex)
    }()
    
    
    @objc private func close() {
        self.dismiss(animated: true)
    }
    
    init(index: Int) {
        selectedIndex = index
        super.init()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        configureUI()
    }
    
    private func configureUI() {
        stackView.addArrangedSubview(navBarView)
        navBarView.addSubview(titleLabel)
        navBarView.addSubview(closeButton)
        stackView.addArrangedSubview(contentViewController.view)
        
        containerView.addSubview(stackView)
        view.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(260)
            $0.bottom.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.leading.top.bottom.trailing.equalToSuperview()
        }
        navBarView.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        closeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
        addChild(contentViewController)
        contentViewController.didMove(toParent: self)
    }
}
