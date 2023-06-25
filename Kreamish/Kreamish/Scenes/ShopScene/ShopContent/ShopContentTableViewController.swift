import UIKit

enum Item {
    case subCategory
    case filter
    case product
}

class ShopContentTableViewController: UITableViewController {

    private let category: String    //enum으로 바꿔보기
    
    private var items: [Item] = [
        .subCategory,
        .filter,
        .product
    ]
    
    init(category: String) {    //데이터 관련 초기화
        self.category = category
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {   //뷰 관련 초기화
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // auto height
//        tableView.rowHeight = UITableView.automaticDimension;
//        tableView.estimatedRowHeight = 200;
        // auto height
        tableView.separatorInset.left = 0
        tableView.allowsSelection = false
        tableView.register(SubCategoryTableViewCell.self, forCellReuseIdentifier: SubCategoryTableViewCell.id)
        tableView.register(FilterTableViewCell.self, forCellReuseIdentifier: FilterTableViewCell.id)
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.id)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count // Return the number of rows you want to display
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch items[indexPath.item] {
        case .subCategory:
            return SubCategoryTableViewCell.cellHeight
        case .filter:
            return FilterTableViewCell.cellHeight
        case .product:
            return ProductTableViewCell.cellHeight // 수정해야함. 컨텐츠 크기에 맞게 조정되도록
        }
    }
    
    // auto height
//    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    // auto height
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch items[indexPath.item] {
        case .subCategory:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SubCategoryTableViewCell.id) as? SubCategoryTableViewCell {
                cell.setUp()
                return cell
            } else {
                return UITableViewCell()
            }
        case .filter:
            if let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.id) as? FilterTableViewCell {
                cell.setUp()
                cell.selectFilterCellClosure = { [weak self] index in
                    let filterPopupViewController = FilterPopupViewController(index: index)
                    self?.present(filterPopupViewController, animated: true)
                }
                return cell
            } else {
                return UITableViewCell()
            }
        case .product:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.id) as? ProductTableViewCell {
                cell.setUp()
                return cell
            } else {
                return UITableViewCell()
            }
        }
    }
}
