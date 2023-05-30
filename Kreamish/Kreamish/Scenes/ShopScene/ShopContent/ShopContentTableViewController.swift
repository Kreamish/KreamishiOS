import UIKit

class ShopContentTableViewController: UITableViewController {
    
    private let category: String    //enum으로 바꿔보기
    init(category: String) {
        self.category = category
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.register(ShopContentTableViewCell.self, forCellReuseIdentifier: ShopContentTableViewCell.id)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 // Return the number of rows you want to display
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return 200
        case 1: return 2500
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: ShopContentTableViewCell.id, for: indexPath) as? ShopContentTableViewCell {
            cell.layoutIfNeeded()
            
            switch indexPath.row {
            case 0: //서브카테고리 collection view
                let subCategoryViewController = UICollectionViewController()
            case 1: //상품 collection view
                let productViewController = ProductViewController()
                self.addChild(productViewController)
                cell.addSubview(productViewController.view)
                
                productViewController.didMove(toParent: self)
                productViewController.view.layoutIfNeeded()
            default:
                print("default")
            }
            return cell
        } else {
            fatalError("DequeueReusableCell failed while casting")
        }
    }
}

