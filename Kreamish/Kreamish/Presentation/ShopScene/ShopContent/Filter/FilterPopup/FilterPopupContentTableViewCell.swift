
import Combine
import UIKit

class FilterPopupContentTableViewCell: UITableViewCell {
    private var cancellables = Set<AnyCancellable>()
    static var id: String {
        NSStringFromClass(Self.self).components(separatedBy: ".").last ?? ""
    }
    
//    var viewModel: FilterViewModel?
    
    var allItemssSelected = false
    
    private var itemList: [FilterItem] = []
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    private lazy var selectAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("모두 선택", for: .normal)
        button.setTitleColor(.systemGray2, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(selectAllItems), for: .touchUpInside)
        return button
    }()
    private lazy var subFilterItemCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        collectionView.register(FilterPopupCollectionViewCell.self, forCellWithReuseIdentifier: FilterPopupCollectionViewCell.id)
        return collectionView
    }()
    @objc func selectAllItems() {
        allItemssSelected = !allItemssSelected
        for item in 0..<subFilterItemCollectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            if allItemssSelected {
                subFilterItemCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
            } else {
                subFilterItemCollectionView.deselectItem(at: indexPath, animated: false)
            }
        }
    }
    func configureUI() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(selectAllButton)
        contentView.addSubview(subFilterItemCollectionView)
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalTo(selectAllButton.snp.centerY)
            $0.leading.equalToSuperview().inset(20)
        }
        selectAllButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(20)
        }
        subFilterItemCollectionView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
            $0.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().inset(10)
            $0.height.greaterThanOrEqualTo(100)
        }
    }
    func setup(subFilter: SubFilter) {
        self.nameLabel.text = subFilter.subFilterName
        self.itemList = subFilter.filterItems
        configureUI()
    }
}

extension FilterPopupContentTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.itemList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterPopupCollectionViewCell.id, for: indexPath) as? FilterPopupCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setUp(item: itemList[indexPath.item])
        return cell
    }
}

extension FilterPopupContentTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterPopupCollectionViewCell.id, for: indexPath) as? FilterPopupCollectionViewCell else {
            return .zero
        }
        cell.label.text = itemList[indexPath.item].filterItemName
        cell.label.sizeToFit()  // sizeToFit() : 텍스트에 맞게 사이즈가 조절
        let width = cell.label.frame.width + 20
        let height: CGFloat = 40.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}
