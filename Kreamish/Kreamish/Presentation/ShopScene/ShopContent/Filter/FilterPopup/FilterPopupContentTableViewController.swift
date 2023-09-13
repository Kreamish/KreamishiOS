
import Combine
import UIKit

import SnapKit

class FilterPopupContentTableViewController: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    var filterId: Int = 0
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
        self.filterId = filterId
        self.viewModel = viewModel
        viewModel.$currentSubFilterList
            .sink { [weak self] updatedSubFilterList in
                guard let subFilterList = updatedSubFilterList else {
                    return
                }
                self?.subFilterList = subFilterList
                self?.configureUI()
            }
            .store(in: &cancellables)
        
        viewModel.getSubFilters(filterId: filterId)
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
        cell.setup(subFilter: self.subFilterList![indexPath.row])
        return cell
    }
}
extension FilterPopupContentTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        tableView.cellForRow(at: indexPath)?.selectionStyle = .none
    }
}
