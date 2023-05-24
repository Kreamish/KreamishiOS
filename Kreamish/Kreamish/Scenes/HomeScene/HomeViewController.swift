//
//  HomeViewController.swift
//  Kreamish
//
//  Created by 안종표 on 2023/05/13.
//

import UIKit

import SnapKit

enum KindOfCell {
    case banner(viewModel: HomeViewModel)
    case recommendCategory(viewModel: HomeViewModel)
}

final class HomeViewController: UIViewController {
    private var viewModel: HomeViewModel?
    private var cellList: [UITableViewCell] = []
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemBackground
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(
            HomeBannerTableViewCell.self,
            forCellReuseIdentifier: "HomeBannerTableViewCell"
        )
        tableView.register(
            HomeRecommendCategoryTableViewCell.self,
            forCellReuseIdentifier: "HomeRecommendCategoryTableViewCell"
        )
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = HomeViewModel()
        self.configureUI()
    }
}
extension HomeViewController {
    private func configureUI() {
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 2
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("클릭")
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = self.viewModel else { return UITableViewCell() }
        let cells: [KindOfCell] = [
            .banner(viewModel: viewModel),
            .recommendCategory(viewModel: viewModel)
        ]
        switch cells[indexPath.item] {
        case let .banner(viewModel: viewModel):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "HomeBannerTableViewCell"
            ) as? HomeBannerTableViewCell else {
                return UITableViewCell()
            }
            cell.setUp(viewModel: viewModel)
            return cell
        case let .recommendCategory(viewModel: viewModel):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "HomeRecommendCategoryTableViewCell"
            ) as? HomeBannerTableViewCell else {
                return UITableViewCell()
            }
            cell.setUp(viewModel: viewModel)
            return cell
        }
    }
}
