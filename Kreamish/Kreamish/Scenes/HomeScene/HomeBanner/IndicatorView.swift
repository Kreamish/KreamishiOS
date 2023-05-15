//
//  SeparatoreView.swift
//  Kreamish
//
//  Created by 안종표 on 2023/05/13.
//

import UIKit

import SnapKit

final class IndicatorView: UIView {
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .opaqueSeparator
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension IndicatorView {
    private func configureUI() {
        self.addSubview(separatorView)
        self.separatorView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
}
