//
//  SeparatoreView.swift
//  Kreamish
//
//  Created by 안종표 on 2023/05/13.
//

import UIKit

import SnapKit

final class IndicatorView: UIView {
    private var trackViewLeftInsetConstraint: Constraint?
    var trackViewWidthRatio: Double? {
      didSet {
        guard let widthRatio = self.trackViewWidthRatio else { return }
        self.trackView.snp.remakeConstraints {
          $0.top.bottom.equalToSuperview()
          $0.width.equalToSuperview().multipliedBy(widthRatio)
          $0.left.greaterThanOrEqualToSuperview()
          $0.right.lessThanOrEqualToSuperview()
          self.trackViewLeftInsetConstraint = $0.left.equalToSuperview().priority(999).constraint
        }
      }
    }
    var trackViewLeftOffsetRatio: Double? {
      didSet {
        guard let leftOffsetRatio = self.trackViewLeftOffsetRatio else { return }
        self.trackViewLeftInsetConstraint?.update(inset: leftOffsetRatio * self.bounds.width)
      }
    }
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.5)
        return view
    }()
    private lazy var trackView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
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
        self.addSubview(lineView)
        self.lineView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(3.0)
        }
        self.lineView.addSubview(trackView)
        self.trackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
            self.trackViewLeftInsetConstraint = $0.left.equalToSuperview().priority(999).constraint
        }
    }
}
