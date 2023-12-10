import UIKit

class FavoritePopupViewController: DimmedViewController {

    var product: Product?
    
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
        titleLabel.text = "관심 상품 추가"
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
    
    lazy var sizeCollectionView: UICollectionView = {
        let collectionVC = FavoritePopupCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        collectionVC.viewModel = FavoriteViewModel()
        self.addChild(collectionVC)  // collectionVC를 현재 VC에 추가.
        return collectionVC.collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    func setUp(product: Product?) {
        self.product = product
    }
    
    func configureUI() {
        stackView.addArrangedSubview(navBarView)
        stackView.addArrangedSubview(sizeCollectionView)
        containerView.addSubview(stackView)
        view.addSubview(containerView)
        
        navBarView.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        sizeCollectionView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        stackView.snp.makeConstraints {
            $0.leading.top.bottom.trailing.equalToSuperview()
        }
        containerView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.top.equalToSuperview().inset(300)
        }
    }
    
    @objc private func close() {
        self.dismiss(animated: true)
    }
}
