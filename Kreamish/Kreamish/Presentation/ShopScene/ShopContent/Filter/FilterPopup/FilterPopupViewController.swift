
import Combine
import UIKit

import Pageboy
import SnapKit
import Tabman

class FilterPopupViewController: DimmedViewController {

//    var filteredProductCnt: Int = 0
    var selectedFilterId: Int = 0
    var viewModel: FilterViewModel?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
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
        
        let closeButton = UIButton()
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .black
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        
        let titleLabel = UILabel()
        titleLabel.text = "필터"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        closeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        return view
    }()
    private lazy var tabViewController: UIViewController = {
        guard let viewModel = self.viewModel else {
            return UIViewController()
        }
        return FilterPopupTabViewController(viewModel: viewModel, selectedFilterId: self.selectedFilterId)
    }()
    private lazy var selectedItemView: UIView = {   // 선택한 필터 아이템 일렬로 표출.
        let view = UIView()
        return view
    }()
    private lazy var bottomBarView: UIView = {
        let view = UIView()
        
        let initButton = UIButton()
        initButton.setImage(.init(systemName: "arrow.clockwise"), for: .normal)
        initButton.setTitle(" 초기화", for: .normal)
        initButton.tintColor = .black
        initButton.setTitleColor(.black, for: .normal)
        
        let submitButton = UIButton()
        submitButton.setTitle("상품 보기", for: .normal)
        submitButton.titleLabel!.font = .boldSystemFont(ofSize: 20)
        submitButton.backgroundColor = .black
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 10
        submitButton.layer.masksToBounds = true
        submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
        view.addSubview(initButton)
        view.addSubview(submitButton)
        
        initButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(80)
        }
        submitButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.leading.equalTo(initButton.snp.trailing).offset(20)
        }
        return view
    }()
    
    @objc func submit() {
        print("선택한 카테고리:\n \(viewModel?.selectedCategoryItems)")
        print("선택한 브랜드:\n \(viewModel?.selectedBrandItems)")
        // 이제 여기서 상품 검색!!!
        // productListViewModel의 메소드 호출하면되는데... 어떻게??
        // 일단 싱글톤은 X
    }
    
    @objc private func close() {
        self.dismiss(animated: true)
    }
    
    init(viewModel: FilterViewModel, selectedFilterId: Int) {
        self.selectedFilterId = selectedFilterId
        self.viewModel = viewModel
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
        stackView.addArrangedSubview(tabViewController.view)
        stackView.addArrangedSubview(bottomBarView)
        
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
            $0.height.equalTo(60)
        }
        bottomBarView.snp.makeConstraints {
            $0.height.equalTo(100)
        }
        addChild(tabViewController)
        tabViewController.didMove(toParent: self)
    }
}
