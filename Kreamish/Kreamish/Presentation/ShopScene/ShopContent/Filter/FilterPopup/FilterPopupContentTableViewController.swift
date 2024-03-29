
import Combine
import UIKit

import SnapKit

class FilterPopupContentTableViewController: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    var filterId: Int = -1
    var subFilterList: [SubFilter]?
    var viewModel: FilterViewModel?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FilterPopupContentTableViewCell.self, forCellReuseIdentifier: FilterPopupContentTableViewCell.id)
        return tableView
    }()
    func setUp(filterId: Int, viewModel: FilterViewModel) {
        self.viewModel = viewModel
        self.filterId = filterId
        switch self.filterId {
        case Constants.FILTER_CATEGORIES_ID:
            viewModel.$currentCategoriesSubFilterList
                .sink { [weak self] updatedSubFilterList in
                    if !updatedSubFilterList.isEmpty {
                        self?.subFilterList = updatedSubFilterList
                        self?.configureUI()
                    }
                }
                .store(in: &cancellables)
            
            viewModel.getSubFilters(filterId: filterId)
        case Constants.FILTER_BRANDS_ID:
            viewModel.$currentBrandsSubFilterList
                .sink { [weak self] updatedSubFilterList in
                    if !updatedSubFilterList.isEmpty {
                        self?.subFilterList = updatedSubFilterList
                        self?.configureUI()
                    }
                }
                .store(in: &cancellables)
            
            viewModel.getSubFilters(filterId: filterId)
        default:
            print("the filterId doesn't exist.")
        }
    }
    func configureUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(FilterPopupTabViewController.filterPopupTabViewHeight)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension FilterPopupContentTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subFilterList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterPopupContentTableViewCell.id, for: indexPath) as? FilterPopupContentTableViewCell else {
            return UITableViewCell()
        }
        cell.setup(viewModel: viewModel!, filterId: self.filterId, subFilter: self.subFilterList![indexPath.row])
        return cell
    }
}
extension FilterPopupContentTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        tableView.cellForRow(at: indexPath)?.selectionStyle = .none
    }
}
