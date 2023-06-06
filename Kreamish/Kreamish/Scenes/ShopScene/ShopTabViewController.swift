//
//  ShopTabViewController.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/05/11.
//

import UIKit

import Pageboy
import Tabman

final class ShopTabViewController: TabmanViewController, PageboyViewControllerDataSource, TMBarDataSource {
    private var viewControllers: [UIViewController] = []
    private lazy var tempView: UIView = {   // 상단 탭바 들어갈 자리
        return UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
    }()
    private lazy var allViewController = ShopContentTableViewController(category: "all")
    private lazy var shoesViewController = ShopContentTableViewController(category: "shoes")
    private lazy var outerViewController = ShopContentTableViewController(category: "outer")
    private lazy var topViewController = ShopContentTableViewController(category: "top")
    private lazy var bottomViewController = ShopContentTableViewController(category: "bottom")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tempView)   // 상단탭 들어갈 영역
        
        viewControllers.append(allViewController)
        viewControllers.append(shoesViewController)
        viewControllers.append(outerViewController)
        viewControllers.append(topViewController)
        viewControllers.append(bottomViewController)
        
        self.dataSource = self
        self.isScrollEnabled = false    // 스와이프로 안움직이게 임시 처리.
        
        let bar = TMBar.ButtonBar()
        setTabBar(bar: bar)
        addBar(bar, dataSource: self, at: .custom(view: tempView, layout: nil)) // .custom을 통해 원하는 뷰에 삽입함.
    }
    
    func setTabBar(bar: TMBar.ButtonBar) {
        bar.backgroundView.style = .blur(style: .light)
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        bar.buttons.customize { (button) in
            button.tintColor = .black
            button.selectedTintColor = .black // 선택 되어 있을 때
            button.font = .systemFont(ofSize: 16, weight: .light)
            button.selectedFont = .boldSystemFont(ofSize: 16)
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
        switch index {
        case 0:
            return TMBarItem(title: "전체")
        case 1:
            return TMBarItem(title: "신발")
        case 2:
            return TMBarItem(title: "아우터")
        case 3:
            return TMBarItem(title: "상의")
        case 4:
            return TMBarItem(title: "하의")
        default:
            let title = "Page \(index)"
            return TMBarItem(title: title)
        }
    }
}
