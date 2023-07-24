//
//  ShopTabViewController.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/05/11.
//
import Combine
import UIKit

import Pageboy
import Tabman

final class ShopTabViewController: TabmanViewController, PageboyViewControllerDataSource, TMBarDataSource {
    private var viewModel = ShopTabViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private var viewControllers: [UIViewController] = []
    private lazy var tempView: UIView = {   // 상단 탭바 들어갈 자리
        return UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getCategoryList()
    }
    private func bind() {
        //categoryList 로딩 다 되면 받아서 viewControllers에 넣는다
    }
    func configureUI() {
        view.addSubview(tempView)   // 상단탭 들어갈 영역
        
        guard let categoryList = viewModel?.categoryList else {
            return
        }
        for i in 0..<viewModel!.categoryList.count {
            viewControllers.append(ShopContentTableViewController(category: viewModel!.categoryList[i]))
        }

        self.dataSource = self
        self.isScrollEnabled = false    // 스와이프로 안움직이게 임시 처리.
        
        let bar = TMBar.ButtonBar()
        setTabBar(bar: bar)
        addBar(bar, dataSource: self, at: .custom(view: tempView, layout: nil)) // .custom을 통해 원하는 뷰에 삽입함.
    }
    
    func setTabBar(bar: TMBar.ButtonBar) {
        bar.backgroundView.style = .flat(color: UIColor.white)
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        bar.buttons.customize { (button) in
            button.tintColor = .black
            button.selectedTintColor = .black // 선택 되어 있을 때
            button.font = .systemFont(ofSize: 18, weight: .light)
            button.selectedFont = .boldSystemFont(ofSize: 18)
        }
        // 인디케이터 조정
        bar.indicator.weight = .light
        bar.indicator.tintColor = .black
        bar.indicator.overscrollBehavior = .compress
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        bar.layout.interButtonSpacing = 0 // 버튼 사이 간격
        
        bar.layout.transitionStyle = .snap // Customize
    }
    
    // PageboyViewControllerDataSource
    func numberOfViewControllers(
        in pageboyViewController: Pageboy.PageboyViewController
    ) -> Int {
        viewControllers.count
    }

    func viewController(
        for pageboyViewController: Pageboy.PageboyViewController,
        at index: Pageboy.PageboyViewController.PageIndex
    ) -> UIViewController? {
        viewControllers[index]
    }

    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        return .at(index: 0)
    }

    // TMBarDataSource
    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
        return TMBarItem(title: viewModel?.categoryList[index].name ?? "undefined")
    }
}
