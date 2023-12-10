
import UIKit

enum Item {
    case subCategory
    case filter
    case product
}

class ShopContentTableViewController: UITableViewController {
    
    private let category: Category    // enum으로 바꿔보기
    
    private var items: [Item] = [
        .subCategory,
        .filter,
        .product
    ]
    
    var filterTableViewCell: FilterTableViewCell? = nil
    var productTableViewCell: ProductTableViewCell? = nil
    
    var filterViewModel: FilterViewModel? = nil
    var productListViewModel: ProductListViewModel? = nil
    
    init(category: Category) {    // 데이터 관련 초기화
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
        tableView.register(TrendingKeywordTableViewCell.self, forCellReuseIdentifier: TrendingKeywordTableViewCell.id)
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
            return TrendingKeywordTableViewCell.cellHeight
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
            if let cell = tableView.dequeueReusableCell(withIdentifier: TrendingKeywordTableViewCell.id) as? TrendingKeywordTableViewCell {
                cell.setUp()
                return cell
            } else {
                return UITableViewCell()
            }
        case .filter:
            filterTableViewCell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.id) as? FilterTableViewCell
            
            if let cell = filterTableViewCell {
                
                // DI. 나중에 DI Container로 빼야하나?
                let dataTransferService = DefaultDataTransferService(
                    with: DefaultNetworkService(config: ApiDataNetworkConfig(baseURL: URL(string: Constants.DEFAULT_DOMAIN)!))
                )
                let subFiltersRepository = DefaultSubFiltersRepository(dataTransferService: dataTransferService)
                let getSubFiltersUseCase = DefaultGetSubFiltersUseCase(subFiltersRepository: subFiltersRepository)
                self.filterViewModel = FilterViewModel(getSubFiltersUseCase: getSubFiltersUseCase)
                // DI. 나중에 DI Container로 빼야하나?
                
                cell.setUp(viewModel: filterViewModel!)
                cell.selectFilterCellClosure = { [weak self] index in
                    let filterPopupViewController = FilterPopupViewController(viewModel: self!.filterViewModel!, selectedFilterId: index)
                    filterPopupViewController.delegate = self
                    self?.present(filterPopupViewController, animated: true)
                }
                return cell
            } else {
                return UITableViewCell()
            }
        case .product:
            productTableViewCell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.id) as? ProductTableViewCell
            if let cell = productTableViewCell {
                // DI. 나중에 DI Container로 빼야하나?
                let dataTransferService = DefaultDataTransferService(
                    with: DefaultNetworkService(config: ApiDataNetworkConfig(baseURL: URL(string: Constants.DEFAULT_DOMAIN)!))
                )
                let productsRepository = DefaultProductsRepository(dataTransferService: dataTransferService)
                let getProductsUseCase = DefaultGetProductsUseCase(productsRepository: productsRepository)
                
                self.productListViewModel = ProductListViewModel(getProductsUseCase: getProductsUseCase, categoryIds: "", brandIds: "", collectionIds: "")
                // DI. 나중에 DI Container로 빼야하나?
                
                cell.delegate = self
                
                cell.setUp(viewModel: self.productListViewModel!, category: self.category)
//                cell.delegate = self
                return cell
            } else {
                return UITableViewCell()
            }
        }
    }
}


extension ShopContentTableViewController: FilterSelectDelegate {
    // FilterPopupViewController로부터 선택된 필터 정보 받아서 ProductTableViewCell에 전달.
    func submitSelectedFilterIds(categoryIds: String, brandIds: String, collectionIds: String) {
        productTableViewCell?.loadProductList(categoryIds: categoryIds, brandIds: brandIds, collectionIds: collectionIds)
    }
}

extension ShopContentTableViewController: ProductTableViewCellDelegate {
    func openProductDetail(product: Product) {
        let vc = ProductDetailViewController()
        vc.setUp(productId: product.productId)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    func openfavoritePopup(product: Product?) {
        // 북마크 팝업 열기
        let vc = FavoritePopupViewController()
        vc.setUp(product: product)
        self.present(vc, animated: true)
    }
}
