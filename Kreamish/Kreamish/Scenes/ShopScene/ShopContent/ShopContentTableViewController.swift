import UIKit

class ShopContentTableViewController: UITableViewController {
    
    private let category: String    //enum으로 바꿔보기
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
        tableView.register(ShopContentTableViewCell.self, forCellReuseIdentifier: ShopContentTableViewCell.id)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 // Return the number of rows you want to display
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
            // 수정해야함. 컨텐츠 크기에 맞게 조정되도록
        case 0: return 320  //서브카테고리 영역
        case 1: return 2500 //상품 리스트 영역
        default: return 0
        }
    }
    
    // auto height
//    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    // auto height
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: ShopContentTableViewCell.id, for: indexPath) as? ShopContentTableViewCell {
            
            var viewController: UIViewController? = nil
            switch indexPath.row {
            case 0: //서브카테고리 영역
                viewController = SubCategoryViewController()
            case 1: //상품 리스트 영역
                viewController = ProductViewController()
            default:
                print("default")
            }
            if let vc = viewController {
                self.addChild(vc)
                cell.contentView.addSubview(vc.view)
                vc.didMove(toParent: self)
                vc.view.layoutIfNeeded()
            }
            return cell
        } else {
            fatalError("DequeueReusableCell failed while casting")
        }
    }
}

